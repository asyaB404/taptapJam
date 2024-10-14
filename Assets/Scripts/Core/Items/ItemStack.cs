using UnityEngine;

namespace Core.Items
{
    [System.Serializable]
    public class ItemStack
    {
        [SerializeField] private ItemInfo itemInfo;
        public ItemInfo ItemInfo => itemInfo;

        public int count;

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