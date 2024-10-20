using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.VersionControl;
using UnityEngine;

public class Interaction : MonoBehaviour
{
    protected bool canInteraction=false;
    public GameObject ShowButton;
    public GameObject showButton;
    protected bool needShow=true;
    protected KeyCode keyCode;
    // public GameObject canvasOBJ;
    // public GameObject ShowUI;
    protected virtual void Awake(){
        // if(canvasOBJ==null){
        //     canvasOBJ=FindObjectOfType<Canvas>().gameObject;
        // }
        ShowButton=AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/ShowButton.prefab");
    }
    protected virtual void OnTriggerEnter2D(Collider2D other) {
        if(other.tag=="Player"){
            if(needShow){if(showButton==null){
                showButton=Instantiate(ShowButton);
                showButton.transform.SetParent(this.transform);
            }
            showButton.SetActive(true);
            showButton.transform.position=this.transform.position+new Vector3(0,1,0);
            }onEnter(other);
        }
    }
    protected virtual void OnTriggerExit2D(Collider2D other)
    {
        if(showButton!=null){
                showButton.SetActive(false);
            }
        if(other.tag=="Player"){
            onExit(other);
        }
    }
    protected virtual void onEnter(Collider2D other){
        // print(keyCode);
        canInteraction=true;
    }
    protected virtual void onExit(Collider2D other){
        canInteraction=false;
    }
    protected virtual void Update() {
        if(canInteraction)if(Input.GetKeyDown(keyCode)){
            _Interaction();
        }
    }
    protected virtual void _Interaction(){
        print("按下");
        // if(ShowUI==null){
        //     ShowUI=PoolMgr.Spawn("Assets/AddressableAssets/prefab/Resource/ShowButton");
        //     ShowUI.transform.SetParent(canvasOBJ.transform);

        // }
        // ShowUI.SetActive(true);
        
    }
}
