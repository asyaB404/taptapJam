// // ********************************************************************************************
// //     /\_/\                           @file       HotItemMgr.cs
// //    ( o.o )                          @brief     taptap
// //     > ^ <                           @author     Basya
// //    /     \
// //   (       )                         @Modified   2024102618
// //   (___)___)                         @Copyright  Copyright (c) 2024, Basya
// // ********************************************************************************************

using System;
using Test;
using UnityEngine;

namespace Manager
{
    public class HotItemMgr : MonoBehaviour
    {
        private KeyCode _keyCode1 = KeyCode.Alpha1;
        private KeyCode _keyCode2 = KeyCode.Alpha2;
        private KeyCode _keyCode3 = KeyCode.Alpha3;

        private void Update()
        {
            if (Input.GetKeyDown(_keyCode1))
            {
                TestForInventory.Inventory.UseHotItem(0);
            }
            else if (Input.GetKeyDown(_keyCode2))
            {
                TestForInventory.Inventory.UseHotItem(1);
            }
            else if (Input.GetKeyDown(_keyCode3))
            {
                TestForInventory.Inventory.UseHotItem(2);
            }
        }
    }
}