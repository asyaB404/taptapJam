using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bottle : MonoBehaviour
{
    Animator anim;
    GameObject experienceGame;
    public int healthNub;
    public int staminaNub;
    void Update()
    {

    }
    private void Awake() {
        anim=GetComponent<Animator>();
        experienceGame=AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/Ex.prefab");
    }
    private void OnTriggerEnter2D(Collider2D other) {
        if(other.tag=="bullet"){
            for(int i=0;i<healthNub;i++){
                XpPoint xp=Instantiate(experienceGame).GetComponent<XpPoint>();
                xp.isHealth=true;
                xp.nub=1;
            }
            for(int i=0;i<staminaNub;i++){
                XpPoint xp=Instantiate(experienceGame).GetComponent<XpPoint>();
                xp.isHealth=false;
                xp.nub=1;
            }
            if(anim!=null)anim.SetTrigger(0);
            else gameObject.SetActive(false);
        }
    }
}
