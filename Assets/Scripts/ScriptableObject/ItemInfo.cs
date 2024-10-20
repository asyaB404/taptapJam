using UnityEngine;
using System.Data;

namespace Test {
	[CreateAssetMenu(fileName = "ItemInfo", menuName = "ScriptableObject/ItemInfo")]
	public class ItemInfo : ExcelableScriptableObject
	{
		public string id;
		public string itemName;
		public string description;

		public override void Init(DataRow row)
		{
			id = row[0].ToString();
			itemName = row[1].ToString();
			description = row[2].ToString();
		}
	}
}
