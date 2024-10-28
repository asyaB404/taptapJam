using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;

public class DarkObject : MonoBehaviour
{
    int layerMask;
    private void Awake()
    {
        layerMask=gameObject.layer;

        this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
        this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0.01f, 0);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = layerMask;
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(1, 1);
        }
    }
    
    private void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0.01f, 1);
        }
    }
}
