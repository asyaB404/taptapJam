using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;

public class DarkObject : MonoBehaviour
{
    private void Awake()
    {
        this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
        this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0.3f, 0);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = LayerMask.NameToLayer("Ground");
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(1, 1);
        }
    }
    
    private void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("Light"))
        {
            this.gameObject.layer = LayerMask.NameToLayer("DarkObject");
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0.3f, 1);
        }
    }
}
