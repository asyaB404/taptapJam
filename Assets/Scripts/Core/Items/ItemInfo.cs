using UnityEngine;

namespace Core.Items
{
    /// <summary>
    /// 物品的基本信息
    /// </summary>
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

        /// <summary>
        /// 在快捷栏中的最大数量，不可使用的物品请忽略
        /// </summary>
        [Tooltip("在快捷栏中的最大数量，不可使用的物品请忽略")] public int maxCount;
    }
}