using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using UnityEngine;
using UnityEngine.UI;

public class Bonfire : Interaction
{
    public GameObject ShowBottonOBJ2;
    protected GameObject showButtonOBJ2;
   
    // public float b;
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }
    protected override void _Interaction()
    {
        
        base._Interaction();
        // showButtonOBJ.SetActive(false);
        // SaveMgr.Instance.Save();
    }
    protected override void Update()
    {
        base.Update();
        if(Input.GetKey(KeyCode.P)){
            print("清除存档");
            SaveMgr.Instance.Clear();
        }
        if(Input.GetKey(KeyCode.L)){
            SaveMgr.Instance.Load();
        }
        if(Input.GetKeyDown(KeyCode.I))SaveMgr.Instance.Save();
        if(Input.GetKey(KeyCode.O)){
            var hub=CraftGuideMgr.Instance.GetCraftGuide();
            foreach(var a in hub.Keys){
                string b=hub[a].ItemInfo.name;
                foreach(var c in a){
                    b+=c.ItemInfo.name;
                }
                Debug.Log(b);
            }
        }
        if(Input.GetKeyDown(KeyCode.Z)){
            foreach(var i in CraftGuideMgr.Instance.MakeTable.Keys){
            CraftGuideMgr.Instance.MakeItem(i);
            return;
            }
        }
    }
    protected override void onExit(Collider2D other)
    {
        base.onExit(other);
    }
}
