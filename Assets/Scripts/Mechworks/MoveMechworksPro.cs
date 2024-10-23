using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveMechworksPro : MoveMechworks
{
    bool flag=false;
    public override void Update()
    {if(flag){
        base.Update();}
    }
    public override void Activate()
    {
        base.Activate();
        flag=!flag;
    }
}
