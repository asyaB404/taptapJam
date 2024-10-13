using Core.Items;

namespace Core.Container
{
    public interface IMyContainer
    {
        public int Count(ItemInfo itemInfo);
        public ItemStack[] GetItems { get; }
        public int Size { get; }
    }
}