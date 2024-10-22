// // ********************************************************************************************
// //     /\_/\                           @file       BonfireMenuPanel.cs
// //    ( o.o )                          @brief     taptap
// //     > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102121
// //   (___)___)                        @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************

using UnityEngine;
using UnityEngine.UI;

namespace UI.Panel
{
    public class BonfireMenuPanel : BasePanel<BonfireMenuPanel>
    {
        [SerializeField] private ToggleGroup toggleGroup;
        [SerializeField] private Toggle[] toggles;

        public override void Init()
        {
            base.Init();
            toggles = toggleGroup.GetComponentsInChildren<Toggle>(true);
            for (int i = 0; i < toggles.Length; i++)
            {
                int index = i;
                toggles[index].onValueChanged.AddListener(value => OnToggleChanged(index, value));
            }
        }

        private void OnToggleChanged(int index, bool value)
        {
            if (!value) return;
            Debug.Log("点击了" + index);
            switch (index)
            {
                case 0:
                default:
                    break;
            }
        }

        #region Debug

        [ContextMenu(nameof(TestForChangeMe))]
        private void TestForChangeMe()
        {
            ChangeMe();
        }

        #endregion
    }
}