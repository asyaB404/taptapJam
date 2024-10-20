using System.Collections.Generic;
using System.Linq;
using Core.Container;
using Core.Items;
using UI.Panel;
using UnityEngine;

namespace Core
{
    /// <summary>
    /// 玩家背包，底层实现使用的字典
    /// </summary>
    public class PlayerInventory : MonoBehaviour, IMyContainer
    {
        private readonly Dictionary<string, ItemStack> _itemStacksDict = new();

        //用于记录物品的插入顺序
        private readonly List<string> _insertionOrderList = new();

        /// <summary>
        /// 返回的是字典的原始集合拷贝
        /// </summary>
        public IReadOnlyCollection<ItemStack> GetItems => _itemStacksDict.Values.ToArray();

        /// <summary>
        /// 返回的是根据时间顺序加入的物品序列拷贝
        /// </summary>
        public IReadOnlyList<ItemStack> GetItemsOrderByTime =>
            _insertionOrderList.Select(id => _itemStacksDict[id]).ToArray();

        /// <summary>
        /// 背包全部物品的大小
        /// </summary>
        /// <example>例如3个A，4个B，Size则为7；正确显示的前提为不随意更改背包内部的itemStack的count</example>
        public int Size { get; private set; }

        /// <summary>
        /// 统计背包内指定个id的物品有几个
        /// </summary>
        /// <param name="id">物品id</param>
        /// <returns>背包内该id的数量</returns>
        public int Count(string id)
        {
            return _itemStacksDict.TryGetValue(id, out ItemStack item) ? item.count : 0;
        }

        /// <summary>
        /// 添加物品，注意ItemStack为引用类型，添加入背包是必须是新的ItemStack或者是拷贝
        /// </summary>
        /// <param name="newItemStack">需要添加的ItemStack</param>
        public void AddItem(ItemStack newItemStack)
        {
            string id = newItemStack.ItemInfo.id;
            int quantity = newItemStack.count;

            if (_itemStacksDict.TryGetValue(id, out ItemStack existingItemStack))
            {
                existingItemStack.count += quantity;
            }
            else
            {
                _insertionOrderList.Add(id);
                _itemStacksDict[id] = newItemStack;
            }

            Size += quantity;
            if(PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
        }

        /// <summary>
        /// 添加物品，根据信息和数量创建新的ItemStack添加至背包
        /// </summary>
        /// <param name="itemInfo">物品信息</param>
        /// <param name="count">要添加的数量</param>
        public void AddItem(ItemInfo itemInfo, int count)
        {
            string id = itemInfo.id;
            ItemStack newItemStack = new ItemStack(itemInfo, count);

            if (_itemStacksDict.TryGetValue(id, out ItemStack existingItemStack))
            {
                existingItemStack.count += count;
            }
            else
            {
                _insertionOrderList.Add(id);
                _itemStacksDict[id] = newItemStack;
            }

            Size += count;
            if(PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
        }

        /// <summary>
        /// 删除只需要物品id和需要删除的数量即可,其中out输出参数返回被删除的物品，返回值为是否删除成功
        /// </summary>
        /// <param name="id">物品ID</param>
        /// <param name="count">要删除的数量，注意不能填负数</param>
        /// <param name="removedItemStack">输出参数，被删除的物品</param>
        /// <returns></returns>
        /// <example>如果要删除5个，但是背包只有4个时不会删除，返回false</example>
        public bool TryRemoveItem(string id, int count, out ItemStack removedItemStack)
        {
            removedItemStack = null;
            //检查物品是否存在并且数量是否足够
            if (!_itemStacksDict.TryGetValue(id, out ItemStack itemStack) || itemStack.count < count)
                return false;
            //创建要移除的 ItemStack 副本
            removedItemStack = new ItemStack(itemStack.ItemInfo, count);
            //更新现有的 ItemStack
            itemStack.count -= count;
            Size -= count;
            //如果物品数量变为 0，移除该物品
            if (itemStack.count == 0)
            {
                _insertionOrderList.Remove(id);
                _itemStacksDict.Remove(id);
            }

            if(PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
            return true;
        }

        /// <summary>
        /// 清空特地id的物品
        /// </summary>
        /// <param name="id">物品id</param>
        /// <returns>是否清除成功</returns>
        public bool Clear(string id)
        {
            if (!_itemStacksDict.TryGetValue(id, out ItemStack item)) return false;
            Size -= item.count;
            _itemStacksDict.Remove(id);
            _insertionOrderList.Remove(id);
            if(PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
            return true;
        }

        /// <summary>
        /// 清理背包的全部物品
        /// </summary>
        public void Clear()
        {
            Size = 0;
            _itemStacksDict.Clear();
            _insertionOrderList.Clear();
            if(PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
        }
    }
}