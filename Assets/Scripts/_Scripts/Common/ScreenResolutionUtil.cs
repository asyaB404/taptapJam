﻿using UnityEngine;

namespace Myd.Common
{
    public static class ScreenResolutionUtil
    {
        public static float ScreenW = 3200, ScreenH = 1800;
        
        /// <summary>
        /// 它根据当前屏幕的宽高比，调整相机的正交尺寸
        /// </summary>
        /// <returns></returns>
        
        //调整摄像机，优先保证宽度
        public static float CalcOrthographicSize()
        {
            //获取当前
            float baseRate = ScreenW / ScreenH;
            float currRate = (Screen.width * 1.0f) / (Screen.height * 1.0f);
            if (currRate >= baseRate)
            {
                return ScreenH / 100.0f / 2f;
            }
            else
            {
                //优先满足宽度可见
                return ScreenW * (Screen.height * 1.0f) / (Screen.width * 1.0f) / 100.0f / 2f;
            }
        }
    }
}
