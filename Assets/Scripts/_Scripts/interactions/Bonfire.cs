using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using UI.Panel;
using UnityEngine;
using UnityEngine.UI;

public class Bonfire : ResourceBass
{
    public GameObject ShowBottonOBJ2;
    protected GameObject showButtonOBJ2;
    // KeyCode keyCode;
   
    // public float b;
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }
    protected override void _Interaction()
    {
        BonfireMenuPanel.Instance.ShowMe();
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
