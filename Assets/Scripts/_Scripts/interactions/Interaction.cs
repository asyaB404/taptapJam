using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor.VersionControl;
using UnityEngine;
using UnityEngine.UI;

public class Interaction : MonoBehaviour
{
    protected bool canInteraction = false;
    public GameObject canvas;
    public GameObject ShowButtonOBJ;
    public GameObject showButtonOBJ;
    protected bool needShow = true;
    public float a=100;
    protected KeyCode keyCode;
    // public GameObject canvasOBJ;
    // public GameObject ShowUI;
    protected virtual void Awake()
    {
        // if(canvasOBJ==null){
        //     canvasOBJ=FindObjectOfType<Canvas>().gameObject;
        // }
        ShowButtonOBJ = AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/prefab/Resource/ShowButton.prefab");
        canvas = GameObject.Find("Canvas").gameObject;
    }
    protected virtual void OnTriggerEnter2D(Collider2D other)
    {
        if (other.tag == "Player")
        {
            ShowButton();
            onEnter(other);
        }
    }
    protected virtual void ShowButton()
    {
        if (needShow)
        {
            if (showButtonOBJ == null)
            {
                showButtonOBJ = Instantiate(ShowButtonOBJ);
                showButtonOBJ.transform.SetParent(canvas.transform);
            }
            showButtonOBJ.SetActive(true);
            showButtonOBJ.transform.position = Camera.main.WorldToScreenPoint(this.transform.position) + new Vector3(0, a, 0);
            showButtonOBJ.transform.GetChild(1).GetComponent<Text>().text=keyCode.ToString();
        }
    }
    protected virtual void OnTriggerExit2D(Collider2D other)
    {
        if (showButtonOBJ != null)
        {
            showButtonOBJ.SetActive(false);
        }
        if (other.tag == "Player")
        {
            onExit(other);
        }
    }
    protected virtual void onEnter(Collider2D other)
    {
        // print(keyCode);
        canInteraction = true;
    }
    protected virtual void onExit(Collider2D other)
    {
        canInteraction = false;
    }
    protected virtual void Update()
    {
        if (canInteraction) if (Input.GetKeyDown(keyCode))
            {
                _Interaction();
            }
        if(showButtonOBJ!=null&&showButtonOBJ.activeSelf)
            showButtonOBJ.transform.position = Camera.main.WorldToScreenPoint(this.transform.position) + new Vector3(0, a, 0);
    }
    protected virtual void _Interaction()
    {
        print("按下");
        // if(ShowUI==null){
        //     ShowUI=PoolMgr.Spawn("Assets/AddressableAssets/prefab/Resource/ShowButton");
        //     ShowUI.transform.SetParent(canvasOBJ.transform);

        // }
        // ShowUI.SetActive(true);

    }
}
