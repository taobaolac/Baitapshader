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
                float4 newPos=float4(v.vertex.x,v.vertex.y+0.3*cos(_Time.y-v.vertex.x*2),v.vertex.z,1.0);
                o.vertex = UnityObjectToClipPos(newPos);
                o.color=_Color;
                _MainTex_ST.zw+=_Time.y*.02;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                float y=/*1-*/step(0.35,tex2D(_MainTex, i.uv).r)+0.9;
                //fixed4 col =fixed4(_Color.rgb*y,_Color.a);
                fixed4 col =float4(i.color.rgb*y,i.color.a);
                //fixed4 col =fixed4(y,y,y,1);
                return col;
            }
            ENDCG
        }
    }
}
