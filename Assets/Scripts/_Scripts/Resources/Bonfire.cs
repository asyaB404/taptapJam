using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bonfire : Interaction
{
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }
    protected override void _Interaction()
    {
        base._Interaction();
        SaveMgr.Instance.Save();
    }
}
