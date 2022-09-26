Shader "Unlit/Outline"
{
    Properties
    {
        _Color("Color",Color)=(1,1,1,1)
        _OutlineValue("OutLineValue",range(0,1))=0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        Cull Front
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
                float4 color: COLOR;
            };

            float4 _Color;
            float _OutlineValue;
            v2f vert (appdata v)
            {
                v2f o;
                float4x4 scale = float4x4(1 + _OutlineValue, 0, 0, 0,
                    0, 1 + _OutlineValue, 0, 0,
                    0, 0, 1 + _OutlineValue, 0,
                    0, 0, 0, 1 + _OutlineValue
                );
                float4 v2=mul(v.vertex,scale);
                o.vertex = UnityObjectToClipPos(v2);
                o.color=_Color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}
