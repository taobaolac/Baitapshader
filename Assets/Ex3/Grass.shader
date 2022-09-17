Shader "Unlit/Grass"
{
    Properties
    {

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color: COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                float t = _CosTime.w * 0.5 + 0.5;
                //float x= v.vertex.x*t+v.uv.x*(1-t);
                //t = _SinTime.w * 0.5 + 0.5;
                //float z= v.vertex.z*t+v.uv.y*(1-t);
                float2 xz= float2(v.vertex.x*t+v.uv.x*(1-t),v.vertex.z*t+v.uv.y*(1-t));
                float4 newPos=float4(xz.x,v.vertex.y,xz.y,1.0);
                o.vertex = UnityObjectToClipPos(newPos);
                o.color=v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = i.color;
                return col;
            }
            ENDCG
        }
    }
}
