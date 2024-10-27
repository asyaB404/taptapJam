using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightUnlocker : MonoBehaviour
{
    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            other.transform.Find("Light").gameObject.SetActive(true);
            // TODO:增加粒子效果和动画 DOTween来做，OnComplete后销毁物体
            Destroy(gameObject);
        }
    }
}
