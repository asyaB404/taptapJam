using System.Collections;
using System.Collections.Generic;
using Core.Items;
using Test;
using UnityEngine;

public class ResourceBass : Interaction
{
    public static Dictionary<string,ItemStack> stringToStack=new(){
        {"laogane",new ItemStack()}
    };
    public string resoureName;
    int nub;
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }   
    void ResourceAdd(int nub,string name){
        // TestForInventory.Inventory.AddItem
    }
    protected override void _Interaction()
    {
        canInteraction=false;
        ResourceAdd(nub,resoureName);
        gameObject.SetActive(false);
        base._Interaction();
    }
}
