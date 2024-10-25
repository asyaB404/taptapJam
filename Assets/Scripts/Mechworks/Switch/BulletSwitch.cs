using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//子弹击中启动
public class BulletSwitch : SwitchBass
{
    public string colliderStr;
    public bool needBack=false;
    protected override void Awake()
    {
        base.Awake();
        colliderStr="Bullet";
    }
    protected override void Update()
    {
        base.Update();
    }
    protected override void onEnter(Collider2D other)
    {
        base.onEnter(other);
        if(needBack)Unlock();
        else Unlock(true);
    }
}
