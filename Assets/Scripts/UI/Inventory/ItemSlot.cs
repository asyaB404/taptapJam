using System.Collections.Generic;
using Core;
using Core.Container;
using Core.Items;
using Test;
using TMPro;
using UI.Panel;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Inventory
{
    public class ItemSlot : MonoBehaviour
    {
        public int id = -1;
        [SerializeField] private Image image;
        [SerializeField] private TextMeshProUGUI itemCount;
        public Toggle toggle;
        /// <summary>
        /// 测试用属性
        /// </summary>
        public IReadOnlyList<ItemStack> Inventory => PlayerStatusPanel.Instance.Inventory.GetItemsOrderByTime;

        public void UpdateDisplay()
        {
            if (id <= -1 || id >= Inventory.Count) return;
            ItemStack itemStack = Inventory[id];
            image.sprite = itemStack.ItemInfo.icon;
            itemCount.text = itemStack.count.ToString();
        }
    }
}