using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Panel
{
    public class PlayerStatusPanel : BasePanel<PlayerStatusPanel>
    {
        [SerializeField] private Toggle[] optionsToggles;
        [SerializeField] private GameObject[] panels;
        [SerializeField] private List<Toggle> itemSlotsToggles;


        public override void Init()
        {
            base.Init();
            ToggleGroup toggleGroup = GetControl<ToggleGroup>("ToggleGroup");
            optionsToggles = toggleGroup.GetComponentsInChildren<Toggle>(true);
            for (int i = 0; i < optionsToggles.Length; i++)
            {
                int index = i;
                optionsToggles[index].onValueChanged.AddListener((value) => OnToggleChanged(index, value));
            }
            for (int i = 0; i < itemSlotsToggles.Count; i++)
            {
                int index = i;
                itemSlotsToggles[index].onValueChanged.AddListener((value) => OnItemSlotToggleChanged(index, value));
            }
        }
        
        private void OnItemSlotToggleChanged(int index, bool value)
        {
            
        }

        private  void OnToggleChanged(int index, bool value)
        {
            panels[index].SetActive(value);
        }

        public override void CallBack(bool flag)
        {
            transform.DOKill(true);

            if (flag)
            {
                CanvasGroupInstance.interactable = true;
                gameObject.SetActive(true);
                Vector3 startPosition =
                    new Vector3(-Screen.width*3, transform.localPosition.y, transform.localPosition.z);
                transform.localPosition = startPosition;
                transform.DOLocalMoveX(0, UIConst.UIDuration).SetEase(Ease.OutBack);
            }
            else
            {
                CanvasGroupInstance.interactable = false;
                transform.localPosition = new(0, transform.localPosition.y, transform.localPosition.z);
                transform.DOLocalMoveX(-Screen.width*3, UIConst.UIDuration)
                    .OnComplete(() => { gameObject.SetActive(false); });
            }
        }
    }
}