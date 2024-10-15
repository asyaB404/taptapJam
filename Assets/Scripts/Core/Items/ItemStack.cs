using UnityEngine;

namespace Core.Items
{
    [System.Serializable]
    public class ItemStack
    {
        [SerializeField] private ItemInfo itemInfo;
        public ItemInfo ItemInfo => itemInfo;

        public int count;

        public ItemStack()
        {
        }

        public ItemStack(ItemInfo itemInfo, int count)
        {
            this.itemInfo = itemInfo;
            this.count = count;
        }

        public ItemStack Copy()
        {
            return new ItemStack
            {
                count = this.count,
                itemInfo = this.itemInfo
            };
        }
    }
}