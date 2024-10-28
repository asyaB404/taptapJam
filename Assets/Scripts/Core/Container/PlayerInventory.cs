using System.Collections.Generic;
using System.Linq;
using Core.Container;
using Core.Items;
using Myd.Platform;
using UI.Panel;
using UnityEngine;

namespace Core
{
    /// <summary>
    /// 玩家背包，底层实现使用的字典
    /// </summary>
    public class PlayerInventory : MonoBehaviour, IMyContainer
    {
        #region 快捷栏

        /// <summary>
        /// 快捷栏上的物品
        /// </summary>
        [SerializeField] private List<ItemStack> hotItemStacks = new(3) { null, null, null };

        public IReadOnlyList<ItemStack> HotItemStacks => hotItemStacks;

        public ItemStack GetHotItem(int id)
        {
            return hotItemStacks[id];
        }

        public void ResetAllHotItem()
        {
            for (int i = 0; i < hotItemStacks.Count; i++)
            {
                ResetHotItem(i);
            }

            GamePanel.Instance.UpdateHotItemDisPlay();
        }

        private bool ResetHotItem(int id)
        {
            ItemStack hotItemStack = hotItemStacks[id];
            if (!hotItemStack?.ItemInfo) return false;
            ItemInfo itemInfo = hotItemStack.ItemInfo;
            if (!TryRemoveItem(itemInfo.id, itemInfo.maxCount - hotItemStack.count, out _)) return false;
            hotItemStack.count = itemInfo.maxCount;
            return true;
        }

        public void SetHotItemList(List<ItemStack> list)
        {
            hotItemStacks = list;
            GamePanel.Instance.UpdateHotItemDisPlay();
        }

        public void SetHotItem(int id, ItemStack itemStack)
        {
            if (itemStack == null)
            {
                hotItemStacks[id] = null;
            }
            else
            {
                hotItemStacks[id] = itemStack;
            }

            GamePanel.Instance.UpdateHotItemDisPlay();
        }

        public bool UseHotItem(int id)
        {
            var hotItemStack = hotItemStacks[id];
            if (hotItemStack == null || hotItemStack.ItemInfo == null) return false;
            var itemInfo = hotItemStack.ItemInfo;
            hotItemStack.count -= 1;
            AudioMgr.PlaySound(cfg.EnumAudioClip.使用物品);
            //TODO:堆史山
            switch (itemInfo.id)
            {
                case "PR10001":
                    Game.Player.SetPlayerHealth(1);
                    break;
                case "PR10002":
                    Game.Player.SetPlayerStamina(20);
                    break;
                case "UR10001":
                    Game.Player.SetPlayerHealth(2);
                    break;
                case "UR10002":
                    Game.Player.SetPlayerStamina(30);
                    break;
                case "UR10003":
                    Game.Player.SetPlayerStamina(-20);
                    Game.Player.SetPlayerHealth(3);
                    break;
                default:
                    Debug.Log(itemInfo.id + "是什么");
                    break;
            }

            if (hotItemStack.count <= 0)
                SetHotItem(id, null);


            GamePanel.Instance.UpdateHotItemDisPlay();
            return true;
        }

        #endregion

        private readonly Dictionary<string, ItemStack> _itemStacksDict = new();

        private readonly List<ItemStack> _orderedItemStacks = new(); // 用于存储顺序列表

        /// <summary>
        /// 返回的是字典的原始集合拷贝
        /// </summary>
        public IReadOnlyCollection<ItemStack> GetItems => _itemStacksDict.Values;

        /// <summary>
        /// 返回的是根据时间顺序加入的物品序列拷贝
        /// </summary>
        public IReadOnlyList<ItemStack> GetItemsOrderByTime => _orderedItemStacks;

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
                _orderedItemStacks.Add(newItemStack);
                _itemStacksDict[id] = newItemStack;
            }

            Size += quantity;
            UpdateUIDisplay();
        }

        /// <summary>
        /// 添加物品，根据信息和数量创建新的ItemStack添加至背包
        /// </summary>
        /// <param name="itemInfo">物品信息</param>
        /// <param name="count">要添加的数量</param>
        public void AddItem(ItemInfo itemInfo, int count)
        {
            ItemStack newItemStack = new ItemStack(itemInfo, count);
            AddItem(newItemStack);
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
                _orderedItemStacks.Remove(itemStack);
                _itemStacksDict.Remove(id);
            }

            UpdateUIDisplay();
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
            _orderedItemStacks.Remove(_itemStacksDict[id]);
            _itemStacksDict.Remove(id);
            UpdateUIDisplay();
            return true;
        }

        /// <summary>
        /// 清理背包的全部物品
        /// </summary>
        public void Clear()
        {
            Size = 0;
            _itemStacksDict.Clear();
            _orderedItemStacks.Clear();
            UpdateUIDisplay();
        }

        private void UpdateUIDisplay()
        {
            if (PlayerStatusPanel.Instance.IsInStack) PlayerStatusPanel.Instance.UpdateInventoryDisplay();
            if (CreateMenuPanel.Instance.IsInStack) CreateMenuPanel.Instance.UpdateDisplay();
        }
    }
}