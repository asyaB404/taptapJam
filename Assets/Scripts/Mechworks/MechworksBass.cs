using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MechworksBass : MonoBehaviour
{
    protected bool isActivate;
    public virtual void Activate(){}
    public virtual void Activate(bool flag){
        Debug.Log(gameObject.name+flag);
    }
    public virtual void Update(){}
    public virtual void Awake(){}

}
