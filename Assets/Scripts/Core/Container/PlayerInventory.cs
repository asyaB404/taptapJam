using Core.Container;
using Core.Items;

namespace Core
{
    public class PlayerInventory : IMyContainer
    {
        public int Count(ItemInfo itemInfo)
        {
            throw new System.NotImplementedException();
        }

        public ItemStack[] GetItems => null;
        public int Size { get; private set; }
    }
}