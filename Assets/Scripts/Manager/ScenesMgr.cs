using System.Collections;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks.Unity.UnityGameObject;
using Myd.Platform;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ScenesMgr : MonoSingleton<ScenesMgr>
{
    ScenesMgr(){
    }
    public void ChangeScenes(int enter,int exit){
        SaveMgr.Instance.level=exit;
        SaveMgr.Instance.Save();
        SaveMgr.Instance.SceneChangeClear();
        SceneManager.LoadScene(exit);
        StartCoroutine(DelayedAction(0.2f,enter));  
    }
    IEnumerator DelayedAction(float delay,int enter)  
    {  
        // 等待指定的延迟时间  
        yield return new WaitForSeconds(delay);  
        GameObject a=GameObject.Find("Enter"+enter);
        if(a){
            Game.Player.SetPlayerPosition(a.transform.position);
        }
        SaveMgr.Instance.LoadPlayer();
    }  
}
