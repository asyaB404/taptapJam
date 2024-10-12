using System;
using System.Collections;
using System.Collections.Generic;
using cfg;
using SimpleJSON;
using UnityEngine;
using UnityEngine.AddressableAssets;

public class DataMgr : Singleton<DataMgr>
{
    public Tables Table = new Tables(Loader);
    
    
    private static JSONNode Loader(string fileName)
    {
        return JSONNode.Parse(Resources.Load<TextAsset>($"Data/{fileName}").text);
    }
}
