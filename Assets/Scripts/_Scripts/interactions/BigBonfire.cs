using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BigBonfire : Bonfire
{
    public string skillType=EventTypes.UnlockLaser;//能力名称
    protected override void Awake()
    {
        base.Awake();
        // if(!FireManager.Instance.GetBonfires().Contains(this)){
        GetComponent<Animator>().Play("ignite");

        // }
    }
    protected override void _Interaction()
    {

        EventMgr.ExecuteEvent(skillType);
        base._Interaction();
        showButtonOBJ2.transform.GetChild(0).gameObject.SetActive(true);

    }
}
// public class FireManager:Singleton<FireManager>{
//     private List<Bonfire> bonfires;
//     public List<Bonfire> GetBonfires(){
//         if(bonfires!=null)return bonfires;
//         return null;
//     }
//     public void AddBonfires(Bonfire bonfire){
//         bonfires.Add(bonfire);
//     }
//     public void SetBonfires(List<Bonfire> bonfires){
//         bonfires
//     }
// }