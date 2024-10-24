using System;
using System.Collections.Generic;
using UnityEngine;

namespace Core.Items
{
    /// <summary>
    /// ItemStack,包含了物品的基本信息（sobj），和物品数量
    /// </summary>
    [System.Serializable]
    public class ItemStack
    {
        [SerializeField] private ItemInfo itemInfo;
        public ItemInfo ItemInfo => itemInfo;

        public int count;
        public string name;

        public ItemStack()
        {
        }

        public ItemStack(string itemInfoName, int count = 1)
        {
            string path = "Assets/AddressableAssets/ScriptableObject/Items/" + itemInfoName + ".asset";
            ItemInfo item = AssetMgr.LoadAssetSync<ItemInfo>(path);
            this.itemInfo = item;
            name = itemInfoName;
            this.count = count;
        }

        public ItemStack(ItemInfo itemInfo, int count)
        {
            this.itemInfo = itemInfo;
            name = itemInfo.name;
            this.count = count;
        }

        /// <summary>
        /// 返回这个物品的拷贝
        /// </summary>
        /// <returns></returns>
        public ItemStack Copy()
        {
            return new ItemStack
            {
                count = this.count,
                itemInfo = this.itemInfo
            };
        }

        private sealed class ItemInfoCountNameEqualityComparer : IEqualityComparer<ItemStack>
        {
            public bool Equals(ItemStack x, ItemStack y)
            {
                if (ReferenceEquals(x, y)) return true;
                if (ReferenceEquals(x, null)) return false;
                if (ReferenceEquals(y, null)) return false;
                if (x.GetType() != y.GetType()) return false;
                return Equals(x.itemInfo, y.itemInfo) && x.count == y.count && x.name == y.name;
            }

            public int GetHashCode(ItemStack obj)
            {
                return HashCode.Combine(obj.itemInfo, obj.count, obj.name);
            }
        }

        public static IEqualityComparer<ItemStack> ItemInfoCountNameComparer { get; } = new ItemInfoCountNameEqualityComparer();
    }
}