using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//激光充能启动
public class LaserSwitch : SwitchBass
{
    public float charge=0;
    private float backTime=1f;
    private float A=0.2f;
    private float maxCharge=5;
    private float addCharge=1f;
    public Color startColor=Color.black;
    bool over=false;
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
        if(over)return;
        base.Update();;
        this.GetComponent<SpriteRenderer>().color=Color.Lerp(startColor,myColor,charge/maxCharge);
        if(backTime>0)backTime-=addCharge*Time.deltaTime;
        if(backTime<0){
            if(charge>0)charge-=addCharge*Time.deltaTime;
        }
    }
    public void LaserCharge(){
        Debug.Log("射中了");
        if(charge<=maxCharge)charge+=A*addCharge;
        if(charge>maxCharge){
            Unlock(true);
            over=1==1;
            }
        backTime=1;
    }
}
