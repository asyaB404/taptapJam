// // ********************************************************************************************
// //     /\_/\                           @file       BonfireMenuPanel.cs
// //    ( o.o )                          @brief     taptap
// //     > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102121
// //   (___)___)                        @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************

using System;
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

        private void OnEnable()
        {
            AudioMgr.PlaySound(cfg.EnumAudioClip.火堆界面);
        }

        private void OnToggleChanged(int index, bool value)
        {
            if (!value) return;
            Debug.Log("点击了" + index);
            AudioMgr.PlaySound(cfg.EnumAudioClip.普通点击);
            switch (index)
            {
                case 0:
                    AudioMgr.PlaySound(cfg.EnumAudioClip.主角休息);
                    break;
                case 1:
                    CreateMenuPanel.Instance.ShowMe(false);
                    break;
                case 2:
                    SaveMgr.Instance.Save();
                    break;
                case 3:
                    HideMe();
                    break;
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