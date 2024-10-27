using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using Unity.VisualScripting;
using UnityEngine;

public class HurtState : BaseActionState
{
    public HurtState(PlayerController controller) : base(EActionState.BeHurt, controller)
    {
    }

    public override EActionState Update(float deltaTime)
    {
        return EActionState.Normal;
    }

    public override IEnumerator Coroutine()
    {
        yield return null;
    }

    public override void OnBegin()
    {
        ctx.HurtCooldownTimer = Constants.HurtCoolDown;
        ctx.PlayerHealth -= 10;
        ctx.Speed = Vector2.zero;
        ctx.Speed = new Vector2(-(int)ctx.Facing * Constants.HurtSpeedX, Constants.HurtSpeedY);//和复活冲突了
        //TODO: 后续替换为与血量UI对接的事件
        Debug.Log("角色生命值" + ctx.PlayerHealth);
    }

    public override void OnEnd()
    {
        
    }

    public override bool IsCoroutine()
    {
        return false;
    }
}
