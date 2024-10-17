// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FXAse/FX_All"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(blend,10,add,1)]_Float1("材质模式", Float) = 10
		[Toggle]_Float4("深度写入", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_Ztestmode("深度测试", Float) = 4
		[Enum(UnityEngine.Rendering.CullMode)]_Float2("双面模式", Float) = 0
		[HDR]_Color0("颜色", Color) = (1,1,1,1)
		[Toggle]_Float34("启用第二面颜色", Float) = 0
		[HDR]_Color2("颜色2", Color) = (1,1,1,1)
		_Float14("整体颜色强度", Float) = 1
		_Float15("整体透明度", Range( 0 , 1)) = 1
		[Header(depthfade)]_Float16("软粒子（羽化边缘）", Float) = 0
		[Toggle]_Float5("反向软粒子(强化边缘）", Float) = 0
		_Float28("边缘强度", Float) = 1
		_Float30("边缘收窄", Float) = 1
		[Toggle][Header(Fresnel)]_Float33("菲尼尔开关", Float) = 0
		_power3("菲尼尔强度", Float) = 1
		_Float19("菲尼尔范围", Float) = 1
		[Toggle]_Float20("反向菲尼尔（虚化边缘）", Float) = 0
		[Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(Main)]_maintex("主贴图", 2D) = "white" {}
		_Main_Desa("Main_Desa", Float) = 0
		_Main_Refine("Main_Refine", Vector) = (1,1,1,0.5)
		_Gradienttex("混合颜色贴图", 2D) = "white" {}
		[KeywordEnum(A,R)] _Keyword1("主贴图通道", Float) = 0
		_Float29("颜色混合", Range( 0 , 1)) = 0
		_Vector0("主贴图流动", Vector) = (0,0,0,0)
		_Vector7("混合图流动", Vector) = (0,0,0,0)
		[Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(Mask)]_Mask("遮罩01", 2D) = "white" {}
		[KeywordEnum(R,A)] _Keyword0("遮罩01通道", Float) = 1
		_Vector3("遮罩01流动", Vector) = (0,0,0,0)
		_Mask1("遮罩02", 2D) = "white" {}
		[KeywordEnum(R,A)] _Keyword2("遮罩02通道", Float) = 1
		_Vector6("遮罩02流动", Vector) = (0,0,0,0)
		[Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(dissolove)]_dissolvetex("溶解贴图", 2D) = "white" {}
		_Vector2("溶解流动", Vector) = (0,0,0,0)
		[KeywordEnum(up,down,left,right,off)] _Keyword7("溶解方向", Float) = 4
		_Float18("溶解方向强度", Float) = 1
		_Float6("溶解", Range( 0 , 1)) = 0
		_Float8("软硬", Range( 0.5 , 1)) = 0.5
		[KeywordEnum(off,on)] _Keyword5("亮边溶解", Float) = 0
		_Float17("亮边宽度", Range( 0 , 0.1)) = 0
		[HDR]_Color1("亮边颜色", Color) = (1,1,1,1)
		[Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(Noise)]_noise("扰动贴图", 2D) = "white" {}
		_flowmaptex("flowmaptex", 2D) = "white" {}
		_Vector1("扰动速度", Vector) = (0,0,0,0)
		_Float9("扰动", Range( 0 , 1)) = 0
		_Float32("flowmap扰动", Range( 0 , 1)) = 0
		[Toggle]_Float0("扰动影响mask", Float) = 0
		[Toggle]_Float13("扰动影响溶解", Float) = 0
		[Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(Vertex_offset)]_vertextex("顶点偏移贴图", 2D) = "white" {}
		_Vector5("顶点偏移强度", Vector) = (0,0,0,0)
		_Vector4("顶点偏移速度", Vector) = (0,0,0,0)
		[Toggle][Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________)][Header(Custom)]_Float10("custom1xy控制主贴图偏移", Float) = 0
		[Toggle]_Float12("custom1zw控制mask01偏移", Float) = 0
		[Toggle]_Float11("custom2x控制溶解", Float) = 0
		[Toggle]_Float31("custom2y控制flowmap扭曲", Float) = 0
		[Toggle]_Float22("custom2w控制顶点偏移强度", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		[HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull [_Float2]
		AlphaToMask Off
		
		HLSLINCLUDE
		#pragma target 3.0

		#pragma prefer_hlslcc gles
		#pragma exclude_renderers d3d11_9x 

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS

		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend SrcAlpha [_Float1], One OneMinusSrcAlpha
			ZWrite [_Float4]
			ZTest [_Ztestmode]
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma shader_feature _ _SAMPLE_GI
			#pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ DEBUG_DISPLAY
			#define SHADERPASS SHADERPASS_UNLIT


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Debug/Debugging3D.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"


			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _Gradienttex;
			sampler2D _dissolvetex;
			sampler2D _Mask;
			sampler2D _Mask1;


						
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord3 = screenPos97;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord7.xyz = ase_worldNormal;
				
				o.ase_texcoord4.xy = v.ase_texcoord.xy;
				o.ase_texcoord5 = v.ase_texcoord1;
				o.ase_texcoord6 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;
				o.ase_texcoord7.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif
				float4 screenPos97 = IN.ase_texcoord3;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult330 = lerp( 0.0 , depthfade126 , depthfade_switch334);
				float2 uv_maintex = IN.ase_texcoord4.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord5;
				texCoord39.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord4.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord4.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord6;
				texCoord100.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				float3 desaturateInitialColor13_g31 = float4( (tex2DNode1).rgb , 0.0 ).rgb;
				float desaturateDot13_g31 = dot( desaturateInitialColor13_g31, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar13_g31 = lerp( desaturateInitialColor13_g31, desaturateDot13_g31.xxx, _Main_Desa );
				float4 temp_output_4_0_g31 = _Main_Refine;
				float3 temp_cast_3 = ((temp_output_4_0_g31).x).xxx;
				float3 lerpResult11_g31 = lerp( ( pow( desaturateVar13_g31 , temp_cast_3 ) * (temp_output_4_0_g31).y ) , ( desaturateVar13_g31 * (temp_output_4_0_g31).z ) , (temp_output_4_0_g31).w);
				float2 uv_Gradienttex = IN.ase_texcoord4.xy * _Gradienttex_ST.xy + _Gradienttex_ST.zw;
				float2 panner229 = ( 1.0 * _Time.y * _Vector7 + uv_Gradienttex);
				float2 Gradienttex231 = panner229;
				float2 temp_cast_5 = (noise70).xx;
				float2 lerpResult235 = lerp( Gradienttex231 , temp_cast_5 , noise_intensity67);
				float4 lerpResult211 = lerp( float4( lerpResult11_g31 , 0.0 ) , tex2D( _Gradienttex, lerpResult235 ) , _Float29);
				float4 lerpResult359 = lerp( _Color0 , _Color2 , _Float34);
				float4 switchResult358 = (((ase_vface>0)?(_Color0):(lerpResult359)));
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 ase_worldNormal = IN.ase_texcoord7.xyz;
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				float4 texCoord49 = IN.ase_texcoord6;
				texCoord49.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float2 texCoord263 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord4.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_6 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_6 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord6;
				texCoord303.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_edge133 = ( temp_output_105_0 - step( ( lerpResult62 + _Float17 ) , temp_output_130_0 ) );
				float4 lerpResult131 = lerp( ( ( ( _Float28 * pow( lerpResult330 , _Float30 ) ) + lerpResult211 ) * IN.ase_color * switchResult358 * _Float14 * lerpResult347 ) , _Color1 , dis_edge133);
				
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord4.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord5;
				texCoord74.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord4.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = lerpResult131.rgb;
				float Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(IN.clipPos, Color);
				#endif

				#if defined(_ALPHAPREMULTIPLY_ON)
				Color *= Alpha;
				#endif


				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			
			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_color : COLOR;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord5 = screenPos97;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord6.xyz = ase_worldNormal;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				o.ase_texcoord3 = v.ase_texcoord1;
				o.ase_texcoord4 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord6.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = TransformWorldToHClip( positionWS );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_maintex = IN.ase_texcoord2.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord3;
				texCoord39.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord2.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord2.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord4;
				texCoord100.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float2 texCoord263 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord2.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_1 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_1 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord4;
				texCoord303.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float4 texCoord49 = IN.ase_texcoord4;
				texCoord49.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float4 screenPos97 = IN.ase_texcoord5;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord2.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord3;
				texCoord74.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord2.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				
				float Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }
			
			Blend SrcAlpha [_Float1], One OneMinusSrcAlpha
			ZWrite [_Float4]
			ZTest [_Ztestmode]
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma shader_feature _ _SAMPLE_GI
			#pragma multi_compile _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ DEBUG_DISPLAY
			#define SHADERPASS SHADERPASS_UNLIT


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Debug/Debugging3D.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"


			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _Gradienttex;
			sampler2D _dissolvetex;
			sampler2D _Mask;
			sampler2D _Mask1;


						
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord3 = screenPos97;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord7.xyz = ase_worldNormal;
				
				o.ase_texcoord4.xy = v.ase_texcoord.xy;
				o.ase_texcoord5 = v.ase_texcoord1;
				o.ase_texcoord6 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;
				o.ase_texcoord7.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif
				float4 screenPos97 = IN.ase_texcoord3;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult330 = lerp( 0.0 , depthfade126 , depthfade_switch334);
				float2 uv_maintex = IN.ase_texcoord4.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord5;
				texCoord39.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord4.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord4.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord6;
				texCoord100.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				float3 desaturateInitialColor13_g31 = float4( (tex2DNode1).rgb , 0.0 ).rgb;
				float desaturateDot13_g31 = dot( desaturateInitialColor13_g31, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar13_g31 = lerp( desaturateInitialColor13_g31, desaturateDot13_g31.xxx, _Main_Desa );
				float4 temp_output_4_0_g31 = _Main_Refine;
				float3 temp_cast_3 = ((temp_output_4_0_g31).x).xxx;
				float3 lerpResult11_g31 = lerp( ( pow( desaturateVar13_g31 , temp_cast_3 ) * (temp_output_4_0_g31).y ) , ( desaturateVar13_g31 * (temp_output_4_0_g31).z ) , (temp_output_4_0_g31).w);
				float2 uv_Gradienttex = IN.ase_texcoord4.xy * _Gradienttex_ST.xy + _Gradienttex_ST.zw;
				float2 panner229 = ( 1.0 * _Time.y * _Vector7 + uv_Gradienttex);
				float2 Gradienttex231 = panner229;
				float2 temp_cast_5 = (noise70).xx;
				float2 lerpResult235 = lerp( Gradienttex231 , temp_cast_5 , noise_intensity67);
				float4 lerpResult211 = lerp( float4( lerpResult11_g31 , 0.0 ) , tex2D( _Gradienttex, lerpResult235 ) , _Float29);
				float4 lerpResult359 = lerp( _Color0 , _Color2 , _Float34);
				float4 switchResult358 = (((ase_vface>0)?(_Color0):(lerpResult359)));
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 ase_worldNormal = IN.ase_texcoord7.xyz;
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				float4 texCoord49 = IN.ase_texcoord6;
				texCoord49.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float2 texCoord263 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord4.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_6 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_6 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord6;
				texCoord303.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_edge133 = ( temp_output_105_0 - step( ( lerpResult62 + _Float17 ) , temp_output_130_0 ) );
				float4 lerpResult131 = lerp( ( ( ( _Float28 * pow( lerpResult330 , _Float30 ) ) + lerpResult211 ) * IN.ase_color * switchResult358 * _Float14 * lerpResult347 ) , _Color1 , dis_edge133);
				
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord4.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord5;
				texCoord74.xy = IN.ase_texcoord5.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord4.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = lerpResult131.rgb;
				float Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(IN.clipPos, Color);
				#endif

				#if defined(_ALPHAPREMULTIPLY_ON)
				Color *= Alpha;
				#endif


				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}


		
        Pass
        {
			
            Name "SceneSelectionPass"
            Tags { "LightMode"="SceneSelectionPass" }
        
			Cull Off

			HLSLPROGRAM
        
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

        
			#pragma only_renderers d3d11 glcore gles gles3 
			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _vertextex;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			
			int _ObjectId;
			int _PassValue;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
        
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord3 = screenPos97;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord4.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord5.xyz = ase_worldNormal;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				o.clipPos = TransformWorldToHClip(positionWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif
			
			half4 frag(VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_maintex = IN.ase_texcoord.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord1;
				texCoord39.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord2;
				texCoord100.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float2 texCoord263 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_1 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_1 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord2;
				texCoord303.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float4 texCoord49 = IN.ase_texcoord2;
				texCoord49.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float4 screenPos97 = IN.ase_texcoord3;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord1;
				texCoord74.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				float3 ase_worldPos = IN.ase_texcoord4.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 ase_worldNormal = IN.ase_texcoord5.xyz;
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				
				surfaceDescription.Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				surfaceDescription.AlphaClipThreshold = 0.5;


				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				return outColor;
			}

			ENDHLSL
        }

		
        Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }
        
			HLSLPROGRAM

			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma only_renderers d3d11 glcore gles gles3 
			#pragma vertex vert
			#pragma fragment frag

        
			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY
			

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _vertextex;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			
        
			float4 _SelectionID;

        
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
        
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);


				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord3 = screenPos97;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord4.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord5.xyz = ase_worldNormal;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				o.clipPos = TransformWorldToHClip(positionWS);
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_maintex = IN.ase_texcoord.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord1;
				texCoord39.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord2;
				texCoord100.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float2 texCoord263 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_1 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_1 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord2;
				texCoord303.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float4 texCoord49 = IN.ase_texcoord2;
				texCoord49.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float4 screenPos97 = IN.ase_texcoord3;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord1;
				texCoord74.xy = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				float3 ase_worldPos = IN.ase_texcoord4.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 ase_worldNormal = IN.ase_texcoord5.xyz;
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				
				surfaceDescription.Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				surfaceDescription.AlphaClipThreshold = 0.5;


				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;
				outColor = _SelectionID;
				
				return outColor;
			}
        
			ENDHLSL
        }
		
		
        Pass
        {
			
            Name "DepthNormals"
            Tags { "LightMode"="DepthNormalsOnly" }

			ZTest LEqual
			ZWrite On

        
			HLSLPROGRAM
			
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			
			#pragma only_renderers d3d11 glcore gles gles3 
			#pragma multi_compile_fog
			#pragma instancing_options renderinglayer
			#pragma vertex vert
			#pragma fragment frag

        
			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_NORMAL_WS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			      
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
        
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord4 = screenPos97;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord5.xyz = ase_worldPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_texcoord3 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal(v.ase_normal);

				o.clipPos = TransformWorldToHClip(positionWS);
				o.normalWS.xyz =  normalWS;

				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_maintex = IN.ase_texcoord1.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord2;
				texCoord39.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord1.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord1.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord3;
				texCoord100.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float2 texCoord263 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord1.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_1 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_1 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord3;
				texCoord303.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float4 texCoord49 = IN.ase_texcoord3;
				texCoord49.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float4 screenPos97 = IN.ase_texcoord4;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord1.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord2;
				texCoord74.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord1.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				float3 ase_worldPos = IN.ase_texcoord5.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 normalizedWorldNormal = normalize( IN.normalWS );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				
				surfaceDescription.Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				surfaceDescription.AlphaClipThreshold = 0.5;

				#if _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				float3 normalWS = IN.normalWS;
				return half4(NormalizeNormalPerPixel(normalWS), 0.0);

			}
        
			ENDHLSL
        }

		
        Pass
        {
			
            Name "DepthNormalsOnly"
            Tags { "LightMode"="DepthNormalsOnly" }
        
			ZTest LEqual
			ZWrite On
        
        
			HLSLPROGRAM
        
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

        
			#pragma exclude_renderers glcore gles gles3 
			#pragma vertex vert
			#pragma fragment frag
        
			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define ATTRIBUTES_NEED_TEXCOORD1
			#define VARYINGS_NEED_NORMAL_WS
			#define VARYINGS_NEED_TANGENT_WS
        
			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _KEYWORD1_A _KEYWORD1_R
			#pragma shader_feature_local _KEYWORD5_OFF _KEYWORD5_ON
			#pragma shader_feature_local _KEYWORD7_UP _KEYWORD7_DOWN _KEYWORD7_LEFT _KEYWORD7_RIGHT _KEYWORD7_OFF
			#pragma shader_feature_local _KEYWORD0_R _KEYWORD0_A
			#pragma shader_feature_local _KEYWORD2_R _KEYWORD2_A


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
        
			CBUFFER_START(UnityPerMaterial)
			float4 _Gradienttex_ST;
			float4 _Mask_ST;
			float4 _dissolvetex_ST;
			float4 _Color1;
			float4 _Color2;
			float4 _Color0;
			half4 _Main_Refine;
			float4 _flowmaptex_ST;
			float4 _noise_ST;
			float4 _maintex_ST;
			float4 _Mask1_ST;
			float4 _vertextex_ST;
			float3 _Vector5;
			float2 _Vector0;
			float2 _Vector1;
			float2 _Vector2;
			float2 _Vector3;
			float2 _Vector4;
			float2 _Vector6;
			float2 _Vector7;
			float _Float30;
			float _Float11;
			float _Float18;
			float _Float4;
			float _Float13;
			float _Float17;
			float _Float8;
			float _Float15;
			float _Float2;
			float _Float12;
			float _Float0;
			float _Float6;
			float _Ztestmode;
			float _power3;
			float _Float20;
			float _Float19;
			float _Float5;
			float _Float14;
			float _Float34;
			float _Float29;
			half _Main_Desa;
			float _Float31;
			float _Float32;
			float _Float22;
			float _Float9;
			float _Float28;
			float _Float10;
			float _Float16;
			float _Float33;
			float _Float1;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			sampler2D _maintex;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			
			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
      
			VertexOutput VertexFunction(VertexInput v  )
			{
				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);

				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 panner168 = ( 1.0 * _Time.y * _Vector4 + uv_vertextex);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float3 vertexoffset181 = ( tex2Dlod( _vertextex, float4( panner168, 0, 0.0) ).r * v.ase_normal * _Vector5 * lerpResult176 );
				
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord4 = screenPos97;
				float3 ase_worldPos = mul(GetObjectToWorldMatrix(), v.vertex).xyz;
				o.ase_texcoord5.xyz = ase_worldPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord2 = v.ase_texcoord1;
				o.ase_texcoord3 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 normalWS = TransformObjectToWorldNormal(v.ase_normal);

				o.clipPos = TransformWorldToHClip(positionWS);
				o.normalWS.xyz =  normalWS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN , FRONT_FACE_TYPE ase_vface : FRONT_FACE_SEMANTIC) : SV_TARGET
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float2 uv_maintex = IN.ase_texcoord1.xy * _maintex_ST.xy + _maintex_ST.zw;
				float2 panner36 = ( 1.0 * _Time.y * _Vector0 + uv_maintex);
				float4 texCoord39 = IN.ase_texcoord2;
				texCoord39.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( panner36 , ( uv_maintex + appendResult42 ) , _Float10);
				float2 maintexUV161 = lerpResult59;
				float2 uv_noise = IN.ase_texcoord1.xy * _noise_ST.xy + _noise_ST.zw;
				float2 panner53 = ( 1.0 * _Time.y * _Vector1 + uv_noise);
				float noise70 = tex2D( _noise, panner53 ).r;
				float2 temp_cast_0 = (noise70).xx;
				float noise_intensity67 = _Float9;
				float2 lerpResult54 = lerp( maintexUV161 , temp_cast_0 , noise_intensity67);
				float2 uv_flowmaptex = IN.ase_texcoord1.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord3;
				texCoord100.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( lerpResult54 , flowmap285 , lerpResult99);
				float4 tex2DNode1 = tex2D( _maintex, lerpResult283 );
				#if defined(_KEYWORD1_A)
				float staticSwitch14 = tex2DNode1.a;
				#elif defined(_KEYWORD1_R)
				float staticSwitch14 = tex2DNode1.r;
				#else
				float staticSwitch14 = tex2DNode1.a;
				#endif
				float2 texCoord263 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord264 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord266 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 texCoord262 = IN.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				#if defined(_KEYWORD7_UP)
				float staticSwitch272 = ( 1.0 - saturate( texCoord263.y ) );
				#elif defined(_KEYWORD7_DOWN)
				float staticSwitch272 = saturate( texCoord264.y );
				#elif defined(_KEYWORD7_LEFT)
				float staticSwitch272 = saturate( texCoord266.x );
				#elif defined(_KEYWORD7_RIGHT)
				float staticSwitch272 = ( 1.0 - saturate( texCoord262.x ) );
				#elif defined(_KEYWORD7_OFF)
				float staticSwitch272 = 1.0;
				#else
				float staticSwitch272 = 1.0;
				#endif
				float dis_direction277 = pow( staticSwitch272 , _Float18 );
				float2 uv_dissolvetex = IN.ase_texcoord1.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 panner58 = ( 1.0 * _Time.y * _Vector2 + uv_dissolvetex);
				float2 temp_cast_1 = (noise70).xx;
				float2 lerpResult308 = lerp( panner58 , temp_cast_1 , noise_intensity67);
				float4 texCoord303 = IN.ase_texcoord3;
				texCoord303.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( lerpResult308 , flowmap285 , lerpResult307);
				float2 lerpResult89 = lerp( panner58 , lerpResult309 , _Float13);
				float2 dissolveUV92 = lerpResult89;
				float temp_output_280_0 = ( dis_direction277 * tex2D( _dissolvetex, dissolveUV92 ).r );
				float4 texCoord49 = IN.ase_texcoord3;
				texCoord49.xy = IN.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float smoothstepResult32 = smoothstep( ( 1.0 - _Float8 ) , _Float8 , saturate( ( ( temp_output_280_0 + 1.0 ) - ( lerpResult62 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float temp_output_130_0 = (0.0 + (temp_output_280_0 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult62 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				#if defined(_KEYWORD5_OFF)
				float staticSwitch239 = dis_soft122;
				#elif defined(_KEYWORD5_ON)
				float staticSwitch239 = dis_bright124;
				#else
				float staticSwitch239 = dis_soft122;
				#endif
				float4 screenPos97 = IN.ase_texcoord4;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = lerpResult336;
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 uv_Mask = IN.ase_texcoord1.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 panner79 = ( 1.0 * _Time.y * _Vector3 + uv_Mask);
				float4 texCoord74 = IN.ase_texcoord2;
				texCoord74.xy = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult80 = lerp( panner79 , ( uv_Mask + appendResult75 ) , _Float12);
				float lerpResult325 = lerp( 0.0 , ( noise70 * noise_intensity67 ) , _Float0);
				float4 tex2DNode8 = tex2D( _Mask, ( lerpResult80 + lerpResult325 ) );
				#if defined(_KEYWORD0_R)
				float staticSwitch11 = tex2DNode8.r;
				#elif defined(_KEYWORD0_A)
				float staticSwitch11 = tex2DNode8.a;
				#else
				float staticSwitch11 = tex2DNode8.a;
				#endif
				float2 uv_Mask1 = IN.ase_texcoord1.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 panner216 = ( 1.0 * _Time.y * _Vector6 + uv_Mask1);
				float4 tex2DNode218 = tex2D( _Mask1, ( lerpResult325 + panner216 ) );
				#if defined(_KEYWORD2_R)
				float staticSwitch219 = tex2DNode218.r;
				#elif defined(_KEYWORD2_A)
				float staticSwitch219 = tex2DNode218.a;
				#else
				float staticSwitch219 = tex2DNode218.a;
				#endif
				float Mask82 = ( staticSwitch11 * staticSwitch219 );
				float3 ase_worldPos = IN.ase_texcoord5.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 normalizedWorldNormal = normalize( IN.normalWS );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				
				surfaceDescription.Alpha = ( staticSwitch14 * IN.ase_color.a * _Color0.a * staticSwitch239 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				surfaceDescription.AlphaClipThreshold = 0.5;
				
				#if _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				float3 normalWS = IN.normalWS;
				return half4(NormalizeNormalPerPixel(normalWS), 0.0);

			}

			ENDHLSL
        }
		
	}
	
	CustomEditor "ASEMaterialInspector"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18935
2646;49.33334;2560;1373;2135.531;2524.918;1.759561;True;True
Node;AmplifyShaderEditor.CommentaryNode;259;-5357.104,-2330.234;Inherit;False;1636.939;987.6809;扰动;7;70;50;53;51;52;55;67;扰动;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;52;-5243.104,-1924.289;Inherit;False;Property;_Vector1;扰动速度;42;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-5307.104,-2148.289;Inherit;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;53;-4955.104,-2148.289;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;312;-5106.146,-2950.022;Inherit;False;1094.708;330.5801;flowmap;7;241;242;285;310;311;305;316;flowmap;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;241;-5056.146,-2894.798;Inherit;True;Property;_flowmaptex;flowmaptex;41;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-4840.852,-1778.521;Inherit;False;Property;_Float9;扰动;43;0;Create;False;0;0;0;False;0;False;0;0.138;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;305;-4508.5,-2814.648;Inherit;False;Property;_Float31;custom2y控制flowmap扭曲;53;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-4514.317,-2707.73;Inherit;False;Property;_Float32;flowmap扰动;44;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-4698.2,-2167.009;Inherit;True;Property;_noise;扰动贴图;40;0;Create;False;0;0;0;False;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(Noise);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;315;-4641.798,2275.623;Inherit;False;1321.745;1338.922;溶解uv;15;57;56;302;314;58;304;308;307;306;90;309;89;92;303;317;溶解uv;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;278;-3229.496,771.2501;Inherit;False;2403.086;1048.659;溶解方向;15;262;265;271;263;264;270;266;268;267;269;272;274;277;279;282;溶解方向;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;242;-4741.872,-2873.442;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-4327.011,-1782.353;Inherit;False;noise_intensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;56;-4553.451,2494.174;Inherit;False;Property;_Vector2;溶解流动;32;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;316;-4238.615,-2816.66;Inherit;False;flpwmap_custom_switch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-4591.798,2325.623;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;311;-4222.354,-2702.069;Inherit;False;flowmap_intensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-4099.011,-2017.946;Inherit;False;noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;-4348.539,2891.422;Inherit;False;67;noise_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;317;-4053.379,3308.939;Inherit;False;316;flpwmap_custom_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;314;-4247.46,3161.452;Inherit;False;311;flowmap_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;263;-3136.698,882.8436;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;303;-4570.194,3312.545;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;304;-4554.514,2792.454;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;262;-3153.605,1104.564;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;285;-4455.108,-2900.022;Inherit;False;flowmap;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;58;-4197.188,2337.896;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;264;-3132.348,1316.446;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;306;-4098.13,2973.241;Inherit;False;285;flowmap;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;307;-3839.906,3116.869;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;308;-3982.747,2782.508;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;265;-2650.06,1059.232;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;267;-2680.087,821.2501;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;266;-3179.496,1560.16;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;279;-1954.578,1225.773;Inherit;False;Constant;_Float25;Float 25;52;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-3925.762,2598.177;Inherit;False;Property;_Float13;扰动影响溶解;46;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;270;-2668.326,1300.02;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;269;-2168.952,1465.344;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;271;-2294.883,833.8645;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;268;-2671.69,1565.909;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;309;-3775.692,2936.646;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;89;-3711.171,2343.505;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;272;-1723.76,973.114;Inherit;False;Property;_Keyword7;溶解方向;33;0;Create;False;0;0;0;False;0;False;0;4;4;True;;KeywordEnum;5;up;down;left;right;off;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;274;-1705.432,1353.576;Inherit;False;Property;_Float18;溶解方向强度;34;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;222;-5994.708,-845.4651;Inherit;False;2384.237;985.5953;mask;24;74;75;80;76;79;216;215;8;77;78;73;218;217;219;11;220;82;319;320;321;323;325;326;322;mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-3242.576,-1114.299;Inherit;False;1704.885;838.751;软溶解;18;49;29;93;61;23;25;31;62;24;30;26;33;34;45;32;122;280;281;软溶解;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;163;-3183.21,-2061.124;Inherit;False;1568.74;739.7102;主贴图uv;9;39;38;35;42;43;60;36;59;161;主贴图uv;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;282;-1296.819,1064.88;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;-3544.052,2342.612;Inherit;False;dissolveUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-3235.307,-1025.707;Inherit;False;92;dissolveUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;146;-3141.72,3013.755;Inherit;False;1475.065;723.4756;菲尼尔;11;135;137;138;139;140;141;142;144;147;136;352;菲尼尔;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;74;-5928.285,-495.9125;Inherit;True;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-3116.787,-1623.414;Inherit;True;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;-1050.409,1159.944;Inherit;False;dis_direction;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-2985.598,-967.2079;Inherit;True;Property;_dissolvetex;溶解贴图;31;0;Create;False;0;0;0;False;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(dissolove);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-3129.754,-2011.097;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;75;-5561.965,-473.0595;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;38;-3126.63,-1779.343;Inherit;False;Property;_Vector0;主贴图流动;23;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;29;-3259.307,-775.4673;Inherit;False;Property;_Float6;溶解;35;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FaceVariableNode;352;-3012.43,3187.22;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;281;-2884.968,-1050.823;Inherit;False;277;dis_direction;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-3192.576,-577.5476;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;136;-3118.165,3057.115;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;323;-5401.515,-286.7453;Inherit;False;67;noise_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-5944.708,-795.4651;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;78;-5941.672,-651.8412;Inherit;False;Property;_Vector3;遮罩01流动;27;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2750.469,-1600.561;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-2953.932,-406.6647;Inherit;False;Property;_Float11;custom2x控制溶解;52;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;321;-5373.905,-367.265;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;36;-2235.103,-1957.331;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-5122.926,-360.6021;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;326;-5234.906,-221.5508;Inherit;False;Property;_Float0;扰动影响mask;45;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2154.981,-590.7465;Inherit;False;Constant;_Float7;Float 7;11;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-2396.793,-1523.235;Inherit;False;Property;_Float10;custom1xy控制主贴图偏移;50;1;[Toggle];Create;False;0;0;0;True;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(Custom);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-5174.958,-635.9762;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-2363.461,-1763.479;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-5244.104,-447.2352;Inherit;False;Property;_Float12;custom1zw控制mask01偏移;51;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;79;-5352.521,-775.942;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-3076.711,3573.226;Inherit;False;Property;_Float19;菲尼尔范围;15;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;280;-2601.269,-1043.629;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;351;-2795.43,3144.22;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;137;-3052.719,3270.273;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;215;-5765.702,-23.86981;Inherit;False;Property;_Vector6;遮罩02流动;30;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;217;-5772.283,-167.4938;Inherit;False;0;218;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-2540.672,-779.4243;Inherit;False;Constant;_Float3;Float 3;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-3045.824,3462.564;Inherit;False;Property;_power3;菲尼尔强度;14;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;166;-4849.573,346.73;Inherit;False;1013.145;364.3818; 软粒子;9;126;97;98;96;327;333;334;336;337; 软粒子;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;62;-2857.467,-611.6447;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;216;-5180.097,-147.9706;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;325;-4971.906,-384.5508;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-4814.956,559.1118;Inherit;False;Property;_Float16;软粒子（羽化边缘）;9;0;Create;False;0;0;0;False;1;Header(depthfade);False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2183.264,-799.4915;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;80;-5049.679,-662.7581;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;98;-4799.573,396.73;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2337.378,-949.1023;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;-4649.978,626.7843;Inherit;False;Property;_Float5;反向软粒子(强化边缘）;10;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;139;-2742.485,3325.885;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;59;-2021.282,-1749.128;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;114;-3266.725,-91.41841;Inherit;False;1936.036;770.2162; 亮边溶解;8;107;109;105;106;108;124;130;133;亮边溶解;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;180;-5128.478,875.4525;Inherit;False;1665.282;998.5445;顶点偏移;12;168;169;174;173;175;171;172;176;179;178;167;181;顶点偏移;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2155.09,-523.9337;Inherit;False;Property;_Float8;软硬;36;0;Create;False;0;0;0;False;0;False;0.5;0.5;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;319;-4828.684,-505.7112;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-2147.399,-942.2343;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;140;-2505.02,3326.082;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;320;-4798.809,-342.6068;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;97;-4568.121,396.1555;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;334;-4433.661,613.0753;Inherit;False;depthfade_switch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-1838.962,-1685.382;Inherit;False;maintexUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;-4206.33,590.5173;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-4696.942,-702.1471;Inherit;True;Property;_Mask;遮罩01;25;0;Create;False;0;0;0;False;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(Mask);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;318;-1177.717,-1744.174;Inherit;False;316;flpwmap_custom_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1397.838,-2200.757;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;130;-2660.92,55.1325;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-0.5;False;2;FLOAT;1.5;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-1389.01,-2052.303;Inherit;False;67;noise_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;327;-4346.442,478.0409;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;-1333.481,-2355.605;Inherit;False;161;maintexUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;34;-2013.377,-832.5081;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;45;-1925.274,-970.001;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;173;-5078.478,925.4525;Inherit;False;0;169;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;141;-2409.202,3428.264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;-1458.991,-1803.176;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;174;-5003.367,1119.028;Inherit;False;Property;_Vector4;顶点偏移速度;49;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;142;-2560.026,3560.687;Inherit;False;Property;_Float20;反向菲尼尔（虚化边缘）;16;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;218;-4717.019,-195.1452;Inherit;True;Property;_Mask1;遮罩02;28;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;313;-1214.078,-1882.204;Inherit;False;311;flowmap_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;105;-2179.739,-20.72756;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;336;-4189.853,396.8458;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;32;-1809.235,-917.3443;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;179;-4308.716,1765.997;Inherit;False;Property;_Float22;custom2w控制顶点偏移强度;54;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;11;-4312.613,-585.4786;Inherit;False;Property;_Keyword0;遮罩01通道;26;0;Create;False;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;R;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-962.1192,-2131.317;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;99;-915.579,-1865.656;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-4112.101,1411.493;Inherit;False;Constant;_Float21;Float 21;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;167;-4372.483,1492.887;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;219;-4400.522,-179.0679;Inherit;False;Property;_Keyword2;遮罩02通道;29;0;Create;False;0;0;0;False;0;False;0;1;1;True;;KeywordEnum;2;R;A;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;-1065.801,-1965.284;Inherit;False;285;flowmap;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;144;-2176.633,3335.982;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;168;-4788.672,1032.506;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;283;-743.366,-2001.879;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;176;-3843.344,1361.758;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;-1878.385,3301.25;Inherit;False;fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-1839.585,-31.91609;Inherit;False;dis_bright;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;175;-4224.363,1265.698;Inherit;False;Property;_Vector5;顶点偏移强度;48;0;Create;False;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-1715.256,-669.2873;Inherit;False;dis_soft;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-4139.382,-383.034;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-4028.227,398.5875;Inherit;False;depthfade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;169;-4509.863,994.5781;Inherit;True;Property;_vertextex;顶点偏移贴图;47;0;Create;False;0;0;0;False;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(Vertex_offset);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;172;-4147.279,1113.054;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;340;147.6157,157.3226;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-519.4912,-1951.262;Inherit;True;Property;_maintex;主贴图;17;0;Create;False;0;0;0;False;2;Header(___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________);Header(Main);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;123;-766.8659,-215.0265;Inherit;False;122;dis_soft;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3834.47,-385.3945;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-300.7165,-441.6401;Inherit;False;147;fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-107.1196,-351.5812;Inherit;False;Property;_Float33;菲尼尔开关;13;1;[Toggle];Create;False;0;0;0;False;1;Header(Fresnel);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-306.5648,-518.2598;Inherit;False;Constant;_Float27;Float 27;43;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-3850.968,1014.011;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;157.3221,51.57904;Inherit;False;126;depthfade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-760.3593,-131.436;Inherit;False;124;dis_bright;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;236;-3033.356,-2664.823;Inherit;False;1214.206;357.624;Gradient;4;224;229;226;231;Gradienttex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-155.7354,-57.72403;Inherit;False;Property;_Float15;整体透明度;8;0;Create;False;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;3;-861.5941,-1184.052;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;338;543.0873,82.17676;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;14;246.3106,-1695.237;Inherit;False;Property;_Keyword1;主贴图通道;21;0;Create;False;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;A;R;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-3678.302,1029.461;Inherit;False;vertexoffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;239;-321.2267,-210.135;Inherit;False;Property;_Keyword5;亮边溶解;37;0;Create;False;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;off;on;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;221;592.5698,217.0276;Inherit;False;82;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-959.7765,-850.6129;Inherit;False;Property;_Color0;颜色;4;1;[HDR];Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;347;242.4988,-554.7366;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-5809.21,-1168.036;Inherit;False;Property;_Float2;双面模式;3;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;229;-2321.719,-2611.17;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;361;-990.8277,-643.9102;Inherit;False;Property;_Color2;颜色2;6;1;[HDR];Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;362;-944.1396,-438.7301;Inherit;False;Property;_Float34;启用第二面颜色;5;1;[Toggle];Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;-1141.868,-1504.726;Inherit;False;231;Gradienttex;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;329;485.4018,-1926.837;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;335;-234.7316,-2592.042;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;224;-2974.776,-2471.199;Inherit;False;Property;_Vector7;混合图流动;24;0;Create;False;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;343;-20.41338,-2883.669;Inherit;False;Property;_Float28;边缘强度;11;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;131;757.0637,-1185.447;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;307.422,-2761.746;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;332;-229.6644,-2689.205;Inherit;False;126;depthfade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;1285.657,-227.2876;Inherit;False;8;8;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;345;229.9955,-2603.872;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;368;58.42188,-2301.247;Inherit;False;MF_Refine;-1;;31;0640c227b7cc5bc40ac9f8b5cc1b4774;0;3;1;COLOR;0.5377358,0.5377358,0.5377358,0;False;4;FLOAT4;1,1,1,0.5;False;15;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;369;-151.2468,-2077.997;Half;False;Property;_Main_Refine;Main_Refine;19;0;Create;True;0;0;0;False;0;False;1,1,1,0.5;1,1,1,0.5;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;226;-2983.356,-2614.823;Inherit;False;0;212;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;330;34.55338,-2646.702;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;346;44.90192,-2464.624;Inherit;False;Property;_Float30;边缘收窄;12;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;-1613.257,88.39095;Inherit;False;dis_edge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-5817.741,-1544.293;Inherit;False;Property;_Float1;材质模式;0;1;[Enum];Create;False;0;2;blend;10;add;1;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;371;-180.3397,-2278.469;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-5820.055,-1308.052;Inherit;False;Property;_Ztestmode;深度测试;2;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-5818.068,-1422.66;Inherit;False;Property;_Float4;深度写入;1;1;[Toggle];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;211;65.72686,-1843.73;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;235;-782.196,-1554.894;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;-2828.034,390.9376;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;-1912.664,169.4133;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-3237.559,396.0135;Inherit;False;Property;_Float17;亮边宽度;38;0;Create;False;0;0;0;False;0;False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;358;-434.1216,-850.1649;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;132;259.3086,-920.8085;Inherit;False;Property;_Color1;亮边颜色;39;1;[HDR];Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;182;1844.156,-443.5735;Inherit;False;181;vertexoffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;359;-596.746,-683.0808;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;107;-2382.176,267.4055;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;370;-132.9057,-2173.364;Half;False;Property;_Main_Desa;Main_Desa;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;456.8172,-765.9245;Inherit;False;133;dis_edge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;231;-2043.15,-2553.012;Inherit;False;Gradienttex;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-178.6825,-891.5779;Inherit;False;Property;_Float14;整体颜色强度;7;0;Create;False;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;549.0233,-1199.041;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;212;-533.6704,-1604.148;Inherit;True;Property;_Gradienttex;混合颜色贴图;20;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;233;-1159.092,-1251.267;Inherit;False;67;noise_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;-1130.526,-1369.417;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-432.9276,-1401.974;Inherit;False;Property;_Float29;颜色混合;22;0;Create;False;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;363;2244.042,-729.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;2;5;False;-1;10;True;13;1;1;False;-1;10;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;True;20;True;3;True;21;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;354;2244.042,-779.3063;Float;False;True;-1;2;ASEMaterialInspector;0;3;FXAse/FX_All;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;0;True;22;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;True;True;2;5;False;-1;10;True;13;1;1;False;-1;10;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;True;2;True;20;True;3;True;21;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;1;0;  Blend;0;0;Two Sided;1;0;Cast Shadows;0;0;  Use Shadow Threshold;0;0;Receive Shadows;0;0;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,-1;0;  Type;0;0;  Tess;16,False,-1;0;  Min;10,False,-1;0;  Max;25,False,-1;0;  Edge Length;16,False,-1;0;  Max Displacement;25,False,-1;0;Vertex Position,InvertActionOnDeselection;1;0;0;10;False;True;False;True;False;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;364;2244.042,-729.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;True;4;d3d11;glcore;gles;gles3;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;353;2244.042,-779.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;356;2244.042,-779.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;355;2244.042,-779.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;366;2244.042,-729.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormals;0;8;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=DepthNormalsOnly;False;True;4;d3d11;glcore;gles;gles3;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;367;2244.042,-729.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormalsOnly;0;9;DepthNormalsOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=DepthNormalsOnly;False;True;15;d3d9;d3d11_9x;d3d11;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;357;2244.042,-779.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;365;2244.042,-729.3063;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ScenePickingPass;0;7;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;True;17;d3d9;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;xboxseries;ps4;playstation;psp2;n3ds;wiiu;switch;nomrt;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;True;4;d3d11;glcore;gles;gles3;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;53;0;51;0
WireConnection;53;2;52;0
WireConnection;50;1;53;0
WireConnection;242;0;241;1
WireConnection;242;1;241;2
WireConnection;67;0;55;0
WireConnection;316;0;305;0
WireConnection;311;0;310;0
WireConnection;70;0;50;1
WireConnection;285;0;242;0
WireConnection;58;0;57;0
WireConnection;58;2;56;0
WireConnection;307;0;314;0
WireConnection;307;1;303;2
WireConnection;307;2;317;0
WireConnection;308;0;58;0
WireConnection;308;1;304;0
WireConnection;308;2;302;0
WireConnection;265;0;262;1
WireConnection;267;0;263;2
WireConnection;270;0;264;2
WireConnection;269;0;265;0
WireConnection;271;0;267;0
WireConnection;268;0;266;1
WireConnection;309;0;308;0
WireConnection;309;1;306;0
WireConnection;309;2;307;0
WireConnection;89;0;58;0
WireConnection;89;1;309;0
WireConnection;89;2;90;0
WireConnection;272;1;271;0
WireConnection;272;0;270;0
WireConnection;272;2;268;0
WireConnection;272;3;269;0
WireConnection;272;4;279;0
WireConnection;282;0;272;0
WireConnection;282;1;274;0
WireConnection;92;0;89;0
WireConnection;277;0;282;0
WireConnection;23;1;93;0
WireConnection;75;0;74;3
WireConnection;75;1;74;4
WireConnection;42;0;39;1
WireConnection;42;1;39;2
WireConnection;36;0;35;0
WireConnection;36;2;38;0
WireConnection;322;0;321;0
WireConnection;322;1;323;0
WireConnection;76;0;77;0
WireConnection;76;1;75;0
WireConnection;43;0;35;0
WireConnection;43;1;42;0
WireConnection;79;0;77;0
WireConnection;79;2;78;0
WireConnection;280;0;281;0
WireConnection;280;1;23;1
WireConnection;351;0;136;0
WireConnection;351;1;352;0
WireConnection;62;0;29;0
WireConnection;62;1;49;1
WireConnection;62;2;61;0
WireConnection;216;0;217;0
WireConnection;216;2;215;0
WireConnection;325;1;322;0
WireConnection;325;2;326;0
WireConnection;30;0;62;0
WireConnection;30;1;31;0
WireConnection;80;0;79;0
WireConnection;80;1;76;0
WireConnection;80;2;73;0
WireConnection;24;0;280;0
WireConnection;24;1;25;0
WireConnection;139;0;351;0
WireConnection;139;4;137;0
WireConnection;139;2;135;0
WireConnection;139;3;138;0
WireConnection;59;0;36;0
WireConnection;59;1;43;0
WireConnection;59;2;60;0
WireConnection;319;0;80;0
WireConnection;319;1;325;0
WireConnection;26;0;24;0
WireConnection;26;1;30;0
WireConnection;140;0;139;0
WireConnection;320;0;325;0
WireConnection;320;1;216;0
WireConnection;97;1;98;0
WireConnection;97;0;96;0
WireConnection;334;0;333;0
WireConnection;161;0;59;0
WireConnection;8;1;319;0
WireConnection;130;0;280;0
WireConnection;327;0;97;0
WireConnection;34;0;33;0
WireConnection;45;0;26;0
WireConnection;141;0;140;0
WireConnection;218;1;320;0
WireConnection;105;0;62;0
WireConnection;105;1;130;0
WireConnection;336;0;97;0
WireConnection;336;1;327;0
WireConnection;336;2;337;0
WireConnection;32;0;45;0
WireConnection;32;1;34;0
WireConnection;32;2;33;0
WireConnection;11;1;8;1
WireConnection;11;0;8;4
WireConnection;54;0;162;0
WireConnection;54;1;71;0
WireConnection;54;2;72;0
WireConnection;99;0;313;0
WireConnection;99;1;100;2
WireConnection;99;2;318;0
WireConnection;219;1;218;1
WireConnection;219;0;218;4
WireConnection;144;0;140;0
WireConnection;144;1;141;0
WireConnection;144;2;142;0
WireConnection;168;0;173;0
WireConnection;168;2;174;0
WireConnection;283;0;54;0
WireConnection;283;1;284;0
WireConnection;283;2;99;0
WireConnection;176;0;178;0
WireConnection;176;1;167;4
WireConnection;176;2;179;0
WireConnection;147;0;144;0
WireConnection;124;0;105;0
WireConnection;122;0;32;0
WireConnection;220;0;11;0
WireConnection;220;1;219;0
WireConnection;126;0;336;0
WireConnection;169;1;168;0
WireConnection;1;1;283;0
WireConnection;82;0;220;0
WireConnection;171;0;169;1
WireConnection;171;1;172;0
WireConnection;171;2;175;0
WireConnection;171;3;176;0
WireConnection;338;0;128;0
WireConnection;338;2;340;0
WireConnection;14;1;1;4
WireConnection;14;0;1;1
WireConnection;181;0;171;0
WireConnection;239;1;123;0
WireConnection;239;0;125;0
WireConnection;347;0;209;0
WireConnection;347;1;150;0
WireConnection;347;2;350;0
WireConnection;229;0;226;0
WireConnection;229;2;224;0
WireConnection;329;0;341;0
WireConnection;329;1;211;0
WireConnection;131;0;5;0
WireConnection;131;1;132;0
WireConnection;131;2;134;0
WireConnection;341;0;343;0
WireConnection;341;1;345;0
WireConnection;6;0;14;0
WireConnection;6;1;3;4
WireConnection;6;2;4;4
WireConnection;6;3;239;0
WireConnection;6;4;95;0
WireConnection;6;5;338;0
WireConnection;6;6;221;0
WireConnection;6;7;347;0
WireConnection;345;0;330;0
WireConnection;345;1;346;0
WireConnection;368;1;371;0
WireConnection;368;4;369;0
WireConnection;368;15;370;0
WireConnection;330;1;332;0
WireConnection;330;2;335;0
WireConnection;133;0;108;0
WireConnection;371;0;1;0
WireConnection;211;0;368;0
WireConnection;211;1;212;0
WireConnection;211;2;213;0
WireConnection;235;0;234;0
WireConnection;235;1;232;0
WireConnection;235;2;233;0
WireConnection;109;0;62;0
WireConnection;109;1;106;0
WireConnection;108;0;105;0
WireConnection;108;1;107;0
WireConnection;358;0;4;0
WireConnection;358;1;359;0
WireConnection;359;0;4;0
WireConnection;359;1;361;0
WireConnection;359;2;362;0
WireConnection;107;0;109;0
WireConnection;107;1;130;0
WireConnection;231;0;229;0
WireConnection;5;0;329;0
WireConnection;5;1;3;0
WireConnection;5;2;358;0
WireConnection;5;3;94;0
WireConnection;5;4;347;0
WireConnection;212;1;235;0
WireConnection;354;2;131;0
WireConnection;354;3;6;0
WireConnection;354;5;182;0
ASEEND*/
//CHKSM=36FAAB92F9A759EFAF529C715EE7CAEFF463102A