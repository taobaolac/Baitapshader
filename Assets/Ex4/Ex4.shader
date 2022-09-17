Shader "Unlit/Ex4"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainTex1 ("Texture", 2D) = "white" {}
        _MainTex2 ("Texture", 2D) = "white" {}  
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
                float2 uv1 : TEXCOORD1;
                float2 uv2: TEXCOORD2;
                float2 uv3: TEXCOORD3;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float2 uv3 : TEXCOORD3;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _MainTex1;
            sampler2D _MainTex2;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float t = _CosTime.x * 0.5 + 0.5;
                float t1 = 1-(_CosTime.x * 0.5 + 0.5);
                v.uv=float2 (t,0);
                v.uv3=float2(t1,0);
                o.uv=v.uv;
                o.uv1 = v.uv1;
                o.uv2=v.uv2;
                o.uv3=v.uv3;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 col1 = tex2D(_MainTex1, i.uv1);
                fixed4 col2 = tex2D(_MainTex2, i.uv2);
                fixed4 col4 = tex2D(_MainTex, i.uv3);
                return col*col1+col2*col4;
            }
            ENDCG
        }
    }
}
