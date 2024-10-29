using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExitAndReturn :MonoBehaviour
{
    public void Return(){
        Debug.Log("按下");
        ScenesMgr.Instance.ChangeScenes(0);
    }
    public void Exit(){
        Application.Quit();
    }
}
