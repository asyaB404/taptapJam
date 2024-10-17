using Myd.Common;
using System;
using System.Collections;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks.Unity.UnityInput;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;

namespace Myd.Platform
{
    public class NormalState : BaseActionState
    {
        private bool isEnableLaser = false;
        
        
        public NormalState(PlayerController controller):base(EActionState.Normal, controller)
        {
        }

        public override IEnumerator Coroutine()
        {
            throw new NotImplementedException();
        }

        public override bool IsCoroutine()
        {
            return false;
        }

        public override void OnBegin()
        {
            this.ctx.MaxFall = Constants.MaxFall;
        }

        public override void OnEnd()
        {
            this.ctx.WallBoost?.ResetTime();
            this.ctx.WallSpeedRetentionTimer = 0;
            this.ctx.HopWaitX = 0;
        }

        public override EActionState Update(float deltaTime)
        {
            // 检测到受伤
            if (ctx.BeHurtCheck(ctx.Position, Vector2.zero) && ctx.CanBeHurt)
            {
                return EActionState.BeHurt;
            }
            
            
            // 检测到射击
            if (Input.GetMouseButton(1))
            {
                // 先转换坐标
                var mousePos = (Vector2)Camera.main.ScreenToWorldPoint(Input.mousePosition);
                // 计算方向
                var direction = (mousePos - ctx.Position).normalized;
                
//                Debug.Log(direction);
                if (!isEnableLaser)
                {
                    // 由于不断地在Play 粒子系统，所以显示不出粒子效果
                    ctx.SetLaserEnable(true);
                    isEnableLaser = true;
                    ctx.PlayerStamina -= 10;
                    Debug.Log("角色灵力" + ctx.PlayerStamina);
                }
                // 相机震动
                Camera.main.DOShakePosition(0.1f, 0.1f, 10, 90, false);
                ctx.SetLaserPosition(ctx.Position, direction);
            }
            // TODO:改为发射子弹
            else if (Input.GetMouseButton(0))
            {
                ctx.ShootBullet();
            }
            else 
            {
                ctx.SetLaserEnable(false);
                isEnableLaser = false;
            }
           
            
            //Climb
            if (GameInput.Grab.Checked() && !ctx.Ducking)
            {
                //Climbing
                if (ctx.Speed.y <= 0 && Math.Sign(ctx.Speed.x) != -(int)ctx.Facing)
                {
                    if (ctx.ClimbCheck((int)ctx.Facing))
                    {
                        ctx.Ducking = false;
                        return EActionState.Climb;
                    }
                    //非下坠情况，需要考虑向上攀爬吸附
                    if (ctx.MoveY > -1)
                    {
                        bool snapped = ctx.ClimbUpSnap();
                        if (snapped)
                        {
                            ctx.Ducking = false;
                            return EActionState.Climb;
                        }
                    }
                }
            }

            //Dashing
            if (this.ctx.CanDash)
            {
                return this.ctx.Dash();
            }

            //Ducking
            if (ctx.Ducking)
            {
                if (ctx.OnGround && ctx.MoveY != -1)
                {
                    if (ctx.CanUnDuck)
                    {
                        ctx.Ducking = false;
                    }
                    else if (ctx.Speed.x == 0)
                    {
                        //根据角落位置，进行挤出操作
                    }
                }
            }
            else if (ctx.OnGround && ctx.MoveY == -1 && ctx.Speed.y <= 0)
            {
                ctx.Ducking = true;
                ctx.PlayDuck(true);
            }

            //水平面上移动,计算阻力
            if (ctx.Ducking && ctx.OnGround)
            {
                ctx.Speed.x = Mathf.MoveTowards(ctx.Speed.x, 0, Constants.DuckFriction * deltaTime);
            }
            else
            {
                float mult = ctx.OnGround ? 1 : Constants.AirMult;
                //计算水平速度
                float max = ctx.Holding == null ? Constants.MaxRun : Constants.HoldingMaxRun;
                if (Math.Abs(ctx.Speed.x) > max && Math.Sign(ctx.Speed.x) == this.ctx.MoveX)
                {
                    //同方向加速
                    ctx.Speed.x = Mathf.MoveTowards(ctx.Speed.x, max * this.ctx.MoveX, Constants.RunReduce * mult * Time.deltaTime);
                }
                else
                {
                    //反方向减速
                    ctx.Speed.x = Mathf.MoveTowards(ctx.Speed.x, max * this.ctx.MoveX, Constants.RunAccel * mult * Time.deltaTime);
                }
            }
            //计算竖直速度
            {
                //计算最大下落速度
                {
                    float maxFallSpeed = Constants.MaxFall;
                    float fastMaxFallSpeed = Constants.FastMaxFall;

                    if (this.ctx.MoveY == -1 && this.ctx.Speed.y <= maxFallSpeed)
                    {
                        this.ctx.MaxFall = Mathf.MoveTowards(this.ctx.MaxFall, fastMaxFallSpeed, Constants.FastMaxAccel * deltaTime);

                        //处理表现
                        this.ctx.PlayFallEffect(ctx.Speed.y);
                    }
                    else
                    {
                        this.ctx.MaxFall = Mathf.MoveTowards(this.ctx.MaxFall, maxFallSpeed, Constants.FastMaxAccel * deltaTime);
                    }
                }

                if (!ctx.OnGround)
                {
                    float max = this.ctx.MaxFall;//最大下落速度
                    //Wall Slide
                    if ((ctx.MoveX == (int)ctx.Facing || (ctx.MoveX == 0 && GameInput.Grab.Checked())) && ctx.MoveY != -1)
                    {
                        //判断是否向下做Wall滑行
                        if (ctx.Speed.y <= 0 && ctx.WallSlideTimer > 0 && ctx.ClimbBoundsCheck((int)ctx.Facing) && ctx.CollideCheck(ctx.Position, Vector2.right * (int)ctx.Facing) && ctx.CanUnDuck)
                        {
                            ctx.Ducking = false;
                            ctx.WallSlideDir = (int)ctx.Facing;
                        }

                        if (ctx.WallSlideDir != 0)
                        {
                            //if (ctx.WallSlideTimer > Constants.WallSlideTime * 0.5f && ClimbBlocker.Check(level, this, Position + Vector2.UnitX * wallSlideDir))
                            //    ctx.WallSlideTimer = Constants.WallSlideTime * .5f;

                            max = Mathf.Lerp(Constants.MaxFall, Constants.WallSlideStartMax, ctx.WallSlideTimer / Constants.WallSlideTime);
                            if ((ctx.WallSlideTimer / Constants.WallSlideTime) > .65f)
                            {
                                //播放滑行特效
                                ctx.PlayWallSlideEffect(Vector2.right * ctx.WallSlideDir);
                            }
                        }
                    }

                    float mult = (Math.Abs(ctx.Speed.y) < Constants.HalfGravThreshold && (GameInput.Jump.Checked())) ? .5f : 1f;
                    //空中的情况,需要计算Y轴速度
                    ctx.Speed.y = Mathf.MoveTowards(ctx.Speed.y, max, Constants.Gravity * mult * deltaTime);
                }

                //处理跳跃
                if (ctx.VarJumpTimer > 0)
                {
                    if (GameInput.Jump.Checked())
                    {
                        //如果按住跳跃，则跳跃速度不受重力影响。
                        ctx.Speed.y = Math.Max(ctx.Speed.y, ctx.VarJumpSpeed);
                    }
                    else
                        ctx.VarJumpTimer = 0;
                }
            }

            if (GameInput.Jump.Pressed())
            {
                //土狼时间范围内,允许跳跃
                if (this.ctx.JumpCheck.AllowJump())
                {
                    this.ctx.Jump();
                }
                else if (ctx.CanUnDuck)
                {
                    //如果右侧有墙
                    if (ctx.WallJumpCheck(1))
                    {
                        if (ctx.Facing == Facings.Right && GameInput.Grab.Checked())
                            ctx.ClimbJump();
                        else
                            ctx.WallJump(-1);
                    }
                    //如果左侧有墙
                    else if (ctx.WallJumpCheck(-1))
                    {
                        if (ctx.Facing == Facings.Left && GameInput.Grab.Checked())
                            ctx.ClimbJump();
                        else
                            ctx.WallJump(1);
                    }
                }
            }

            return state;
        }
    }
}
