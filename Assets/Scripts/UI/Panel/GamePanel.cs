using UI.Inventory;
using UnityEngine;

namespace UI.Panel
{
    public class GamePanel : BasePanel<GamePanel>
    {
        [SerializeField] private ItemSlot[] hotItemSlots;

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
        }

        public void UpdateHealthDisPlay()
        {
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