Shader "Unlit/LitFog"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque""LightMode"="ForwardBase" }
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
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float4 light : COLOR0;
                float2 factor:TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _LightColor0;
            fixed4 _AmbColor;
            v2f vert (appdata v)
            {
                v2f o;
                o.normal=v.normal;
                float3 normalWorld=normalize(mul(unity_ObjectToWorld,o.normal));
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float brightness = max(0,dot(normalWorld, lightDir));
                float viewDistance = length(_WorldSpaceCameraPos - mul(unity_ObjectToWorld,v.vertex));
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.factor=1-saturate(unity_FogParams.w+unity_FogParams.z*viewDistance);
                o.light=saturate(brightness*_LightColor0+UNITY_LIGHTMODEL_AMBIENT);
                return o;

            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col =lerp( tex2D(_MainTex, i.uv)*i.light,unity_FogColor,i.factor.x);
                return col;
            }
            ENDCG
        }
    }
}
