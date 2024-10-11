
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Luban;
using SimpleJSON;


namespace cfg
{
public sealed partial class AssetPath : Luban.BeanBase
{
    public AssetPath(JSONNode _buf) 
    {
        { if(!_buf["EnumName"].IsNumber) { throw new SerializationException(); }  EnumName = (EnumAudioClip)_buf["EnumName"].AsInt; }
        { if(!_buf["Volume"].IsNumber) { throw new SerializationException(); }  Volume = _buf["Volume"]; }
        { if(!_buf["CD"].IsNumber) { throw new SerializationException(); }  CD = _buf["CD"]; }
        { if(!_buf["Path"].IsString) { throw new SerializationException(); }  Path = _buf["Path"]; }
    }

    public static AssetPath DeserializeAssetPath(JSONNode _buf)
    {
        return new AssetPath(_buf);
    }

    /// <summary>
    /// 枚举名
    /// </summary>
    public readonly EnumAudioClip EnumName;
    /// <summary>
    /// 音量大小
    /// </summary>
    public readonly float Volume;
    /// <summary>
    /// 作为高频音效的CD
    /// </summary>
    public readonly float CD;
    public readonly string Path;
   
    public const int __ID__ = -975836395;
    public override int GetTypeId() => __ID__;

    public  void ResolveRef(Tables tables)
    {
        
        
        
        
    }

    public override string ToString()
    {
        return "{ "
        + "EnumName:" + EnumName + ","
        + "Volume:" + Volume + ","
        + "CD:" + CD + ","
        + "Path:" + Path + ","
        + "}";
    }
}

}
