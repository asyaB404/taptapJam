using UnityEngine.UI;

namespace UI.Panel
{
    public class GamePanel : BasePanel<GamePanel>
    {
        public override void Init()
        {
            base.Init();
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
        }

        public override void CallBack(bool flag)
        {
            gameObject.SetActive(flag);
        }
    }
}