using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//机关启动点
public class SwitchBass : Interaction
{
    public MechworksBass mechworks;
    protected override void Awake()
    {
        base.Awake();
    }
    public virtual void Unlock(){
        if(mechworks)mechworks.Activate();
    }
    public virtual void Unlock(bool flag){
        if(mechworks)mechworks.Activate(flag);
    }
}
