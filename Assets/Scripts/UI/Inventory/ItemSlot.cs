using System.Collections.Generic;
using Core.Items;
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
        public IReadOnlyList<ItemStack> Inventory => PlayerStatusPanel.Instance.inventory.GetItemsOrderByTime;

        public void UpdateDisplay()
        {
            image.sprite = null;
            itemCount.text = "";
            if (Inventory == null) return;
            if (id <= -1 || id >= Inventory.Count) return;
            ItemStack itemStack = Inventory[id];
            image.sprite = itemStack.ItemInfo.icon;
            itemCount.text = itemStack.count.ToString();
        }

        public void UpdateDisplay(ItemInfo info, int count = 0)
        {
            image.sprite = null;
            itemCount.text = "";
            if (info == null) return;
            image.sprite = info.icon;
            itemCount.text = count.ToString();
        }
    }
}