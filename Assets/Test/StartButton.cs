using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class StartButton : MonoBehaviour, IPointerClickHandler
{

    public void OnPointerClick(PointerEventData eventData)
    {
        Debug.Log("开始游戏");
        ScenesMgr.Instance.ChangeScenes(0,ES3.KeyExists("Level")?ES3.Load<int>("Level"):2);
    }
}