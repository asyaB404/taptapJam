using System.Collections.Generic;
using System.Linq;
using Core.Container;
using Core.Items;
using UI.Panel;
using UnityEngine;

namespace Core
{
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



        public int Size { get; private set; }

        public int Count(string id)
        {
            return _itemStacksDict.TryGetValue(id, out ItemStack item) ? item.count : 0;
        }

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
            PlayerStatusPanel.Instance.UpdateInventoryDisplay();
        }

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
            PlayerStatusPanel.Instance.UpdateInventoryDisplay();
            return true;
        }

        public bool Clear(string id)
        {
            if (!_itemStacksDict.TryGetValue(id, out ItemStack item)) return false;
            Size -= item.count;
            _itemStacksDict.Remove(id);
            _insertionOrderList.Remove(id);
            PlayerStatusPanel.Instance.UpdateInventoryDisplay();
            return true;
        }

        public void Clear()
        {
            Size = 0;
            _itemStacksDict.Clear();
            _insertionOrderList.Clear();
            PlayerStatusPanel.Instance.UpdateInventoryDisplay();
        }
    }
}