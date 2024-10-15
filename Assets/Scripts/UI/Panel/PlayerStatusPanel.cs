using System.Collections.Generic;
using Core;
using Core.Items;
using DG.Tweening;
using Test;
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
            UpdateInventoryDisplay();
        }
        
        private void InitializeOptionsToggles()
        {
            ToggleGroup toggleGroup = GetControl<ToggleGroup>("ToggleGroup");
            optionsToggles = toggleGroup.GetComponentsInChildren<Toggle>(true);

            for (int i = 0; i < optionsToggles.Length; i++)
            {
                int index = i;
                optionsToggles[index].onValueChanged.AddListener(value => OnToggleChanged(index, value));
            }
        }

        private void OnToggleChanged(int index, bool value)
        {
            if (index < panels.Length)
            {
                panels[index].SetActive(value);
            }
        }

        public override void CallBack(bool flag)
        {
            transform.DOKill(true);

            if (flag)
            {
                ShowPanel();
            }
            else
            {
                HidePanel();
            }
        }

        private void ShowPanel()
        {
            CanvasGroupInstance.interactable = true;
            gameObject.SetActive(true);
            Vector3 startPosition = new Vector3(-Screen.width * 3, transform.localPosition.y, transform.localPosition.z);
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

        public PlayerInventory Inventory => TestForInventory.Inventory;
        [SerializeField] private int selectedSlotId = 0;
        [SerializeField] private ItemInfo selectedItemInfo;
        [SerializeField] private ItemSlot[] itemSlots;
        [SerializeField] private Image selectedItemImage;
        [SerializeField] private TextMeshProUGUI selectedItemName;
        [SerializeField] private TextMeshProUGUI selectedItemDescription;

        private void InitializeItemSlots()
        {
            for (int i = 0; i < itemSlots.Length; i++)
            {
                ItemSlot itemSlot = itemSlots[i];
                itemSlot.id = i;
                itemSlot.UpdateDisplay();
                itemSlot.toggle.onValueChanged.AddListener(value => OnItemSlotToggleChanged(itemSlot, value));
            }
        }

        private void OnItemSlotToggleChanged(ItemSlot itemSlot, bool value)
        {
            if (!value) return;

            selectedSlotId = itemSlot.id;
            var inventory = itemSlot.Inventory;

            if (itemSlot.id < 0 || itemSlot.id >= inventory.Count) return;

            SetSelectedItem(inventory[itemSlot.id].ItemInfo);
        }

        private void SetSelectedItem(ItemInfo info)
        {
            if (info == null)
            {
                selectedItemImage.sprite = null;
                selectedItemName.text = "";
                selectedItemDescription.text = "";
            }
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

            if (Inventory.Count(selectedItemInfo.id) == 0)
            {
                SetSelectedItem();
            }
        }

        #endregion
    }
}
