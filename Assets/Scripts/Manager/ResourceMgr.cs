using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResourceMgr : Singleton<ResourceMgr>
{
    // public Dictionary<Vector3,string> notRefreshObjs,ordinaryRefreshObjs,rapidRefreshObjs;
    // List<bool> notRefreshsbools;
    GameObject notRefreshObjs,ordinaryRefreshObjs,quickRefreshObjs;
    GameObject RefreshObjs;
    public ResourceMgr(){
        // ES3.Save<List<bool>>("notRefreshsbools",new List<bool>(){true,true,true});
        if(RefreshObjs==null){RefreshObjs=new GameObject("RefreshObjs");RefreshObjs.transform.position=new(0,0);}
        if(ordinaryRefreshObjs==null){
            ordinaryRefreshObjs=GameObject.Instantiate(AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/ordinaryRefreshObjs.prefab"));
            ordinaryRefreshObjs.transform.SetParent(RefreshObjs.transform);
            ordinaryRefreshObjs.transform.position=new(0,0);
        }if(notRefreshObjs==null){
            notRefreshObjs=GameObject.Instantiate(AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/notRefreshObjs.prefab"));
            notRefreshObjs.transform.SetParent(RefreshObjs.transform);
            notRefreshObjs.transform.position=new(0,0);
        }if(quickRefreshObjs==null){
            quickRefreshObjs=GameObject.Instantiate(AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/rapidRefreshObjs.prefab"));
            quickRefreshObjs.transform.SetParent(RefreshObjs.transform);
            quickRefreshObjs.transform.position=new(0,0);
        }
    }
    public void NotRefreshObjsResource(List<bool> notRefreshsbools){
        // notRefreshsbools=SaveMgr.Instance.notRefreshObjs;
        // Debug.Log("55555555555555555555"+notRefreshsbools+notRefreshsbools.Count);
        if(notRefreshsbools!=null)for(int i=0;i<notRefreshObjs.transform.childCount;i++){//不可刷新物品的初始化
            if(i<notRefreshsbools.Count
                // &&notRefreshsbools[i]
                ){
                Debug.Log(notRefreshObjs.transform.GetChild(i).gameObject.name+notRefreshsbools[i]);
                notRefreshObjs.transform.GetChild(i).gameObject.SetActive(notRefreshsbools[i]);
            }
        }
    }
    public void Resource(){//普通刷新
        for(int i=0;i<ordinaryRefreshObjs.transform.childCount;i++){
            ordinaryRefreshObjs.transform.GetChild(i).gameObject.SetActive(true);
        }
        QuickResource();
    }
    public void QuickResource(){//快速刷新
        for(int i=0;i<quickRefreshObjs.transform.childCount;i++){
            quickRefreshObjs.transform.GetChild(i).gameObject.SetActive(true);
        }
    }
    public List<bool> NotRefreshObjsSave(){
        List<bool> bools=new();
        Debug.Log(notRefreshObjs.transform.childCount);
        for(int i=0;i<notRefreshObjs.transform.childCount;i++){
            bools.Add(notRefreshObjs.transform.GetChild(i).gameObject.activeSelf);
            Debug.Log(notRefreshObjs.transform.GetChild(i).gameObject.activeSelf);
        }
        // ES3.Save("notRefreshsbools",bools);
        return bools;
    }
}
