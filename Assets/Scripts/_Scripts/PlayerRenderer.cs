using System;
using DG.Tweening;
using Myd.Platform.Core;
using System.Collections;
using System.Collections.Generic;
using cfg;
using Laser;
using UnityEngine;

namespace Myd.Platform
{

    /// <summary>
    /// 这里是Unity下实现玩家表现接口
    /// </summary>
    public class PlayerRenderer : MonoBehaviour, ISpriteControl
    {
        [SerializeField]
        public SpriteRenderer spriteRenderer;

        [SerializeField]
        public ParticleSystem vfxDashFlux;
        [SerializeField]
        public ParticleSystem vfxWallSlide;

        [SerializeField]
        public TrailRenderer hair;

        [SerializeField]
        public SpriteRenderer hairSprite01;
        [SerializeField]
        public SpriteRenderer hairSprite02;
        
        // 激光
        [SerializeField]
        public Laser2D laser;

        private Vector2 scale;
        private Vector2 currSpriteScale;

        public Vector3 SpritePosition { get => this.spriteRenderer.transform.position; }
        
        private Animator _animator;


        private void Start()
        {
            _animator = GetComponentInChildren<Animator>();
            
            EventMgr.RegisterEvent(EventTypes.PlayJumpAni, PlayJumpAni);
            EventMgr.RegisterEvent(EventTypes.PlayDashAni, PlayDashAni);
            EventMgr.RegisterEvent(EventTypes.PlayIdleAni, PlayIdleAni);
            EventMgr.RegisterEvent(EventTypes.PlayRunAni, PlayRunAni);
        }

        private void OnDisable()
        {
            //注销事件
            EventMgr.UnRegisterEvent(EventTypes.PlayJumpAni, PlayJumpAni);
            EventMgr.UnRegisterEvent(EventTypes.PlayDashAni, PlayDashAni);
            EventMgr.UnRegisterEvent(EventTypes.PlayIdleAni, PlayIdleAni);
            EventMgr.UnRegisterEvent(EventTypes.PlayRunAni, PlayRunAni);
        }


        public void Reload()
        {

        }

        public void Render(float deltaTime)
        {
            float tempScaleX = Mathf.MoveTowards(scale.x, currSpriteScale.x, 1.75f * deltaTime);
            float tempScaleY = Mathf.MoveTowards(scale.y, currSpriteScale.y, 1.75f * deltaTime);
            this.scale = new Vector2(tempScaleX, tempScaleY);
            this.spriteRenderer.transform.localScale = scale;
        }

        public void Trail(int face)
        {
            SceneEffectManager.Instance.Add(this.spriteRenderer, face, Color.white);
        }

        public void Scale(Vector2 scale)
        {
            this.scale = scale;
        }

        public void SetSpriteScale(Vector2 scale)
        {
            this.currSpriteScale = scale;
        }

        public void DashFlux()
        {

        }

        public void Slash(bool enable)
        {
        }

        public void WallSlide(Color color, Vector2 dir)
        {
            this.vfxWallSlide.transform.rotation = Quaternion.FromToRotation(Vector2.up, dir);
            var main = this.vfxWallSlide.main;
            main.startColor = color;
            this.vfxWallSlide.Emit(1);
        }

        public void SetPositions(Vector2 start, Vector2 direction)
        {
            this.laser.SetPositions(start, direction);
        }

        public void WithoutReflect(Vector2 start, Vector2 direction)
        {
            this.laser.BetterCastLaserWithoutReflect(start, direction);
        }


        public void SetEnable(bool enable)
        {
            this.laser.SetEnable(enable);
        }


        public void DashFlux(Vector2 dir, bool play)
        {
            if (play)
            {
                this.vfxDashFlux.transform.rotation = Quaternion.FromToRotation(Vector2.up, dir);
                this.vfxDashFlux.Play();
            }
            else
            {
                this.vfxDashFlux.transform.parent = this.transform;
                this.vfxDashFlux.Stop();
            }
        }

        public void SetHairColor(Color color)
        {
            Gradient gradient = new Gradient();
            gradient.SetKeys(
                new GradientColorKey[] { new GradientColorKey(color, 0.0f), new GradientColorKey(Color.black, 1.0f) },
                new GradientAlphaKey[] { new GradientAlphaKey(1, 0.0f), new GradientAlphaKey(1, 0.6f), new GradientAlphaKey(0, 1.0f) }
            );
            this.hair.colorGradient = gradient;
            this.hairSprite01.color = color;
            this.hairSprite02.color = color;
        }
        
        private readonly Rect normalHitbox = new Rect(0, -0.25f, 0.8f, 1.1f);
        
        private void OnDrawGizmos()
        {
            DrawRect(normalHitbox, Color.green);
        }

        private void DrawRect(Rect rect, Color color)
        {
            Vector2 bottomLeft = new Vector2(rect.xMin, rect.yMin);
            Vector2 bottomRight = new Vector2(rect.xMax, rect.yMin);
            Vector2 topLeft = new Vector2(rect.xMin, rect.yMax);
            Vector2 topRight = new Vector2(rect.xMax, rect.yMax);

            Debug.DrawLine(bottomLeft, bottomRight, color);
            Debug.DrawLine(bottomRight, topRight, color);
            Debug.DrawLine(topRight, topLeft, color);
            Debug.DrawLine(topLeft, bottomLeft, color);
        }
        
        
        // 创建控制玩家动画状态机
        private void SetAnimator(string aniName)
        {
            _animator.Play(aniName);
        }
        
        private object PlayJumpAni(object[] arg)
        {
            SetAnimator("PlayerJump");
            return null;
        }
        
        private object PlayRunAni(object[] arg)
        {
            SetAnimator("PlayerRun");
            return null;
        }

        private object PlayIdleAni(object[] arg)
        {
            SetAnimator("PlayerIdel");
            return null;
        }

        private object PlayDashAni(object[] arg)
        {
            SetAnimator("PlayerDash");
            return null;
        }
    }

    //测试用的绘制接口
    public enum EGizmoDrawType
    {
        SlipCheck,
        ClimbCheck,
    }
    
}
