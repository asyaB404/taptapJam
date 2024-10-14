using UnityEngine.UI;

namespace UI.Panel
{
    public class GamePanel : BasePanel<GamePanel>
    {
        public override void Init()
        {
            base.Init();
            GetControl<Button>("BackpackBtn").onClick.AddListener(() => {PlayerStatusPanel.Instance.ShowMe(); });
        }

        public override void CallBack(bool flag)
        {
        }
    }
}