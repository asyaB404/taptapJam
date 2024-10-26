using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//子弹击中启动
public class BulletSwitch : SwitchBass
{
    protected override void Awake()
    {
        base.Awake();
        colliderStr="bullet";
    }
    protected override void Update()
    {
        base.Update();
    }
    protected override void onEnter(Collider2D other)
    {
        Debug.Log("射中了");
        base.onEnter(other);
        Unlock(true);
        GameObject.Destroy(this.gameObject);
    }
}
