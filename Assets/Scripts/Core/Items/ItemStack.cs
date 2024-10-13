using UnityEngine;

namespace Core.Items
{
    [System.Serializable]
    public class ItemStack
    {
        [SerializeField] private ItemInfo itemInfo;
        public ItemInfo ItemInfo => itemInfo;

        public int count;
    }
}