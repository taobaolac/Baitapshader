
Shader "Unlit/Ex1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Rotate("Rotate", Vector) = (1, 0, 0, 1)
        _Angle("Angle", Range(-5.0,  5.0)) = 0.0
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
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _Rotate;
            float4 _MainTex_ST;
            float _Angle;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float2 pivot = float2(0.5, 0.5);
                float cosAngle = cos(_Angle);
                float sinAngle = sin(_Angle);
                float2x2 rot = float2x2(cosAngle, -sinAngle, sinAngle, cosAngle);
                float2 uv = v.uv.xy - pivot;
                o.uv = mul(rot, uv);
                o.uv+= pivot;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
