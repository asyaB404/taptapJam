using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DoorOpenMechwords : MechworksBass
{
    public override void Activate()
    {

        base.Activate();
        Debug.Log(gameObject.name+"门开了");
        AudioMgr.PlaySound(cfg.EnumAudioClip.主角受击);

        GameObject.Destroy(this.gameObject);
    }
}
