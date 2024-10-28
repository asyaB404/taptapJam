using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Tilemaps;

public class DarkObject_Tilemap : MonoBehaviour
{
    private void Awake()
    {
        this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
        this.gameObject.transform.GetComponent<TilemapRenderer>().material.DOFade(0.002f, .5f);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = LayerMask.NameToLayer("Ground");
            this.gameObject.transform.GetComponent<TilemapRenderer>().material.DOFade(1, .5f);
        }
    }
    
    private void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
            this.gameObject.transform.GetComponent<TilemapRenderer>().material.DOFade(0.002f, .5f);
        }
    }
}
