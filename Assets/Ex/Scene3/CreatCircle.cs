using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
public class CreatCircle : MonoBehaviour
{
    [Range(3,100)]
    public int step;
    public float r1, r2;
    public MeshFilter meshFilter;
    public List<Vector3> listVrtUpside;
    public List<Vector3> listVrtDownside;
    public List<Vector3> listVrtAllSide;
    public List<int> listTriangles;
    public List<Vector3> listNormal;
    public Vector3 center=Vector3.zero;
    public Vector3 centerA=Vector3.zero;
    int currentStep;
    [Range(0,100)]
    public int render;
    public int currentrender;
    public GameObject cube;
    public GameObject endGame;
    // Start is called before the first frame update
    void Start()
    {
       // CreatMesh();
    }
    public void CreatMesh()
    {
        listVrtUpside.Clear();
        listVrtDownside.Clear();
        listVrtAllSide.Clear();
        listTriangles.Clear();
        listNormal.Clear();
        var mesh = new Mesh();
        #region Draw Underside
        for (int i = 0; i < step; i++)
        {
            var angle = i * (2 * Mathf.PI / step);
            float x = r1 * Mathf.Sin(angle);
            float y = r1 * Mathf.Cos(angle);
            var v3 = new Vector3(center.x + x, center.y, center.z + y);
            if (i <= render)
                listVrtUpside.Add(v3);
        }
        for (int i = 0; i < step; i++)
        {
            var angle = i * (2 * Mathf.PI / step);
            float x = r2 * Mathf.Sin(angle);
            float y = r2 * Mathf.Cos(angle);
            var v3 = new Vector3(center.x + x, center.y, center.z + y);
            if (i <= render)
                listVrtUpside.Add(v3);
        }
        for (int i = 0; i < listVrtUpside.Count / 2-1; i++)
        {
            int index0 = i;
            int index1 = i + listVrtUpside.Count / 2;
            int index2 = (i + 1) % (listVrtUpside.Count / 2);
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
            //Debug.Log(index0 + "  " + index1 + " " + index2);
        }

        for (int i = 1; i < listVrtUpside.Count / 2; i++)
        {
            int index0 = i;
            int index1 = (listVrtUpside.Count / 2) + ((listVrtUpside.Count / 2) + i - 1) % (listVrtUpside.Count / 2);
            int index2 = i + (listVrtUpside.Count / 2);
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
            //Debug.Log(index0 + "  " + index1 + " " + index2);
        }
        #endregion
        #region Draw Upperside
        for (int i = 0; i < step; i++)
        {
            var angle = i * (2 * Mathf.PI / step);
            float x = r1 * Mathf.Sin(angle);
            float y = r1 * Mathf.Cos(angle);
            var v3 = new Vector3(centerA.x + x, centerA.y, centerA.z + y);
            if (i <= render)
                listVrtDownside.Add(v3);
        }
        for (int i = 0; i < step; i++)
        {
            var angle = i * (2 * Mathf.PI / step);
            float x = r2 * Mathf.Sin(angle);
            float y = r2 * Mathf.Cos(angle);
            var v3 = new Vector3(centerA.x + x, centerA.y, centerA.z + y);
            if (i <= render)
                listVrtDownside.Add(v3);
        }
        for (int i = 0; i < listVrtDownside.Count / 2-1; i++)
        {
            int index0 = i + listVrtUpside.Count;
            int index2 = i + listVrtUpside.Count + listVrtDownside.Count / 2;
            int index1 = (i + 1) % (listVrtDownside.Count / 2) + listVrtUpside.Count;
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
            //Debug.Log(index0 + "  " + index1 + " " + index2);
        }
        for (int i = 1; i < listVrtDownside.Count / 2; i++)
        {
            int index0 = i + listVrtUpside.Count;
            int index1 = (listVrtDownside.Count / 2) + ((listVrtDownside.Count / 2) + i - 1) % (listVrtDownside.Count / 2) + listVrtUpside.Count;
            int index2 = i + (listVrtDownside.Count / 2) + listVrtUpside.Count;
            listTriangles.Add(index0);
            listTriangles.Add(index2);
            listTriangles.Add(index1);
            //Debug.Log(index0 + "  " + index1 + " " + index2);
        }
        #endregion
        listVrtAllSide.AddRange(listVrtUpside);
        listVrtAllSide.AddRange(listVrtDownside);
        #region Draw SideFace
        for (int i = 0; i < listVrtUpside.Count / 2 - 1; i++)
        {
            int index0 = i;
            int index2 = i + listVrtUpside.Count;
            int index1 = i + 1;
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
        }
        for (int i = 0; i < listVrtDownside.Count / 2 - 1; i++)
        {
            int index0 = i + listVrtUpside.Count;
            int index1 = i + 1;
            int index2 = i + 1 + listVrtUpside.Count;
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
        }
        for (int i = listVrtUpside.Count / 2; i < listVrtUpside.Count - 1; i++)
        {
            int index0 = i;
            int index1 = i + listVrtUpside.Count;
            int index2 = i + 1;
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
        }
        for (int i = listVrtDownside.Count / 2; i < listVrtDownside.Count - 1; i++)
        {
            int index0 = i + listVrtUpside.Count;
            int index2 = i + 1;
            int index1 = i + 1 + listVrtUpside.Count;
            listTriangles.Add(index0);
            listTriangles.Add(index1);
            listTriangles.Add(index2);
        }
        #endregion
        #region Draw Complete
        if (render >= step)
        {
            listTriangles.Add(listVrtUpside.Count / 2 - 1);
            listTriangles.Add(listVrtDownside.Count);
            listTriangles.Add(listVrtDownside.Count / 2 - 1 + listVrtUpside.Count);

            listTriangles.Add(listVrtUpside.Count / 2 - 1);
            listTriangles.Add(0);
            listTriangles.Add(listVrtDownside.Count);

            listTriangles.Add(listVrtUpside.Count - 1);
            listTriangles.Add(listVrtAllSide.Count - 1);
            listTriangles.Add(listVrtDownside.Count / 2);


            listTriangles.Add(listVrtAllSide.Count - 1);
            listTriangles.Add(listVrtDownside.Count / 2 + listVrtUpside.Count);
            listTriangles.Add(listVrtDownside.Count / 2);

            int index0 = listVrtUpside.Count;
            int index1 = (listVrtDownside.Count / 2) + ((listVrtDownside.Count / 2)  - 1) % (listVrtDownside.Count / 2) + listVrtUpside.Count;
            int index2 =  (listVrtDownside.Count / 2) + listVrtUpside.Count;
            listTriangles.Add(index0);
            listTriangles.Add(index2);
            listTriangles.Add(index1);

            int index3 = listVrtDownside.Count / 2 - 1 + listVrtUpside.Count;
            int index5 = listVrtDownside.Count / 2 - 1 + listVrtUpside.Count + listVrtDownside.Count / 2;
            int index4 = (listVrtDownside.Count / 2 - 1 + 1) % (listVrtDownside.Count / 2) + listVrtUpside.Count;
            listTriangles.Add(index3);
            listTriangles.Add(index4);
            listTriangles.Add(index5);

            int index6 = listVrtUpside.Count / 2 - 1;
            int index7 = listVrtUpside.Count / 2 - 1 + listVrtUpside.Count / 2;
            int index8 = (listVrtUpside.Count / 2 - 1 + 1) % (listVrtUpside.Count / 2);
            listTriangles.Add(index6);
            listTriangles.Add(index7);
            listTriangles.Add(index8);

            int index9 = 0;
            int index10 = (listVrtUpside.Count / 2) + ((listVrtUpside.Count / 2) + 0 - 1) % (listVrtUpside.Count / 2);
            int index11 = 0 + (listVrtUpside.Count / 2);
            listTriangles.Add(index9);
            listTriangles.Add(index10);
            listTriangles.Add(index11);
        }
        else
        {
            listTriangles.Add(0);
            listTriangles.Add(listVrtUpside.Count);
            listTriangles.Add(listVrtUpside.Count + listVrtDownside.Count / 2);

            listTriangles.Add(0);
            listTriangles.Add(listVrtUpside.Count + listVrtDownside.Count / 2);
            listTriangles.Add(listVrtUpside.Count / 2);

            listTriangles.Add(listVrtUpside.Count - 1);
            listTriangles.Add(listVrtAllSide.Count - 1);
            listTriangles.Add(listVrtUpside.Count + listVrtDownside.Count / 2 - 1);

            listTriangles.Add(listVrtUpside.Count - 1);
            listTriangles.Add(listVrtUpside.Count + listVrtDownside.Count / 2 - 1);
            listTriangles.Add(listVrtUpside.Count / 2 - 1);

        }
        #endregion
        //for (int i = 0; i < listV3All.Count; i++)
        //{
        //    var go = Instantiate(cube);
        //    go.transform.position = new Vector3(listV3All[i].x, listV3All[i].y, listV3All[i].z);
        //}
        //foreach (var item in listV3All)
        //{
        //    listNormal.Add(Vector3.up);
        //}
        mesh.vertices = listVrtAllSide.ToArray();
        mesh.triangles = listTriangles.ToArray();
        mesh.normals = listNormal.ToArray();
        mesh.RecalculateNormals();
        mesh.RecalculateBounds();
        meshFilter.mesh = mesh;
        currentStep = step;
        currentrender = render;
    }
    const float delayTime=.1f;
    float time = delayTime;
    private void Update()
    {
        if (render >= step)
        {
            End();
            return;
        }
        if (Input.GetMouseButton(0))
        {
            time -= Time.deltaTime;
            if (time <= 0)
            {
                render++;
                time = delayTime;
            }
        }
        if (currentStep == step&&render==currentrender)
            return;
        CreatMesh();
    }
    public void End()
    {
        endGame.SetActive(true);
    }
}
