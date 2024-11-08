// // ********************************************************************************************
// //     /\_/\                           @file       CreateMenuPanel.cs
// //    ( o.o )                          @brief     taptap
// //     > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102216
// //   (___)___)                         @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************


using System.Collections.Generic;
using Core;
using Core.Items;
using UI.Inventory;
using UnityEngine;

namespace UI.Panel
{
    public class CreateMenuPanel : BasePanel<CreateMenuPanel>
    {
        public PlayerInventory Inventory => PlayerStatusPanel.Instance.Inventory;
        public IReadOnlyList<ItemSlot> ItemSlots => itemSlots;
        [SerializeField] private ItemSlot selectedHotSlot;
        [SerializeField] private ItemSlot[] itemSlots;
        [SerializeField] private ItemSlot[] hotSlots;
        
        [SerializeField] private GameObject createSlotPrefab;
        [SerializeField] private Transform createSlotParent;

        private void OnEnable()
        {
            UpdateDisplay();
            Inventory.ResetAllHotItem();
        }

        public override void OnPressedEsc()
        {
            HideMe(false);
        }

        public override void Init()
        {
            base.Init();
            InitializeItemSlots();
        }

        private void InitializeItemSlots()
        {
            for (int i = 0; i < itemSlots.Length; i++)
            {
                ItemSlot itemSlot = itemSlots[i];
                itemSlot.id = i;
                itemSlot.toggle.onValueChanged.AddListener(value => OnItemSlotToggleChanged(itemSlot, value));
            }

            for (int i = 0; i < hotSlots.Length; i++)
            {
                ItemSlot itemSlot = hotSlots[i];
                itemSlot.id = i;
                itemSlot.toggle.onValueChanged.AddListener(value => OnHotSlotToggleChanged(itemSlot, value));
            }
        }

        private void OnItemSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;
            AudioMgr.PlaySound(cfg.EnumAudioClip.普通点击);
            int itemSlotId = itemSlot.id;
            var itemStacks = Inventory.GetItemsOrderByTime;
            if (itemSlotId < 0 || itemSlotId >= itemStacks.Count) return;
            ItemStack selectedItemStack = itemStacks[itemSlotId];
            ItemInfo nowSelectedItemInfo = selectedItemStack.ItemInfo;
            //如果处于选择快捷栏状态时点击
            if (!SelectHotItemPanel.Instance.IsInStack || nowSelectedItemInfo.maxCount <= 0) return;
            SelectHotItemPanel.Instance.HideMe(false);
            int hotSlotId = selectedHotSlot.id;
            if (nowSelectedItemInfo == Inventory.GetHotItem(hotSlotId)?.ItemInfo)
            {
                Inventory.AddItem(Inventory.GetHotItem(hotSlotId));
                Inventory.SetHotItem(hotSlotId, null);
            }
            else
            {
                if (Inventory.TryRemoveItem(nowSelectedItemInfo.id, nowSelectedItemInfo.maxCount, out var itemStack))
                {
                    Inventory.SetHotItem(hotSlotId, itemStack);
                }
                else
                {
                    Inventory.SetHotItem(hotSlotId, selectedItemStack);
                    Inventory.Clear(nowSelectedItemInfo.id);
                }
            }

            UpdateDisplay();
        }

        private void OnHotSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;
            AudioMgr.PlaySound(cfg.EnumAudioClip.切换物品位置);
            selectedHotSlot = itemSlot;
            if (!SelectHotItemPanel.Instance.IsInStack && BonfireMenuPanel.Instance.IsInStack)
                SelectHotItemPanel.Instance.ShowMe(false);
        }

        public void UpdateDisplay()
        {
            var inventoryGetItemsOrderByTime = Inventory.GetItemsOrderByTime;
            var hotItemStacks = Inventory.HotItemStacks;
            var craftGuide = CraftGuideMgr.Instance.GetCraftGuide();
            foreach (var slot in itemSlots)
            {
                slot.UpdateDisplayFromInventory(inventoryGetItemsOrderByTime);
            }

            foreach (var slot in hotSlots)
            {
                slot.UpdateDisplayFromInventory(hotItemStacks);
            }

            createSlotParent.DestroyAllChildren();
            foreach (var pair in craftGuide)
            {
                GameObject createSlot = Instantiate(createSlotPrefab,createSlotParent);
                createSlot.GetComponent<CreateSlot>().Init(pair);
            }
        }
    }
}