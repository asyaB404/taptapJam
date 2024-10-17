using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileMover : MonoBehaviour
{
    public float speed = 15f;
    public float hitOffset = 0.1f;
    public bool UseFirePointRotation;
    public Vector3 rotationOffset = new Vector3(0, 0, 0);
    public GameObject hit;
    public GameObject flash;
    private Rigidbody2D rb;
    public GameObject[] Detached;
    private Vector2 direction;

    void Start()
    {
        transform.localScale = new Vector3(0.5f, 0.5f, 0.5f);
        
        rb = GetComponent<Rigidbody2D>();
        direction = ((Vector2)(Camera.main.ScreenToWorldPoint(Input.mousePosition) - transform.position)).normalized;
        var normalDirection = direction.normalized;
        Vector3 offsetPosition = (Vector2)transform.position + normalDirection * 1.5f; // 这里的 0.1f 是偏移量，可以根据需要调整
        if (flash != null)
        {
            // 生成的位置应当朝鼠标的方向移动一点
            var flashInstance = Instantiate(flash, offsetPosition , Quaternion.identity);
            flashInstance.transform.forward = gameObject.transform.forward;
            var flashPs = flashInstance.GetComponent<ParticleSystem>();
            if (flashPs != null)
            {
                Destroy(flashInstance, flashPs.main.duration);
            }
            else
            {
                var flashPsParts = flashInstance.transform.GetChild(0).GetComponent<ParticleSystem>();
                Destroy(flashInstance, flashPsParts.main.duration);
            }
        }
        Destroy(gameObject,5);
	}

    void FixedUpdate ()
    {
		if (speed != 0)
        {  
            // 一定要用Vector2，否则鼠标靠近角色的时候子弹很慢
            rb.velocity = direction * speed;
            //transform.position += transform.forward * (speed * Time.deltaTime);         
        }
	}

    //https ://docs.unity3d.com/ScriptReference/Rigidbody.OnCollisionEnter.html


    private void OnCollisionEnter2D(Collision2D other)
    {
        rb.constraints = RigidbodyConstraints2D.FreezeAll;
        speed = 0;

        ContactPoint2D contact = other.contacts[0];
        Quaternion rot = Quaternion.FromToRotation(Vector3.up, contact.normal);
        Vector3 pos = contact.point + contact.normal * hitOffset;

        if (hit != null)
        {
            var hitInstance = Instantiate(hit, pos, rot);
            if (UseFirePointRotation) { hitInstance.transform.rotation = gameObject.transform.rotation * Quaternion.Euler(0, 180f, 0); }
            else if (rotationOffset != Vector3.zero) { hitInstance.transform.rotation = Quaternion.Euler(rotationOffset); }
            else { hitInstance.transform.LookAt(contact.point + contact.normal); }

            var hitPs = hitInstance.GetComponent<ParticleSystem>();
            if (hitPs != null)
            {
                Destroy(hitInstance, hitPs.main.duration);
            }
            else
            {
                var hitPsParts = hitInstance.transform.GetChild(0).GetComponent<ParticleSystem>();
                Destroy(hitInstance, hitPsParts.main.duration);
            }
        }
        foreach (var detachedPrefab in Detached)
        {
            if (detachedPrefab != null)
            {
                detachedPrefab.transform.parent = null;
            }
        }
        Destroy(gameObject);
    }
}
