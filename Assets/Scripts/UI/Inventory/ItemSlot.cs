using System.Collections.Generic;
using Core;
using Core.Container;
using Core.Items;
using Test;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Inventory
{
    public class ItemSlot : MonoBehaviour
    {
        public int id = -1;
        [SerializeField] private Image image;
        [SerializeField] private TextMeshProUGUI itemCount;
        [SerializeField] private Toggle toggle;
        private IReadOnlyList<ItemStack> _inventory => TestForInventory.Inventory.GetItemsOrderByTime;

        private void Awake()
        {
            toggle.onValueChanged.AddListener((flag) => { });
        }

        public void UpdateDisplay()
        {
            if (id <= -1 || id >= _inventory.Count) return;
            ItemStack itemStack = _inventory[id];
            image.sprite = itemStack.ItemInfo.icon;
            itemCount.text = itemStack.count.ToString();
        }
    }
}