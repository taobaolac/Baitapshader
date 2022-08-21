using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawCircle : MonoBehaviour
{
    public int step;
    public MeshFilter meshFilter;
    List<Vector3> vertex=new List<Vector3>();
    List<int> tris=new List<int>();
    List<Vector3> normals=new List<Vector3>();
    // Start is called before the first frame update
    void Start()
    {
        Draw();
    }
    public void Draw()
    {
        for (int i = 0; i < step; i++)
        {
            var angle = i *2* Mathf.PI / step;
            var z = Mathf.Sin(angle);
            var x = Mathf.Cos(angle);
            var vert = new Vector3(x, 0, z);
            vertex.Add(vert);
        }
        for (int i = 0; i < vertex.Count-2; i++)
        {
            var index0 = 0;
            var index1 = i + 1;
            var index2 = i + 2;
            tris.Add(index0);
            tris.Add(index2);
            tris.Add(index1);
        }
        var mesh = new Mesh();
        mesh.vertices = vertex.ToArray();
        mesh.triangles = tris.ToArray();
        foreach (var item in vertex)
        {
            normals.Add(Vector3.up);
        }
        mesh.normals = normals.ToArray();
        mesh.RecalculateBounds();
        meshFilter.mesh = mesh;
    }
}
