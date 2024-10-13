using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace Myd.Platform.Core
{
    public interface ICamera
    {
        /// <summary>
        /// 设置摄像机位置
        /// </summary>
        /// <param name="cameraPosition"></param>
        void SetCameraPosition(Vector2 cameraPosition);

    }
}
