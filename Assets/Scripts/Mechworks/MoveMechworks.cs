using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using BehaviorDesigner.Runtime.Tasks.Unity.UnityTransform;
using Cinemachine.Utility;
using DG.Tweening;
using Myd.Platform;
using Unity.VisualScripting;
using UnityEngine;

public class MoveMechworks : MechworksBass
{
    public List<Transform> transforms;
    int i=0;
    public float speed=5;
    public override void Awake()
    {
        base.Awake();
        if(transforms==null || transforms.Count==0){
            transforms=new();
            for(int i=0;i<transform.parent.GetChild(0).childCount;i++){
                transforms.Add(transform.parent.GetChild(0).GetChild(i));
            }
        }
    }
    public override void Update()
    {
        base.Update();
        GetComponent<Ground>().Move(transforms[i].position,speed,()=>i=(i+1)%transforms.Count());
    }
    public override void Activate()
    {
        base.Activate();
    }
}
