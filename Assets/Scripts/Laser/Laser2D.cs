using System.Collections.Generic;
using System.Reflection;
using DG.Tweening;
using UnityEngine;


namespace Laser
{
    [RequireComponent(typeof(LineRenderer))]
    public class Laser2D : MonoBehaviour
    {

        [Tooltip("光照半径")]
        public float lightRadius = .5f;
        [Tooltip("圆形顶点数，用于定义光照形状")]
        public int circleVertices = 10;
        [Tooltip("激光起点的粒子效果")]
        public GameObject startParticles;
        [Tooltip("激光终点的粒子效果")]
        public GameObject endParticles;
        // 用于绘制激光线
        LineRenderer line;
        // 用于控制激光的光照效果。
        UnityEngine.Rendering.Universal.Light2D lit;
        
        private ParticleSystem[] starts;
        private ParticleSystem[] ends;
        
        private Dictionary<Collider2D, SpriteRenderer> hitDarkObjects = new Dictionary<Collider2D, SpriteRenderer>();

        void Awake()
        {
            line = GetComponent<LineRenderer>();
            lit = GetComponent<UnityEngine.Rendering.Universal.Light2D>();
            starts = startParticles.GetComponentsInChildren<ParticleSystem>();
            ends = endParticles.GetComponentsInChildren<ParticleSystem>();
            SetEnable(false);
        }

        public void SetEnable(bool b)
        {
            line.enabled = b;
            lit.enabled = b;
            foreach (var item in starts)
            {
                if (b)
                    item.Play();
                else
                    item.Stop();
            }
            foreach (var item in ends)
            {
                if (b)
                    item.Play();
                else
                    item.Stop();
            }
        }

        public void SetPositions(Vector3 start, Vector3 direction)
        {
            // 设置激光
            BetterCastLaser(start, direction);
        }
        
        // 射程
        private float _range= 20f;
        private void BetterCastLaser(Vector2 startPos, Vector2 direction)
        {
            List<Vector3> points = new List<Vector3>();
            points.Add(startPos);
            int remainReflect = 3; // 剩余的反射次数
            float remainRange = _range; // 剩余的射程
            RaycastHit2D hit2D;
            Vector2 shootPos = startPos; // 当前射击点
            while (remainReflect >= 0 && remainRange > 0)
            {
                hit2D = Physics2D.Raycast(shootPos, direction, remainRange, LayerMask.GetMask("Ground", "DarkObject"));
                if (hit2D.collider != null)
                {
                    direction = Vector2.Reflect(direction, hit2D.normal);
                    remainRange -= (hit2D.point - startPos).magnitude; // magnitude向量的模长
                    startPos = hit2D.point;
                    points.Add(shootPos);
                    
                    // TODO:检测是否碰撞到特殊物体
                    if (hit2D.collider.CompareTag("DarkObject"))
                    {
                        var spriteRenderer = hit2D.collider.transform.GetComponent<SpriteRenderer>();
                        spriteRenderer.DOFade(1, .5f).OnComplete(() =>
                        {
                            spriteRenderer.DOFade(0, 1);
                        });
                        if (!hitDarkObjects.ContainsKey(hit2D.collider))
                        {
                            hitDarkObjects.Add(hit2D.collider, spriteRenderer);
                        }
                    }
                }
                else
                {
                    Vector2 p = startPos + direction * remainRange;
                    points.Add(p);
                    break;
                }
                
                remainReflect--;
                shootPos = startPos + direction * 0.01f; // 偏移一点
            }

            
            // 生成激光
            UpdateLaserPosition(points);
        }


        private void UpdateLaserPosition(List<Vector3> points)
        {
            transform.SetPositionAndRotation(new Vector3(0,0,0), Quaternion.Euler(0,0,0));
            
            // 计算激光初始方向
            Vector2 direction = (points[1] - points[0]).normalized;
            float retationZ = Mathf.Atan2(direction.y, direction.x);
            startParticles.transform.SetPositionAndRotation(points[0], Quaternion.Euler(0, 0, retationZ * Mathf.Rad2Deg));
            
            direction = (points[^2] - points[^1]).normalized; // 计算倒数第二个点和倒数第一个点
            retationZ = Mathf.Atan2(direction.y, direction.x);
            endParticles.transform.SetPositionAndRotation(points[^1], Quaternion.Euler(0, 0, retationZ * Mathf.Rad2Deg));
            
            line.positionCount = points.Count;
            line.SetPositions(points.ToArray());
        }
        
        private float _reflectRange = 10f;
        public void BetterCastLaserWithoutReflect(Vector2 startPos, Vector2 direction)
        {
            List<Vector3> points = new List<Vector3>();
            points.Add(startPos);
            int remainReflect = 0; // 剩余的反射次数
            float remainRange = _reflectRange; // 剩余的射程
            RaycastHit2D hit2D;
            Vector2 shootPos = startPos; // 当前射击点
            while (remainReflect >= 0 && remainRange > 0)
            {
                hit2D = Physics2D.Raycast(shootPos, direction, remainRange, LayerMask.GetMask("Ground", "DarkObject"));
                if (hit2D.collider != null)
                {
                   // direction = Vector2.Reflect(direction, hit2D.normal);
                   // remainRange -= (hit2D.point - startPos).magnitude; // magnitude向量的模长
                   // startPos = hit2D.point;
                    points.Add(hit2D.point);
                    // TODO:检测是否碰撞到特殊物体
                    if (hit2D.collider.CompareTag("DarkObject"))
                    {
                        var spriteRenderer = hit2D.collider.transform.GetComponent<SpriteRenderer>();
                        spriteRenderer.DOFade(1, .5f).OnComplete(() =>
                        {
                            spriteRenderer.DOFade(0, 1);
                        });
                        if (!hitDarkObjects.ContainsKey(hit2D.collider))
                        {
                            hitDarkObjects.Add(hit2D.collider, spriteRenderer);
                        }
                    }
                }
                else
                {
                    Vector2 p = startPos + direction * remainRange;
                    points.Add(p);
                    break;
                }
                
                remainReflect--;
                shootPos = startPos + direction * 0.01f; // 偏移一点
            }

            
            // 生成激光
            UpdateLaserPosition(points);
        }
    }
}

