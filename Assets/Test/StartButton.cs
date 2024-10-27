using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class StartButton : MonoBehaviour, IPointerClickHandler
{
    [SerializeField] private Scene scene;

    public void OnPointerClick(PointerEventData eventData)
    {
        Debug.Log("开始游戏");
        SceneManager.LoadScene(nameof(scene));
    }
}