using System.Collections;
using System.Collections.Generic;
using Core;
using Core.Items;
using Test;
using UI.Panel;
using UnityEngine;

public class CraftGuideMgr : Singleton<CraftGuideMgr>
{
    public Dictionary<ItemStack, List<ItemStack>> MakeTable = new()
    {
        { new ItemStack("laogenSoup"), new() { new ItemStack("laogane") } },
        { new ItemStack("fiddleheadSoup"), new() { new ItemStack("laogane"), new ItemStack("fiddlehead") } },
        { new ItemStack("plumSoup"), new() { new ItemStack("laogane"), new ItemStack("plum") } },
    };

    public Dictionary<List<ItemStack>, ItemStack> GetCraftGuide()
    {
        Dictionary<List<ItemStack>, ItemStack> retDic = new();
        foreach (ItemStack exportation in MakeTable.Keys)
        {
            bool canMake = true;
            foreach (ItemStack materials in MakeTable[exportation])
            {
                if (TestForInventory.Inventory.Count(materials.ItemInfo.id) < materials.count) canMake = false;
            }

            if (canMake)
            {
                retDic.Add(MakeTable[exportation], exportation);
            }
        }

        return retDic;
    }

    public void MakeItem(ItemStack itemStack)
    {
        foreach (ItemStack item in MakeTable[itemStack])
        {
            if (TestForInventory.Inventory.Count(item.ItemInfo.id) < item.count)
            {
                Debug.Log("材料不足");
                return;
            }
        }

        foreach (ItemStack item in MakeTable[itemStack])
        {
            TestForInventory.Inventory.TryRemoveItem(item.ItemInfo.id, item.count, out _);
        }

        TestForInventory.Inventory.AddItem(itemStack.ItemInfo, itemStack.count);
        CreateMenuPanel.Instance.UpdateInventoryDisplay();
    }
}