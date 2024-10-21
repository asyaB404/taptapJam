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

        public ItemStack()
        {
        }
        public ItemStack(string itemInfoName, int count=1){
            // string path="Assets/AddressableAssets/ScriptableObject/Items/"+itemInfoName+".asset";
            string path="Assets/AddressableAssets/ScriptableObject/Items/laogane.asset";
            Debug.Log(path);
            ItemInfo item=AssetMgr.LoadAssetSync<ItemInfo>(path);
            this.itemInfo = item;
            this.count = count;
        }

        public ItemStack(ItemInfo itemInfo, int count)
        {
            this.itemInfo = itemInfo;
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
    }
}