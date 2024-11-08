﻿

using Myd.Common;
using Myd.Platform;
using Myd.Platform.Core;
using Unity.Burst.Intrinsics;
using UnityEngine;

namespace Myd.Platform
{
    /// <summary>
    /// 玩家类：包含
    /// 1、玩家显示器
    /// 2、玩家控制器（核心控制器）
    /// 并允许两者在内部进行交互
    /// </summary>
    public class Player
    {
        private PlayerRenderer playerRenderer;
        private PlayerController playerController;
        
        private IGameContext gameContext;

        /// <summary>
        /// 角色是否在地面上
        /// </summary>
        public static bool playerIsGround;
        
        public Player(IGameContext gameContext)
        {
            this.gameContext = gameContext;
        }

        //加载玩家实体
        public void Reload(Bounds bounds, Vector2 startPosition)
        {
            //this.playerRenderer = Object.Instantiate(Resources.Load<PlayerRenderer>("PlayerRenderer"));
            //this.playerRenderer = AssetHelper.Create<PlayerRenderer>("Assets/ProPlatformer/_Prefabs/PlayerRenderer.prefab");
            var instance = AssetMgr.LoadAssetSync<GameObject>("Assets/AddressableAssets/GameRes/Prefabs/PlayerRenderer.prefab");
            this.playerRenderer = Object.Instantiate(instance).GetComponent<PlayerRenderer>();
            this.playerRenderer.Reload();
            //初始化
            this.playerController = new PlayerController(playerRenderer, gameContext.EffectControl);
            this.playerController.Init(bounds, startPosition);

            PlayerParams playerParams = Resources.Load<PlayerParams>("PlayerParam");
            //PlayerParams playerParams = AssetHelper.LoadObject<PlayerParams>("Assets/ProPlatformer/PlayerParam.asset");
            playerParams.SetReloadCallback(() => this.playerController.RefreshAbility());
            playerParams.ReloadParams();
        }

        public void Update(float deltaTime)
        {
            playerController.Update(deltaTime);
            Render();
            playerIsGround = playerController.IsOnGround;
        }

        private void Render()
        {
            playerRenderer.Render(Time.deltaTime);

            Vector2 scale = playerRenderer.transform.localScale;
            scale.x = Mathf.Abs(scale.x) * (int)playerController.Facing;
            playerRenderer.transform.localScale = scale;
            playerRenderer.transform.position = playerController.Position;

            // if (!lastFrameOnGround && this.playerController.OnGround)
            // {
            //     this.playerRenderer.PlayMoveEffect(true, this.playerController.GroundColor);
            // }
            // else if (lastFrameOnGround && !this.playerController.OnGround)
            // {
            //     this.playerRenderer.PlayMoveEffect(false, this.playerController.GroundColor);
            // }
            // this.playerRenderer.UpdateMoveEffect();

            this.lastFrameOnGround = this.playerController.OnGround;
        }

        private bool lastFrameOnGround;

        public Vector2 GetCameraPosition()
        {
            if (this.playerController == null)
            {
                return Vector3.zero;
            }
            return playerController.GetCameraPosition();
        }
        
        /// <summary>
        /// 增长的数值
        /// </summary>
        /// <param name="health"></param>
        public void SetPlayerHealth(float health)
        {
            playerController.PlayerHealth += health;
            Debug.Log(health);
        }
        
        public float GetPlayerHealth()
        {
            return playerController.PlayerHealth;
        }
        
        /// <summary>
        /// 增长的数值
        /// </summary>
        /// <param name="stamina"></param>
        public void SetPlayerStamina(float stamina)
        {
            playerController.PlayerStamina += stamina;
        }
        
        public float GetPlayerStamina()
        {
            return playerController.PlayerStamina;
        }
        public Vector3 GetPlayerPosotion(){
            return playerController.Position;
        }
        public void SetPlayerPosition(Vector2 v){
            playerController.SetPosition(v);
            Debug.Log(v);
        }
    }

}
