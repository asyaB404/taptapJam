using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SaveMgr : Singleton<SaveMgr>
{
    // 设置的数据
    public SettingData SettingData;


    /// <summary>
    /// 存档
    /// </summary>
    public void Save()
    {
        
    }

    /// <summary>
    /// 读档
    /// </summary>
    public void Load()
    {
        
    }
}

public class SettingData
{
    /// <summary>
    /// 当前设置
    /// </summary>
    public Data Current;

    [System.Serializable]
    public class Data
    {
        //默认数据
        public float SoundVolume = 0.8f;//音效音量
        public float BGMVolume = 0.5f;//音乐音量 
        public bool SoundMute = false;//音效静音
        public bool BGMMute = false;//音乐静音
    }

}