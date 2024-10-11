using System.Collections;
using System.Collections.Generic;
using cfg;
using SimpleJSON;
using UnityEngine;
using UnityEngine.AddressableAssets;

public class DataMgr : Singleton<DataMgr>
{
    public Tables Tables { get; } = new (Loader);


    private static JSONNode Loader(string fileName)
    {
        var textAsset = AssetMgr.LoadAssetAsync<TextAsset>("Assets/AddressableAssets/ConfigData/" + fileName + ".json").Result;
        return JSONNode.Parse(textAsset.text);
    }
}
