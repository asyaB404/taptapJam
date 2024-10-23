using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using Unity.VisualScripting;
using UnityEngine;

public class BonfireBuild 
{
    public static GameObject littleFire;
    public static GameObject LittleFire;
    GameObject playerPosition;
    public static void BuildFire(Vector3 v){
        Debug.Log("建筑");
        if(v.z<-50)return;
        if (LittleFire == null) LittleFire = AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/fire.prefab");
        // if (Player.playerIsGround && )
        // {
            Game.Player.SetPlayerStamina(-10);
            Animator animation;
            if (littleFire)
            {
                animation = littleFire.GetComponent<Animator>();
                // if (animation) animation.Play("vanish");
                GameObject.Destroy(littleFire);
            }
            littleFire = GameObject.Instantiate(LittleFire);
            animation = littleFire.GetComponent<Animator>();
            if (animation) animation.Play("ignite");
            littleFire.transform.position = v;
            // print(littleFire.transform.position);
        // }
    }
}

