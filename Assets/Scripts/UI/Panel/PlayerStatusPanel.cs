using System.Collections.Generic;
using Core;
using Core.Items;
using DG.Tweening;
using TMPro;
using UI.Inventory;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Panel
{
    public class PlayerStatusPanel : BasePanel<PlayerStatusPanel>
    {
        #region Main

        [SerializeField] private Toggle[] optionsToggles;
        [SerializeField] private GameObject[] panels;

        public override void Init()
        {
            base.Init();
            InitializeOptionsToggles();
            InitializeItemSlots();
        }

        public override void OnPressedEsc()
        {
            base.OnPressedEsc();
        }

        public override void CallBack(bool flag)
        {
            transform.DOKill(true);
            if (flag)
                ShowPanel();
            else
                HidePanel();
        }

        private void InitializeOptionsToggles()
        {
            ToggleGroup toggleGroup = GetControl<ToggleGroup>("ToggleGroup");
            optionsToggles = toggleGroup.GetComponentsInChildren<Toggle>(true);

            for (int i = 0; i < optionsToggles.Length; i++)
            {
                int index = i;
                optionsToggles[index].onValueChanged.AddListener(value => OnOptionsToggleChanged(index, value));
            }
        }

        private void OnOptionsToggleChanged(int index, bool value)
        {
            if (index < panels.Length)
            {
                panels[index].SetActive(value);
            }
        }

        private void ShowPanel()
        {
            UpdateInventoryDisplay();
            CanvasGroupInstance.interactable = true;
            gameObject.SetActive(true);
            Vector3 startPosition =
                new Vector3(-Screen.width * 3, transform.localPosition.y, transform.localPosition.z);
            transform.localPosition = startPosition;
            transform.DOLocalMoveX(0, UIConst.UIDuration).SetEase(Ease.OutBack);
        }

        private void HidePanel()
        {
            CanvasGroupInstance.interactable = false;
            transform.DOLocalMoveX(-Screen.width * 3, UIConst.UIDuration)
                .OnComplete(() => { gameObject.SetActive(false); });
        }

        #endregion

        #region Inventory

        public PlayerInventory inventory;
        [SerializeField] private int selectedSlotId = 0;
        [SerializeField] private ItemSlot selectedHotSlot;
        [SerializeField] private ItemInfo selectedItemInfo;
        [SerializeField] private ItemSlot[] itemSlots;
        public IReadOnlyList<ItemSlot> ItemSlots => itemSlots;
        [SerializeField] private ItemSlot[] hotSlots;
        [SerializeField] private Image selectedItemImage;
        [SerializeField] private TextMeshProUGUI selectedItemName;
        [SerializeField] private TextMeshProUGUI selectedItemDescription;

        private void InitializeItemSlots()
        {
            for (int i = 0; i < itemSlots.Length; i++)
            {
                ItemSlot itemSlot = itemSlots[i];
                itemSlot.id = i;
                itemSlot.toggle.onValueChanged.AddListener(value => OnItemSlotToggleChanged(itemSlot, value));
            }

            for (int i = 0; i < hotSlots.Length; i++)
            {
                ItemSlot itemSlot = hotSlots[i];
                itemSlot.id = i;
                itemSlot.toggle.onValueChanged.AddListener(value => OnHotSlotToggleChanged(itemSlot, value));
            }
        }

        private void OnItemSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;
            selectedSlotId = itemSlot.id;
            var itemStacks = itemSlot.Inventory;
            SetSelectedItem(null);
            
            if (itemSlot.id < 0 || itemSlot.id >= itemStacks.Count) return;
            ItemInfo nowSelectedItemInfo = itemStacks[itemSlot.id].ItemInfo;
            SetSelectedItem(nowSelectedItemInfo);
            
            //如果处于选择快捷栏状态时点击
            if (!SelectHotItemPanel.Instance.IsInStack || nowSelectedItemInfo.maxCount <= 0) return;
            selectedHotSlot.UpdateDisplay(nowSelectedItemInfo);
            inventory.SetHotItem(selectedHotSlot.id,nowSelectedItemInfo);
        }

        private void OnHotSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;
            selectedHotSlot = itemSlot;
            if (!SelectHotItemPanel.Instance.IsInStack && BonfireMenuPanel.Instance.IsInStack)
                SelectHotItemPanel.Instance.ShowMe();
        }


        private void SetSelectedItem(ItemInfo info)
        {
            if (info == null)
            {
                selectedItemImage.color = Color.clear;
                selectedItemImage.sprite = null;
                selectedItemName.text = "";
                selectedItemDescription.text = "";
                return;
            }

            selectedItemImage.color = Color.white;
            selectedItemInfo = info;
            selectedItemImage.sprite = info.icon;
            selectedItemName.text = info.itemName;
            selectedItemDescription.text = info.description;
        }

        public void UpdateInventoryDisplay()
        {
            foreach (var slot in itemSlots)
            {
                slot.UpdateDisplay();
            }

            if (!selectedItemInfo || inventory.Count(selectedItemInfo.id) == 0)
            {
                SetSelectedItem(null);
            }
        }

        #endregion
    }
}