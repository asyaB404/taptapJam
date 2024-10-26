using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class Interaction : MonoBehaviour
{    protected bool needShow = true;
    static GameObject uiParent;
    protected string colliderStr;

    protected virtual void Awake()
    {
    }
    protected virtual void OnTriggerEnter2D(Collider2D other)
    {
        Debug.Log(other.tag);
        if (other.tag == colliderStr)
        {
            ShowButton();
            onEnter(other);
        }
    }
    protected virtual void ShowButton()
    {
        if (needShow)
        {
        }
    }
    protected virtual void OnTriggerExit2D(Collider2D other)
    {
        if (other.tag == colliderStr)
        {
            onExit(other);
        }
    }
    protected virtual void onEnter(Collider2D other)
    {
        // print(keyCode);
    }
    protected virtual void onExit(Collider2D other)
    {
    }
    protected virtual void Update()
    {
    }
    protected virtual void _Interaction()
    {
        print("按下");

    }
}
