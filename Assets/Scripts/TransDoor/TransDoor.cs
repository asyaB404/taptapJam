using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class TransDoor : MonoBehaviour
{
    // 加载下一个场景
    public int nextLevelNub;
    private void OnTriggerEnter2D(Collider2D other)
    {
        Debug.Log("Triggered");
        if (other.CompareTag("Player"))
        {
            ScenesMgr.Instance.ChangeScenes(SceneManager.GetActiveScene().buildIndex,nextLevelNub);
        }
    }
}
