using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using Unity.VisualScripting;
using UnityEngine;

public class BonfireBuild : Interaction
{
    public static GameObject littleFire;
    public static GameObject LittleFire;
    GameObject playerPosition;
    protected override void Awake()
    {
        base.Awake();
        keyCode = KeyCode.R;
        if (LittleFire == null) LittleFire = AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/fire.prefab");
        needShow = false;
    }
    protected override void onEnter(Collider2D other)
    {
        base.onEnter(other);
        playerPosition = other.gameObject;
    }
    protected override void _Interaction()
    {
        base._Interaction();
        BuildFire(playerPosition.transform.position);
    }
    public static void BuildFire(Vector3 v){
        if(v.z<-50)return;
        if (Player.playerIsGround && Game.Player.GetPlayerStamina() >= 10)
        {
            Game.Player.SetPlayerStamina(-10);
            Animator animation;
            if (littleFire)
            {
                animation = littleFire.GetComponent<Animator>();
                if (animation) animation.SetTrigger("vanish");
                Destroy(littleFire);
            }
            littleFire = Instantiate(LittleFire);
            animation = littleFire.GetComponent<Animator>();
            if (animation) animation.SetTrigger("ignite");
            littleFire.transform.position = v;
            print(littleFire.transform.position);
        }
    }
}

