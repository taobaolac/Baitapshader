using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ex1 : MonoBehaviour
{
    public MeshFilter meshFilter;
    public Material mat;
    public Color color;
    // Start is called before the first frame update
    void Start()
    {
        mat = GetComponent<Renderer>().material;
        Mesh mesh = new Mesh();
        mesh.vertices = new Vector3[]
        {
            new Vector3(0,0,0),
            new Vector3(0,0,1),
            new Vector3(1,0,1),
            new Vector3(1,0,0),
        };
        mesh.triangles = new int[]
        {
            0,1,2,
            0,2,3
        };
        mesh.normals = new Vector3[]
        {
            Vector3.up,
            Vector3.up,
            Vector3.up,
            Vector3.up,
        };
        mesh.SetUVs(0, new Vector2[]
        {
            new Vector2(0,0),
            new Vector2(1,0),
            new Vector2(1,1),
            new Vector2(0,1)
        });
        //mesh.SetUVs(1, new Vector2[]
        //{
        //    new Vector2(0,0),
        //    new Vector2(1,0),
        //    new Vector2(1,1),
        //    new Vector2(0,1)
        //});
        //mesh.SetUVs(2, new Vector2[]
        //{
        //    new Vector2(0,0),
        //    new Vector2(1,0),
        //    new Vector2(1,1),
        //    new Vector2(0,1)
        //});
        mesh.colors=new Color[]
        {
            color,
            color,
            color,
            color
        };
        meshFilter.mesh = mesh;

    }

    // Update is called once per frame
    void Update()
    {
        var x = Mathf.Cos(Time.time);
        var y = Mathf.Sin(Time.time);
        mat.SetVector("Rotate", new Vector4(x, y,0,0));
    }
}
