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
        public override void CallBack(bool flag)
        {
            gameObject.SetActive(flag);
            if (flag)
            {
            }
            else
            {
            }
        }
    }
}