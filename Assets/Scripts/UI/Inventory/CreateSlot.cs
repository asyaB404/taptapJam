// // ********************************************************************************************
// //     /\_/\                           @file       CreateSlot.cs
// //    ( o.o )                          @brief     taptap
// //     > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102418
// //   (___)___)                         @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************

using System;
using System.Collections.Generic;
using Core.Items;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Inventory
{
    public class CreateSlot : MonoBehaviour
    {
        [SerializeField] private ItemSlot[] itemSlots;
        [SerializeField] private Button button;

        public void Init(KeyValuePair<List<ItemStack>, ItemStack> pair)
        {
            button.onClick.RemoveAllListeners();
            button.onClick.AddListener(() =>
            {
                CraftGuideMgr.Instance.MakeItem(pair.Value);
            });
            itemSlots[0].UpdateDisplay(pair.Value);
            for (int i = 1;i<itemSlots.Length;i++)
            {
                var itemSlot = itemSlots[i];
                foreach (var itemStack in pair.Key)
                {
                    itemSlot.UpdateDisplay(itemStack);
                }
            }
        }
    }
}