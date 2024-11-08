﻿using System;
using System.Collections;
using UnityEngine;

namespace Myd.Platform
{
    /// <summary>
    /// 跳跃检查组件
    /// </summary>
    public class JumpCheck
    {
        private float timer;

        private PlayerController controller;
        public float Timer => timer;
        private bool jumpGrace; // 指示是否启用跳跃宽容时间。
        public JumpCheck(PlayerController playerController, bool jumpGrace)
        {
            this.controller = playerController;
            this.ResetTime();
            this.jumpGrace = jumpGrace;
        }

        public void ResetTime()
        {
            this.timer = 0;
        }

        public void Update(float deltaTime)
        {
            //Jump Grace
            if (controller.OnGround)
            {
                //dreamJump = false;
                timer = Constants.JumpGraceTime;
            }
            else
            {
                if (timer > 0)
                {
                    timer -= deltaTime;
                }
            }
        }

        /// <summary>
        /// 如果启用了跳跃宽容时间，则在 timer 大于0时允许跳跃；否则，仅在玩家在地面上时允许跳跃。
        /// </summary>
        /// <returns></returns>
        public bool AllowJump()
        {
            return jumpGrace ? timer > 0 : controller.OnGround;
        }
    }
}