using System;
using cfg;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class StartButton : MonoBehaviour, IPointerClickHandler
{
    private void Start()
    {
        SaveMgr.Instance.SettingData = new SettingData
        {
            Current = new SettingData.Data()
        };

        AudioMgr.PlayMusic(EnumAudioClip.BGM);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        Debug.Log("开始游戏");
        ScenesMgr.Instance.ChangeScenes(0,ES3.KeyExists("Level")?ES3.Load<int>("Level"):2);
    }
}