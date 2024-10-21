using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bonfire : Interaction
{
    public GameObject playerOBJ;
    protected override void Awake()
    {
        base.Awake();
        keyCode=KeyCode.E;
    }
    protected override void _Interaction()
    {
        base._Interaction();
        SaveMgr.Instance.playerPosition=playerOBJ.transform.position;
        SaveMgr.Instance.Save();
        
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
    }
    protected override void onEnter(Collider2D other)
    {
        base.onEnter(other);
        playerOBJ=other.gameObject;
    }
}
