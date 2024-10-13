using UnityEngine;

namespace Core.Items
{
    [CreateAssetMenu(fileName = "ItemInfo", menuName = "Item", order = 0)]
    public class ItemInfo : ScriptableObject
    {
        /// <summary>
        /// 图标，通常用于UI展示 
        /// </summary>
        public Sprite icon;

        /// <summary>
        /// 唯一标识符，用于区分不同的项目或物品
        /// </summary>
        public string id;

        /// <summary>
        /// 物品名称
        /// </summary>
        public string itemName;

        /// <summary>
        /// 物品描述
        /// </summary>
        public string description;
    }
}