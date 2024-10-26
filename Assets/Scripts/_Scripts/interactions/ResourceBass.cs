using System.Collections;
using System.Collections.Generic;
using Core.Items;
using Test;
using UnityEngine;
//按e交互
public class ResourceBass : Interaction
{
    public string resoureName;
    int nub;
    protected KeyCode keyCode;
    public bool canInteraction = false;


    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
        colliderStr="Player";
    }
    protected override void Update()
    {
        base.Update();
        if(canInteraction&&Input.GetKeyDown(keyCode)){
            _Interaction();
        }
    }
    void ResourceAdd(int nub,string name){
        TestForInventory.Inventory.AddItem(new(resoureName));
    }
    protected override void _Interaction()
    {
        canInteraction=false;
        ResourceAdd(nub,resoureName);
        if(!this is Bonfire){//我知道这很草率，不管了，时间紧任务重
                    AudioMgr.PlaySound(cfg.EnumAudioClip.采摘);
        }
        gameObject.SetActive(false);
        base._Interaction();
    }
    protected override void onEnter(Collider2D other)
    {
        base.onEnter(other);
        canInteraction=true;
    }
    protected override void onExit(Collider2D other)
    {
        canInteraction=false;
    }
}
