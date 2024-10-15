using Core;
using Core.Items;
using UnityEngine;

namespace Test
{
    public class TestForInventory:MonoBehaviour
    {
        public static PlayerInventory Inventory;

        [SerializeField] private ItemStack wantToAddItemStack;
        private void Awake()
        {
            Inventory = GetComponent<PlayerInventory>();
        }

        [ContextMenu(nameof(TestForAddItemStack))]
        private void TestForAddItemStack()
        {
            Inventory.AddItem(wantToAddItemStack);
        }

    }
}