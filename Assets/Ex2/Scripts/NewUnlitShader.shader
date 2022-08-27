

Shader "Custom/UV rotation"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Angle ("Angle", Range(-5.0,  5.0)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
       
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
 
            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
 
            float _Angle;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainTex_TexelSize;
            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
 
                // Pivot
                float2 pivot = float2(0.5, 0.5);
                float4 newtit=float4(.5,2,0,0);
                // Rotation Matrix
                float cosAngle = cos(_Angle);
                float sinAngle = sin(_Angle);
                float2x2 rot = float2x2(cosAngle, -sinAngle, sinAngle, cosAngle);
 
                // Rotation consedering pivot
                float2 uv = v.texcoord.xy-pivot;
                float2 temp = TRANSFORM_TEX(uv, _MainTex);
                o.uv = mul(rot, temp);
                
               o.uv+=pivot;

                //o.uv=mul(rot,temp);
                //o.uv += _MainTex_ST.zw;
                //o.uv=mul(scale,uv);
                //o.uv += _MainTex_ST.zw;
                //o.uv=temp;
 
                return o;
            }
 
           
 
            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // Texel sampling
                return col;
            }
 
            ENDCG
        }
    }
}