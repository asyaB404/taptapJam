using System.Collections.Generic;
using System.Linq;
using Core.Container;
using Core.Items;

namespace Core
{
    public class PlayerInventory : IMyContainer
    {
        public int Count(string id)
        {
            int res = 0;
            if (_itemStacksDict.TryGetValue(id, out ItemStack item))
                res = item.count;
            return res;
        }

        private Dictionary<string, ItemStack> _itemStacksDict = new();
        public IReadOnlyCollection<ItemStack> GetItems => _itemStacksDict.Values;
        public int Size { get; private set; }

        public void AddItem(ItemStack newItemStack)
        {
            string id = newItemStack.ItemInfo.id;
            int quantity = newItemStack.count;

            if (_itemStacksDict.TryGetValue(id, out ItemStack existingItemStack))
            {
                existingItemStack.count += quantity;
            }
            else
            {
                _itemStacksDict[id] = newItemStack;
            }

            Size += quantity;
        }

        public bool RemoveItem(string id, int count)
        {
            if (!_itemStacksDict.TryGetValue(id, out ItemStack itemStack)) return false;
            if (itemStack.count < count) return false;
            itemStack.count -= count;
            Size -= count;
            if (itemStack.count == 0)
                _itemStacksDict.Remove(id);
            return true;
        }

        public bool Clear(string id)
        {
            if (!_itemStacksDict.TryGetValue(id, out ItemStack item)) return false;
            Size -= item.count; 
            _itemStacksDict.Remove(id);
            return true;
        }

        public void Clear()
        {
            Size = 0;
            _itemStacksDict.Clear();
        }
    }
}