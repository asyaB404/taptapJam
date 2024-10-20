using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using UnityEngine;

public class SaveMgr : Singleton<SaveMgr>
{
    // 设置的数据
    public SettingData SettingData=new();
    public Vector3 FirePosition=new();//火堆位置
    public List<bool> notRefreshObjs=new();//不刷新物品是否还存在
    public float Health=0;//生命
    public float Stamin=0;//灵力
    public bool laserUnlocked=false;//能力1
    public bool dashUnlocked=false;//能力2


    /// <summary>
    /// 存档
    /// </summary>
    public void Save()
    {
        ResourceMgr.Instance.Resource();
        ResourceMgr.Instance.QuickResource();//刷新

        FirePosition=BonfireBuild.littleFire!=null?BonfireBuild.littleFire.transform.position:new(0,0,-100);//获取具体信息
        notRefreshObjs= ResourceMgr.Instance.NotRefreshObjsSave();
        Health=Game.Player.GetPlayerHealth();
        Stamin=Game.Player.GetPlayerStamina();
        laserUnlocked= (bool)EventMgr.ExecuteEvent("GetlaserUnlocked");
        dashUnlocked= (bool)EventMgr.ExecuteEvent("GetdashUnlocked");

        ES3.Save("SettingData",SettingData);
        ES3.Save("FirePosition",FirePosition);
        Debug.Log(notRefreshObjs.Count);

        ES3.Save("NotRefreshObjs",notRefreshObjs);
        ES3.Save("Health",Health);
        ES3.Save("Stamin",Stamin);
        ES3.Save("GetlaserUnlocked",laserUnlocked);
        ES3.Save("GetdashUnlocked",dashUnlocked);
        
    }

    /// <summary>
    /// 读档
    /// </summary>
    public void Load()
    {
        ResourceMgr.Instance.Resource();
        ResourceMgr.Instance.QuickResource();
        // BonfireBuild.BuildFire();
        ES3.Load("SettingData",SettingData);
        ES3.Load("FirePosition",FirePosition);
        ES3.Load("NotRefreshObjs",notRefreshObjs);
        ES3.Load("Health",Health);
        ES3.Load("Stamin",Stamin);
        ES3.Load("GetdashUnlocked",dashUnlocked);
        ES3.Load("GetlaserUnlocked",laserUnlocked);

        BonfireBuild.BuildFire(FirePosition);
        Debug.Log(notRefreshObjs.Count);
        ResourceMgr.Instance.NotRefreshObjsResource(notRefreshObjs);
        Game.Player.SetPlayerHealth(Health);
        Game.Player.SetPlayerStamina(Stamin);
        if(!dashUnlocked)EventMgr.ExecuteEvent(EventTypes.UnlockDash);
        else EventMgr.ExecuteEvent(EventTypes.LockDash);
        if(!laserUnlocked)EventMgr.ExecuteEvent(EventTypes.UnlockLaser);
        else EventMgr.ExecuteEvent(EventTypes.LockLaser);
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