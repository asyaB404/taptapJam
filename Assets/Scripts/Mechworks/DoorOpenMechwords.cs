using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using Myd.Platform;
using UnityEngine;

public class DoorOpenMechwords : MechworksBass
{
    public override void Activate()
    {
        base.Activate();
        Activate(true);
    }
    private Vector3 startPosition;
    public override void Awake()
    {
        base.Awake();
        startPosition=transform.position;
    }
    public override void Activate(bool flag)
    {
        base.Activate(flag);
        if(flag){
            Debug.Log(gameObject.name+"门开了");
            AudioMgr.PlaySound(cfg.EnumAudioClip.开门);
            GetComponent<Ground>().Move(
            startPosition+new Vector3(0,GetComponent<Renderer>().bounds.size.y*2),
                GetComponent<Renderer>().bounds.size.y,
                    ()=>gameObject.SetActive(false));
        }
        else{
            AudioMgr.PlaySound(cfg.EnumAudioClip.开门);
            gameObject.SetActive(true);
            GetComponent<Ground>().Move(
            startPosition,
                GetComponent<Renderer>().bounds.size.y,null);
        }
    }
}
