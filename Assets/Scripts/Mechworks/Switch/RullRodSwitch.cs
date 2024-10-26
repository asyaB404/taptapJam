using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RullRodSwitch : SwitchBass
{
    public bool canBack=false;
    public bool nowState=false;
    public bool canInteraction=false;
    protected override void Awake()
    {
        base.Awake();
        colliderStr="Player";
    }
    protected override void onEnter(Collider2D other)
    {
        base.onEnter(other);
        canInteraction=true;
        Debug.Log("进入了");
    }
    protected override void onExit(Collider2D other)
    {
        base.onExit(other);
        canInteraction=false;
    }
    protected override void Update()
    {
        base.Update();
        if(canInteraction&&Input.GetKeyDown(KeyCode.E)){
            Unlock();
        }
    }
    public override void Unlock()
    {
        //TODO 添加一个动画
        if(canBack){
            nowState=!nowState;
            base.Unlock(nowState);
        }
        else base.Unlock();
    }
}
