using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using Myd.Platform;
using UnityEngine;

public class XpPoint : MonoBehaviour
{
    float speed=1;
    public float nub;
    public bool isHealth;
    private void Awake() {
        speed=Random.Range(0.8f,1.2f)*5;
    }
    private void Update() {
        Vector3 playerPosition=Game.Player.GetPlayerPosotion();
        transform.position+=(playerPosition-transform.position).normalized*speed*Time.deltaTime;
        if(Vector2.Distance(playerPosition,transform.position)<0.01){
            if(isHealth)Game.Player.SetPlayerHealth(nub);
            else Game.Player.SetPlayerStamina(nub);
            Destroy(this.gameObject);
        }
    }
}
