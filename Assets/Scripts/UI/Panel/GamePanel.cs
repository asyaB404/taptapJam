using Myd.Platform;
using UI.Inventory;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Panel
{
    public class GamePanel : BasePanel<GamePanel>
    {
        [SerializeField] private ItemSlot[] hotItemSlots;
        [SerializeField] private Image staminaAmount;
        [SerializeField] private Image hpImage;
        private float Hp => Game.Player.GetPlayerHealth();
        private float Stamina => Game.Player.GetPlayerStamina();

        private float MaxStamina => Constants.playerMaxStamina;

        public override void Init()
        {
            base.Init();
            for (int i = 0; i < hotItemSlots.Length; i++)
            {
                ItemSlot itemSlot = hotItemSlots[i];
                itemSlot.id = i;
            }
        }


        public override void OnPressedEsc()
        {
            PlayerStatusPanel.Instance.ShowMe();
        }


        public void UpdateStaminaDisPlay()
        {
            staminaAmount.fillAmount = Stamina / MaxStamina;
        }

        public void UpdateHealthDisPlay()
        {
            float height = hpImage.rectTransform.sizeDelta.y;
            hpImage.rectTransform.sizeDelta = new Vector2(100 * Hp, height);
        }

        public void UpdateHotItemDisPlay()
        {
            var hotItemStacks = PlayerStatusPanel.Instance.inventory.HotItemStacks;
            foreach (var slot in hotItemSlots)
            {
                slot.UpdateDisplayFromInventory(hotItemStacks);
            }
        }

        public override void CallBack(bool flag)
        {
            gameObject.SetActive(flag);
        }
    }
}