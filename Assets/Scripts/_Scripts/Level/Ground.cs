using System;
using System.Collections;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks.Unity.UnityCharacterController;
using UnityEngine;
using UnityEngine.Tilemaps;


namespace Myd.Platform
{
    public class Ground : MonoBehaviour
    {
        public Color GroundColor;
        private Vector2 moveDirection;
        private Vector3 endPosition=new(0,0,-100);
        private float speed;
        Action action;
        void Update()
        {
            if(endPosition.z==-100)return;
            if(Vector2.Distance(transform.position,endPosition)>0.2){
                moveDirection = (endPosition - transform.position).normalized*Time.deltaTime*speed;
                transform.position+=(Vector3)moveDirection;
            }
            else{
                if(action!=null)action();
                endPosition=new(0,0,-100);
                speed=0;
                action=null;
                 }
        }
        public void Move(Vector2 endPosition,float speed,Action action){
            this.endPosition=endPosition;
            this.speed=speed;
            this.action=action;
        }
        public Vector3 GetMoveDirection(){
            return moveDirection;
        }

    }
}
