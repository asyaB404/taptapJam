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

    public string colliderStr;
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
        gameObject.SetActive(false);
        base._Interaction();
    }
}
