using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SwitchBass : Interaction
{
    public MechworksBass mechworks;
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }
    public virtual void Unlock(){
        if(mechworks)mechworks.Activate();
    }
    protected override void _Interaction()
    {
        base._Interaction();
        Unlock();
    }
}
