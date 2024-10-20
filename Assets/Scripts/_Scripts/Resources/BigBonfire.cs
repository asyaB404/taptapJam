using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BigBonfire : Bonfire
{
    public string skillType=EventTypes.UnlockLaser;//能力名称
    protected override void _Interaction()
    {
        EventMgr.ExecuteEvent(skillType);
        base._Interaction();
    }
}
