using System.Collections;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks.Unity.UnityTransform;
using DG.Tweening;
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
        {if(canBack){
            nowState=!nowState;
            transform.GetChild(0).transform.DORotate(new Vector3(0,0,-30-30* (nowState?1:-1)),0.2f).OnComplete(()=>base.Unlock(nowState));
        }
        else transform.GetChild(0).DORotate(new Vector3(0,-60,0),1).OnComplete(()=>base.Unlock());}
        transform.GetChild(2).gameObject.SetActive(canBack&&nowState||!canBack);
    }
}
