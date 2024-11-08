using System.Collections.Generic;
using Core.Items;

namespace Core.Container
{
    public interface IMyContainer
    {
        public IReadOnlyCollection<ItemStack> GetItems { get; }
        public IReadOnlyList<ItemStack> GetItemsOrderByTime { get; }
        public int Size { get; }
        public int Count(string id);
    }
}