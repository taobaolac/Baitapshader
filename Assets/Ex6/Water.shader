Shader "Unlit/Water"
{
    Properties
    {
        _MainTex ("Noise", 2D) = "white" {}
        _Color("Color",Color) =(1,1,1,1)
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Transparent"
            "Queue" = "Transparent"
        }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha 
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
                float4 color:COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color=_Color;
                _MainTex_ST.zw+=_Time.y*.02;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                float y=smoothstep(0.1,0.7,tex2D(_MainTex, i.uv).r)+0.2*(_CosTime.w);
                fixed4 col =float4(i.color.rgb*y,i.color.a);
                return col;
            }
            ENDCG
        }
    }
}
