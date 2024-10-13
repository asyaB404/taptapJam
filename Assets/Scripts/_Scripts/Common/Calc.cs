using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Myd.Common
{
    public static class Calc
    {
        /// <summary>
        /// 此方法用于检查两个浮点数 val 和 prevVal 是否跨越了指定的间隔 interval。
        /// 具体来说，它通过将 val 和 prevVal 分别除以 interval 并取整，然后比较两者是否不同。
        /// 如果不同，说明 val 和 prevVal 跨越了一个 interval。
        /// </summary>
        /// <param name="val"></param>
        /// <param name="prevVal"></param>
        /// <param name="interval"></param>
        /// <returns></returns>
        public static bool OnInterval(float val, float prevVal, float interval)
        {
            return (int)(prevVal / interval) != (int)(val / interval);
        }
    }
}
