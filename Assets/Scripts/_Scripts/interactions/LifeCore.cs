using System.Collections;
using System.Collections.Generic;
using Myd.Platform;
using UnityEngine;

public class LifeCore : MonoBehaviour
{
    public bool isLife;
    public int nub;
    private void OnTriggerEnter2D(Collider2D other)
    {
        Debug.Log(other.tag);
        if (other.CompareTag("Player"))
        {
            Debug.Log("我碰到了");
            if(isLife)Game.Player.SetPlayerHealth(nub);
            else Game.Player.SetPlayerStamina(nub);
            // TODO:增加粒子效果和动画 DOTween来做，OnComplete后销毁物体
            gameObject.SetActive(false);
        }
    }
}
