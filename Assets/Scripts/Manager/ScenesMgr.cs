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
        if(enter!=0)SaveMgr.Instance.Save();
        SaveMgr.Instance.SceneChangeClear();
        if(exit!=-1)SceneManager.LoadScene(exit);
        else SceneManager.LoadScene(2);
        StartCoroutine(DelayedAction(0.5f,enter));  
    }
    public void ChangeScenes(int exit){
        SaveMgr.Instance.level=exit;
        SaveMgr.Instance.SceneChangeClear();
        if(exit!=-1)SceneManager.LoadScene(exit);
        else SceneManager.LoadScene(2); 
    }
    IEnumerator DelayedAction(float delay,int enter)  
    {  
        // 等待指定的延迟时间  
        yield return new WaitForSeconds(delay);  
        GameObject a=GameObject.Find("Enter"+enter);
        if(a!=null){
            Game.Player.SetPlayerPosition(a.transform.position);
        }
        SaveMgr.Instance.LoadPlayer();
    }  
}
