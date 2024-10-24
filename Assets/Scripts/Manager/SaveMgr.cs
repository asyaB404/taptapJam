using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Core;
using Core.Items;
using Myd.Platform;
using Test;
using UnityEngine;

public class SaveMgr : Singleton<SaveMgr>
{
    // 设置的数据
    public SettingData SettingData = new();
    public Vector3 FirePosition = new(0, 0, -100); //火堆位置
    public List<bool> notRefreshObjs = new(); //不刷新物品是否还存在
    public float Health = 0; //生命
    public float Stamin = 0; //灵力
    public bool laserUnlocked = false; //能力1
    public bool dashUnlocked = false; //能力2
    public Dictionary<string, int> inventoryItemStacks;

    public Vector2 playerPosition = new(-int.MaxValue, -int.MaxValue);

    /// <summary>
    /// 存档
    /// </summary>
    public void Save()
    {
        Debug.Log("save");
        ResourceMgr.Instance.Resource();
        ResourceMgr.Instance.QuickResource(); //刷新

        FirePosition = BonfireBuild.littleFire != null
            ? BonfireBuild.littleFire.transform.position
            : new(0, 0, -100); //获取具体信息
        notRefreshObjs = ResourceMgr.Instance.NotRefreshObjsSave();
        Health = Game.Player.GetPlayerHealth();
        Stamin = Game.Player.GetPlayerStamina();
        laserUnlocked = (bool)EventMgr.ExecuteEvent("GetlaserUnlocked");
        dashUnlocked = (bool)EventMgr.ExecuteEvent("GetdashUnlocked");
        playerPosition = Game.Player.GetPlayerPosotion();
        inventoryItemStacks = new();
        foreach (var item in TestForInventory.Inventory.GetItems.ToList())
        {
            inventoryItemStacks.Add(item.name, item.count);
        }

        ES3.Save("SettingData", SettingData);
        ES3.Save("FirePosition", FirePosition);
        ES3.Save("NotRefreshObjs", notRefreshObjs);
        ES3.Save("Health", Health);
        ES3.Save("Stamin", Stamin);
        ES3.Save("GetlaserUnlocked", laserUnlocked);
        // Debug.Log(ES3.Load("GetlaserUnlocked"));

        ES3.Save("GetdashUnlocked", dashUnlocked);
        ES3.Save("playerPosition", playerPosition);

        ES3.Save("inventoryItemStacks", inventoryItemStacks);
    }

    /// <summary>
    /// 读档
    /// </summary>
    public void Load()
    {
        Debug.Log("load");
        ResourceMgr.Instance.Resource();
        ResourceMgr.Instance.QuickResource();
        // BonfireBuild.BuildFire();
        if (ES3.KeyExists("SettingData")) SettingData = ES3.Load<SettingData>("SettingData");
        if (FirePosition.z != -100 && ES3.KeyExists("FirePosition")) FirePosition = ES3.Load<Vector3>("FirePosition");
        if (ES3.KeyExists("NotRefreshObjs")) notRefreshObjs = ES3.Load<List<bool>>("NotRefreshObjs");
        if (ES3.KeyExists("Health")) Health = ES3.Load<float>("Health");
        if (ES3.KeyExists("Stamin")) Stamin = ES3.Load<float>("Stamin");
        if (ES3.KeyExists("GetdashUnlocked")) dashUnlocked = ES3.Load<bool>("GetdashUnlocked");
        if (ES3.KeyExists("GetlaserUnlocked")) laserUnlocked = ES3.Load<bool>("GetlaserUnlocked");
        if (ES3.KeyExists("playerPosition")) playerPosition = ES3.Load<Vector2>("playerPosition");
        if (ES3.KeyExists("inventoryItemStacks"))
            inventoryItemStacks = ES3.Load<Dictionary<string, int>>("inventoryItemStacks");

        if (FirePosition.z != -100) BonfireBuild.BuildFire(FirePosition);
        Debug.Log(notRefreshObjs.Count);
        ResourceMgr.Instance.NotRefreshObjsResource(notRefreshObjs);
        Game.Player.SetPlayerHealth(Health);
        Game.Player.SetPlayerStamina(Stamin);
        if (dashUnlocked) EventMgr.ExecuteEvent(EventTypes.UnlockDash);
        else EventMgr.ExecuteEvent(EventTypes.LockDash);
        if (laserUnlocked) EventMgr.ExecuteEvent(EventTypes.UnlockLaser);
        else EventMgr.ExecuteEvent(EventTypes.LockLaser);
        if (playerPosition.x > -1000000) Game.Player.SetPlayerPosition(playerPosition);
        TestForInventory.Inventory.Clear();
        if (inventoryItemStacks != null)
            foreach (string str in inventoryItemStacks.Keys)
            {
                Debug.Log(str);
                TestForInventory.Inventory.AddItem(new(str, inventoryItemStacks[str]));
            }
    }

    public void Clear()
    {
        ES3.DeleteFile("SettingData");
        SettingData = new() { Current = new SettingData.Data() };
        ES3.Save("SettingData", SettingData);
        ES3.DeleteFile("FirePosition");
        FirePosition = new(0, 0, -100);
        ES3.DeleteFile("NotRefreshObjs");
        notRefreshObjs = new();
        ES3.DeleteFile("Health");
        Health = 10;
        ES3.DeleteFile("Stamin");
        Stamin = 10;
        ES3.DeleteFile("GetdashUnlocked");
        dashUnlocked = false;
        ES3.DeleteFile("GetlaserUnlocked");
        laserUnlocked = false;
        ES3.DeleteFile("playerPosition");
        playerPosition = new(-int.MaxValue, -int.MaxValue);
        ES3.DeleteFile("inventoryItemStacks");
        inventoryItemStacks = null;

        ES3.Save("SettingData", SettingData);
        ES3.Save("FirePosition", FirePosition);
        ES3.Save("NotRefreshObjs", notRefreshObjs);
        ES3.Save("Health", Health);
        ES3.Save("Stamin", Stamin);
        ES3.Save("GetlaserUnlocked", laserUnlocked);
        ES3.Save("GetdashUnlocked", dashUnlocked);
        ES3.Save("playerPosition", playerPosition);
        ES3.Save("inventoryItemStacks", inventoryItemStacks);
        Debug.Log(laserUnlocked);
        Load();
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
        public float SoundVolume = 0.8f; //音效音量
        public float BGMVolume = 0.5f; //音乐音量 
        public bool SoundMute = false; //音效静音
        public bool BGMMute = false; //音乐静音
    }
}