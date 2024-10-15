using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace Myd.Platform.Core
{
    /// <summary>
    /// 精灵控制器，用于和外部实现解耦
    /// </summary>
    public interface ISpriteControl
    {
        void Trail(int face);

        void Scale(Vector2 localScale);

        void SetSpriteScale(Vector2 localScale);

        Vector3 SpritePosition { get; }

        void Slash(bool enable);

        void DashFlux(Vector2 dir, bool enable);
        //设置头发颜色
        void SetHairColor(Color color);

        void WallSlide(Color color, Vector2 dir);
        
        // 激光设置位置
        void SetPositions(Vector2 start, Vector2 direction);
        
        void WithoutReflect(Vector2 start, Vector2 direction);
        
        // 设置激光是否启用
        void SetEnable(bool enable);
    }
}
