using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//激光充能启动
public class LaserSwitch : SwitchBass
{
    public float charge=0;
    public float backTime=1;
    public float A=1;
    private float maxCharge=5;
    private float addCharge=0.1f;
    Color myColor=Color.red;
    protected override void Awake()
    {
        base.Awake();
    }
    protected override void _Interaction(){}
    /// <summary>
    /// Update is called every frame, if the MonoBehaviour is enabled.
    /// </summary>
    protected override void Update()
    {
        base.Update();;
        this.GetComponent<SpriteRenderer>().color=myColor*charge/maxCharge;
        if(backTime>0)backTime-=addCharge;
        if(backTime<0){
            charge-=addCharge*Time.deltaTime;
        }
    }
    public void LaserCharge(){
        if(charge<=maxCharge)charge+=A*addCharge;
        if(charge>maxCharge)Unlock(true);
        backTime=1;
    }
}
