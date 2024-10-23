// // ********************************************************************************************
// //     /\_/\                           @file       SelectHotItemPanel.cs
// //    ( o.o )                          @brief     taptap
// //    > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102117
// //    (___)___)                        @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************

namespace UI.Panel
{
    public class SelectHotItemPanel : BasePanel<SelectHotItemPanel>
    {
        public override void OnPressedEsc()
        {
            HideMe(false);
        }

        public override void CallBack(bool flag)
        {
            gameObject.SetActive(flag);
            var itemStacks = CreateMenuPanel.Instance.Inventory.GetItemsOrderByTime;
            if (flag)
            {
                foreach (var itemSlot in CreateMenuPanel.Instance.ItemSlots)
                {
                    var alpha = itemStacks[itemSlot.id].ItemInfo.maxCount == 0 ? 0.5f : 1;
                    itemSlot.SetAlpha(alpha);
                }
            }
            else
            {
                foreach (var itemSlot in CreateMenuPanel.Instance.ItemSlots)
                {
                    itemSlot.SetAlpha(1);
                }
            }
        }
    }
}