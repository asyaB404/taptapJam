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

        public void SetAlpha(float alpha)
        {
            image.SetAlpha(alpha);
        }

        public void UpdateDisplayFromInventory(IReadOnlyList<ItemStack> inventory)
        {
            image.sprite = null;
            itemCount.text = "";
            if (inventory == null) return;
            if (id <= -1 || id >= inventory.Count) return;
            ItemStack itemStack = inventory[id];
            if (!itemStack?.ItemInfo) return;
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