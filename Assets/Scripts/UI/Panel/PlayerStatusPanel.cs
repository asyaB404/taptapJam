using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Panel
{
    public class PlayerStatusPanel : BasePanel<PlayerStatusPanel>
    {
        [SerializeField] private Toggle[] toggles;
        [SerializeField] private GameObject[] panels;


        public override void Init()
        {
            base.Init();
            ToggleGroup toggleGroup = GetControl<ToggleGroup>("ToggleGroup");
            toggles = toggleGroup.GetComponentsInChildren<Toggle>(true);
            for (int i = 0; i < toggles.Length; i++)
            {
                int index = i;
                toggles[index].onValueChanged.AddListener((value) => OnToggleChanged(index, value));
            }
        }

        public override void CallBack(bool flag)
        {
            transform.DOKill(true);

            if (flag)
            {
                CanvasGroupInstance.interactable = true;
                gameObject.SetActive(true);
                Vector3 startPosition =
                    new Vector3(-Screen.width, transform.localPosition.y, transform.localPosition.z);
                transform.localPosition = startPosition;
                transform.DOLocalMoveX(0, UIConst.UIDuration).SetEase(Ease.OutBack);
            }
            else
            {
                CanvasGroupInstance.interactable = false;
                transform.localPosition = new(0, transform.localPosition.y, transform.localPosition.z);
                transform.DOLocalMoveX(-Screen.width, UIConst.UIDuration)
                    .OnComplete(() => { gameObject.SetActive(false); });
            }
        }


        private void OnToggleChanged(int index, bool value)
        {
            panels[index].SetActive(value);
        }
    }
}