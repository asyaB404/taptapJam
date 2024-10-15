using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;

public class DarkObject : MonoBehaviour
{
    private void Awake()
    {
        this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0, 0);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        Debug.Log("Enter");
        if (other.CompareTag("Light"))
        {
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(1, 1);
        }
    }
    
    private void OnTriggerExit2D(Collider2D other)
    {
        Debug.Log("Exit");
        if (other.CompareTag("Light"))
        {
            this.gameObject.transform.GetComponent<SpriteRenderer>().DOFade(0, 1);
        }
    }
}
