using System.Collections;
using System.Collections.Generic;
using Core;
using Core.Items;
using Test;
using UnityEngine;

public class CraftGuideMgr : Singleton<CraftGuideMgr>
{
    Dictionary<ItemStack,List<ItemStack>> MakeTable=new(){
        {new ItemStack("laogenSoup"),new(){new ItemStack("laogane")}},
        {new ItemStack("fiddleheadSoup"),new(){new ItemStack("laogane"),new ItemStack("fiddlehead")}},
        {new ItemStack("plumSoup"),new(){new ItemStack("laogane"),new ItemStack("plum")}},
        
    };
    public Dictionary<List<ItemStack>,ItemStack> GetCraftGuide(){
        Dictionary<List<ItemStack>,ItemStack> retDic=new();
        List<ItemStack> itemStacks=new(TestForInventory.Inventory.GetItems);
        foreach(ItemStack exportation in MakeTable.Keys){
            bool canMake=true;
            foreach(ItemStack materials in MakeTable[exportation]){
                if(TestForInventory.Inventory.Count(materials.ItemInfo.id)<materials.count)canMake=false;
            }
            if (canMake){
                retDic.Add(MakeTable[exportation],exportation);
            }
        }
        return retDic;
    }
}
