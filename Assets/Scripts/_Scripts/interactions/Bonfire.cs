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
        showButtonOBJ.SetActive(false);
        if (showButtonOBJ2 == null)
            {
                showButtonOBJ2 = Instantiate(ShowBottonOBJ2);
                showButtonOBJ2.transform.SetParent(canvas.transform);
            }
        showButtonOBJ2.transform.GetChild(0).GetComponent<Button>().onClick.AddListener(()=>Game.Player.SetPlayerHealth(1000));//回血
        showButtonOBJ2.transform.GetChild(1).GetComponent<Button>().onClick.AddListener(()=>Game.Player.SetPlayerHealth(1000));//制作
        showButtonOBJ2.transform.GetChild(2).GetComponent<Button>().onClick.AddListener(()=>SaveMgr.Instance.Save());
        showButtonOBJ2.transform.GetChild(3).GetComponent<Button>().onClick.AddListener(()=>showButtonOBJ2.SetActive(false));
        showButtonOBJ2.SetActive(true);

        // SaveMgr.Instance.Save();

        
    }
    protected override void Update()
    {
        base.Update();
        if(showButtonOBJ2!=null&&showButtonOBJ2.activeSelf)
            showButtonOBJ2.transform.position = Camera.main.WorldToScreenPoint(this.transform.position) + new Vector3(-100, 0, 0);
        
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
        if(showButtonOBJ2)showButtonOBJ2.SetActive(false);
    }
}
