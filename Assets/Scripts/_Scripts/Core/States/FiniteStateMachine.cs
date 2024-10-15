using Myd.Common;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace Myd.Platform
{
    /// <summary>
    /// 状态枚举，Size为状态数组的大小确定枚举，新添加的枚举必须在Size前面
    /// </summary>
    public enum EActionState
    {
        Normal,
        Dash,
        Climb,
        BeHurt,
        Shoot,
        Size,
    }

    /// <summary>
    /// 状态基类，定义了游戏中动作状态的基本结构和行为
    /// </summary>
    public abstract class BaseActionState
    {
        // 状态枚举
        protected EActionState state;
        // 角色控制器
        protected PlayerController ctx;

        // 构造函数
        protected BaseActionState(EActionState state, PlayerController context)
        {
            this.state = state;
            this.ctx = context;
        }

        // 状态属性 外部获取用
        public EActionState State { get => state; }
        

        // 每一帧都执行的逻辑
        public abstract EActionState Update(float deltaTime);

        // 返回一个 IEnumerator，用于处理状态的协程逻辑。
        public abstract IEnumerator Coroutine();

        // 在状态开始时调用。
        public abstract void OnBegin();

        // 在状态结束时调用。
        public abstract void OnEnd();

        // 返回一个布尔值，指示是否使用协程。
        public abstract bool IsCoroutine();
    }

    /// <summary>
    /// 有限状态机
    /// </summary>
    public class FiniteStateMachine<S> where S : BaseActionState
    {
        // 用于存储所有的状态。
        private S[] states;

        // 当前状态的索引。
        private int currState = -1;
        // 前一个状态的索引。
        private int prevState = -1;
        // 当前状态的协程。
        private Coroutine currentCoroutine;

        // 初始化状态机，分配指定大小的状态数组，并初始化协程。 参数输入应该是最后一个状态的枚举值。
        public FiniteStateMachine(int size)
        {
            this.states = new S[size];
            this.currentCoroutine = new Coroutine(true);
        }

        public void AddState(S state)
        {
            this.states[(int)state.State] = state;
        }

        public void Update(float deltaTime)
        {
            // 调用各个状态自己的Update方法
            State = (int)this.states[this.currState].Update(deltaTime);
            if (this.currentCoroutine.Active)
            {
                this.currentCoroutine.Update(deltaTime);
            }
        }

        /// <summary>
        /// 外部获取和设置状态 相当于ChangeState
        /// </summary>
        public int State
        {
            get
            {
                return this.currState;
            }
            set
            {
                if (this.currState == value)
                    return;
                this.prevState = this.currState;
                this.currState = value;
                Logging.Log($"====Enter State[{(EActionState)this.currState}],Leave State[{(EActionState)this.prevState}] ");
                if (this.prevState != -1)
                {
                    Logging.Log($"====State[{(EActionState)this.prevState}] OnEnd ");
                    this.states[this.prevState].OnEnd();
                }
                Logging.Log($"====State[{(EActionState)this.currState}] OnBegin ");
                this.states[this.currState].OnBegin();
                if (this.states[this.currState].IsCoroutine())
                {
                    this.currentCoroutine.Replace(this.states[this.currState].Coroutine());
                    return;
                }
                this.currentCoroutine.Cancel();
            }
        }
    }
}
