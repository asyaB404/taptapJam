using Core;
using Core.Items;
using UnityEngine;

namespace Test
{
    /// <summary>
    /// 测试背包使用示例
    /// </summary>
    public class TestForInventory : MonoBehaviour
    {
        public static PlayerInventory Inventory;

        [SerializeField] private ItemStack wantToAddItemStack;
        [SerializeField] private ItemStack wantToRemoveItemStack;

        private void Awake()
        {
            Inventory = GetComponent<PlayerInventory>();
        }

        /// <summary>
        /// 测试添加功能
        /// </summary>
        [ContextMenu(nameof(TestForAddItemStack))]
        private void TestForAddItemStack()
        {
            //ItemStack为引用类型，注意添加入背包是必须是新的ItemStack或者是拷贝
            Inventory.AddItem(wantToAddItemStack.Copy());
        }

        [ContextMenu(nameof(TestForRemoveItemStack))]
        private void TestForRemoveItemStack()
        {
            //删除只需要物品id和需要删除的数量即可,其中out输出参数返回被删除的物品，返回值为是否删除成功
            //如果要删除5个，但是背包只有4个时不会删除，返回false
            Inventory.TryRemoveItem(wantToRemoveItemStack.ItemInfo.id, wantToRemoveItemStack.count, out var _);
        }


        [ContextMenu(nameof(TestForClearItemStack))]
        private void TestForClearItemStack()
        {
            //清空某个特定的物品
            Inventory.Clear(wantToRemoveItemStack.ItemInfo.id);
        }
    }
}