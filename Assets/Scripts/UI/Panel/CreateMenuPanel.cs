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
using TMPro;
using UI.Inventory;
using UnityEngine;

namespace UI.Panel
{
    public class CreateMenuPanel : BasePanel<CreateMenuPanel>
    {
        private PlayerInventory Inventory => PlayerStatusPanel.Instance.inventory;
        [SerializeField] private int selectedSlotId = 0;
        [SerializeField] private ItemSlot selectedHotSlot;
        [SerializeField] private ItemSlot[] itemSlots;
        [SerializeField] private ItemSlot[] hotSlots;

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
            selectedSlotId = itemSlot.id;
            var itemStacks = Inventory.GetItemsOrderByTime;
            if (itemSlot.id < 0 || itemSlot.id >= itemStacks.Count) return;
            ItemInfo nowSelectedItemInfo = itemStacks[itemSlot.id].ItemInfo;
            //如果处于选择快捷栏状态时点击
            if (!SelectHotItemPanel.Instance.IsInStack || nowSelectedItemInfo.maxCount <= 0) return;
            selectedHotSlot.UpdateDisplay(nowSelectedItemInfo);
            Inventory.SetHotItem(selectedHotSlot.id,nowSelectedItemInfo);
        }

        private void OnHotSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;
            selectedHotSlot = itemSlot;
            if (!SelectHotItemPanel.Instance.IsInStack && BonfireMenuPanel.Instance.IsInStack)
                SelectHotItemPanel.Instance.ShowMe();
        }
        

        public void UpdateInventoryDisplay()
        {
            var inventoryGetItemsOrderByTime = Inventory.GetItemsOrderByTime;
            foreach (var slot in itemSlots)
            {
                slot.UpdateDisplayFromInventory(inventoryGetItemsOrderByTime);
            }
        }
    }
}