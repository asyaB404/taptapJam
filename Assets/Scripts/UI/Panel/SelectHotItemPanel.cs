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
            var itemSlots = CreateMenuPanel.Instance.ItemSlots;
            if (flag)
            {
                for (int i = 0; i < itemStacks.Count; i++)
                {
                    if (itemStacks[i].ItemInfo.maxCount == 0)
                    {
                        itemSlots[i].SetAlpha(0.5f);
                        itemSlots[i].toggle.interactable = false;
                    }
                    else
                    {
                        itemSlots[i].SetAlpha(1f);
                        itemSlots[i].toggle.interactable = true;
                    }
                }
            }
            else
            {
                foreach (var itemSlot in itemSlots)
                {
                    itemSlot.SetAlpha(1);
                    itemSlot.toggle.interactable = true;
                }
            }
        }
    }
}