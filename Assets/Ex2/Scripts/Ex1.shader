
Shader "Unlit/Ex1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainTex1 ("Texture", 2D) = "white" {}
        _MainTex2 ("Texture", 2D) = "white" {}
        Rotate("Rotate", Vector) = (0,0,0,0)
        _Color("Color",Color)=(1,0,0,1)
        _Color1("Color1",Color)=(1,0,0,1)
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
                float2 uv2: TEXCOORD1;
                float2 uv3: TEXCOORD2;
                float4 color: COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float2 uv2: TEXCOORD1;
                float2 uv3: TEXCOORD2;
                float4 color: COLOR;
            };
            float4 _Color;
            float4 _Color1;
            sampler2D _MainTex;
            sampler2D _MainTex1;
            sampler2D _MainTex2;
            float4 _MainTex_ST;
            float4 _MainTex1_ST;
            Vector Rotate;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float2 pivot = float2(0.5, 0.5);
                float2x2 mrot=float2x2(Rotate.x,-Rotate.y,Rotate.y,Rotate.x);
                float2x2 mrot2 = float2x2(Rotate.y, -Rotate.x, Rotate.x, Rotate.y);
                float2 uv = v.uv.xy - pivot;
                o.uv = mul(mrot, uv);
                o.uv+= pivot;
                float2 uv2=(v.uv2.xy-pivot)*_MainTex1_ST.xy;
                o.uv2=mul(mrot2,uv2);
                o.uv2+=pivot;
                o.color=v.color;
                o.uv3=v.uv3;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv)*_Color;
                fixed4 col1=tex2D(_MainTex1,i.uv2)*_Color1/**i.color*/;
                fixed4 col2=tex2D(_MainTex2,i.uv3);
                //fixed4 col4=i.color;
                return (col+col1+col2/*+col4*/);
            }
            ENDCG
        }
    }
}
