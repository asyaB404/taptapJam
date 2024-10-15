using Core;
using Core.Items;
using UnityEngine;

namespace Test
{
    public class TestForInventory:MonoBehaviour
    {
        public static PlayerInventory Inventory;

        [SerializeField] private ItemStack wantToAddItemStack;
        [SerializeField] private ItemStack wantToRemoveItemStack;
        private void Awake()
        {
            Inventory = GetComponent<PlayerInventory>();
        }

        [ContextMenu(nameof(TestForAddItemStack))]
        private void TestForAddItemStack()
        {
            Inventory.AddItem(wantToAddItemStack.Copy());
        }

        [ContextMenu(nameof(TestForRemoveItemStack))]
        private void TestForRemoveItemStack()
        {
            Inventory.TryRemoveItem(wantToRemoveItemStack.ItemInfo.id,wantToRemoveItemStack.count,out var _);
        }
        
        
        [ContextMenu(nameof(TestForClearItemStack))]
        private void TestForClearItemStack()
        {
            Inventory.Clear(wantToRemoveItemStack.ItemInfo.id);
        }
        
    }
}