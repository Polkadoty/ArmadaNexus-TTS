//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "STARWARS/Char_Low_1_Spec" {
Properties {
[DecoHeaderBox(ALBEDO. 0)] _MainTex ("Albedo Texture", 2D) = "white" { }
_MainX ("AlbedoX", Range(0, 5)) = 1
[DecoHeaderBox(MASK)] _MaskBuffer ("Mask Texture (R: Reflectivity / G: Roughness / B: Glow )", 2D) = "black" { }
[DecoHeaderBox(SPECULAR)] _SpecX_Low ("Specular Intensity (R)", Range(0, 10)) = 2
[PowerSlider(10.0)] _Roughness_Low ("Roughness", Range(0.03, 10)) = 0.5
[DecoHeaderBox(LIGHT)] _LightProbeIntensity ("LightProbe Intensity", Range(0, 2)) = 1
[HeaderBox(Default Options, 5, 10)] ____box_RQ ("", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 7838
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  highp vec3 norm_7;
  norm_7 = tmpvar_1;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((norm_7 * tmpvar_8));
  worldNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_10;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_3;
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  mediump vec3 tmpvar_17;
  tmpvar_17 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_13 = tmpvar_17;
  tmpvar_5 = ((tmpvar_17 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  highp vec3 norm_7;
  norm_7 = tmpvar_1;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((norm_7 * tmpvar_8));
  worldNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_10;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_3;
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  mediump vec3 tmpvar_17;
  tmpvar_17 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_13 = tmpvar_17;
  tmpvar_5 = ((tmpvar_17 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  highp vec3 norm_7;
  norm_7 = tmpvar_1;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((norm_7 * tmpvar_8));
  worldNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_10;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_3;
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  mediump vec3 tmpvar_17;
  tmpvar_17 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_13 = tmpvar_17;
  tmpvar_5 = ((tmpvar_17 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "vulkan hw_tier00 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 403
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %110 %112 %115 %160 %249 %260 %383 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 RelaxedPrecision 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %110 RelaxedPrecision 
                                                      OpDecorate %110 Location 110 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %112 Location 112 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %115 Location 115 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %125 RelaxedPrecision 
                                                      OpDecorate %131 RelaxedPrecision 
                                                      OpDecorate %152 RelaxedPrecision 
                                                      OpDecorate %157 RelaxedPrecision 
                                                      OpDecorate %160 RelaxedPrecision 
                                                      OpDecorate %160 Location 160 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %162 RelaxedPrecision 
                                                      OpDecorate %165 RelaxedPrecision 
                                                      OpDecorate %179 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %194 RelaxedPrecision 
                                                      OpDecorate %195 RelaxedPrecision 
                                                      OpDecorate %197 RelaxedPrecision 
                                                      OpDecorate %198 RelaxedPrecision 
                                                      OpDecorate %200 RelaxedPrecision 
                                                      OpDecorate %201 RelaxedPrecision 
                                                      OpDecorate %203 RelaxedPrecision 
                                                      OpDecorate %204 RelaxedPrecision 
                                                      OpDecorate %205 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %209 RelaxedPrecision 
                                                      OpDecorate %210 RelaxedPrecision 
                                                      OpDecorate %211 RelaxedPrecision 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate %213 RelaxedPrecision 
                                                      OpDecorate %214 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %216 RelaxedPrecision 
                                                      OpDecorate %217 RelaxedPrecision 
                                                      OpDecorate %218 RelaxedPrecision 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %220 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %233 RelaxedPrecision 
                                                      OpDecorate %234 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %252 RelaxedPrecision 
                                                      OpDecorate %257 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %260 Location 260 
                                                      OpDecorate %261 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %263 RelaxedPrecision 
                                                      OpDecorate %264 RelaxedPrecision 
                                                      OpDecorate %277 RelaxedPrecision 
                                                      OpDecorate %278 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %289 RelaxedPrecision 
                                                      OpDecorate %290 RelaxedPrecision 
                                                      OpDecorate %291 RelaxedPrecision 
                                                      OpDecorate %295 RelaxedPrecision 
                                                      OpDecorate %296 RelaxedPrecision 
                                                      OpDecorate %297 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %303 RelaxedPrecision 
                                                      OpDecorate %307 RelaxedPrecision 
                                                      OpDecorate %308 RelaxedPrecision 
                                                      OpDecorate %309 RelaxedPrecision 
                                                      OpDecorate %310 RelaxedPrecision 
                                                      OpDecorate %311 RelaxedPrecision 
                                                      OpDecorate %312 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %317 RelaxedPrecision 
                                                      OpDecorate %322 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %338 RelaxedPrecision 
                                                      OpDecorate %372 RelaxedPrecision 
                                                      OpDecorate %374 RelaxedPrecision 
                                                      OpDecorate %376 RelaxedPrecision 
                                                      OpDecorate %383 RelaxedPrecision 
                                                      OpDecorate %383 Location 383 
                                                      OpDecorate %384 RelaxedPrecision 
                                                      OpDecorate %387 RelaxedPrecision 
                                                      OpDecorate %389 RelaxedPrecision 
                                                      OpDecorate %391 RelaxedPrecision 
                                                      OpDecorate %392 RelaxedPrecision 
                                                      OpDecorate %393 RelaxedPrecision 
                                                      OpDecorate %394 RelaxedPrecision 
                                                      OpDecorate %395 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %397 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 8 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 10 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypeVector %6 2 
                                             %109 = OpTypePointer Output %108 
                               Output f32_2* %110 = OpVariable Output 
                                             %111 = OpTypePointer Input %108 
                                Input f32_2* %112 = OpVariable Input 
                                             %114 = OpTypePointer Input %14 
                                Input f32_3* %115 = OpVariable Input 
                                         i32 %117 = OpConstant 9 
                                         u32 %122 = OpConstant 0 
                                             %123 = OpTypePointer Private %6 
                                         u32 %136 = OpConstant 2 
                                Private f32* %138 = OpVariable Private 
                                             %151 = OpTypePointer Private %14 
                              Private f32_3* %152 = OpVariable Private 
                                         i32 %155 = OpConstant 11 
                               Output f32_2* %160 = OpVariable Output 
                                         f32 %163 = OpConstant 3.67402E-40 
                                       f32_2 %164 = OpConstantComposite %163 %163 
                                Private f32* %188 = OpVariable Private 
                                         f32 %196 = OpConstant 3.67402E-40 
                                         f32 %199 = OpConstant 3.67402E-40 
                                         f32 %202 = OpConstant 3.67402E-40 
                              Private f32_3* %204 = OpVariable Private 
                                         i32 %207 = OpConstant 15 
                                Private f32* %236 = OpVariable Private 
                                         i32 %237 = OpConstant 13 
                                             %238 = OpTypePointer Uniform %6 
                                         f32 %241 = OpConstant 3.67402E-40 
                                             %248 = OpTypePointer Output %6 
                                 Output f32* %249 = OpVariable Output 
                                         i32 %253 = OpConstant 16 
                                             %254 = OpTypePointer Uniform %20 
                                             %259 = OpTypePointer Output %14 
                               Output f32_3* %260 = OpVariable Output 
                              Private f32_4* %281 = OpVariable Private 
                                         i32 %287 = OpConstant 4 
                                         i32 %293 = OpConstant 5 
                                         i32 %299 = OpConstant 6 
                                         i32 %305 = OpConstant 7 
                                         u32 %314 = OpConstant 3 
                                       f32_3 %335 = OpConstantComposite %163 %163 %163 
                                         f32 %343 = OpConstant 3.67402E-40 
                                       f32_3 %344 = OpConstantComposite %343 %343 %343 
                                         f32 %355 = OpConstant 3.67402E-40 
                                       f32_3 %356 = OpConstantComposite %355 %355 %355 
                                         f32 %358 = OpConstant 3.67402E-40 
                                       f32_3 %359 = OpConstantComposite %358 %358 %358 
                                         i32 %370 = OpConstant 12 
                               Output f32_3* %383 = OpVariable Output 
                                         i32 %385 = OpConstant 14 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                       f32_2 %113 = OpLoad %112 
                                                      OpStore %110 %113 
                                       f32_3 %116 = OpLoad %115 
                              Uniform f32_4* %118 = OpAccessChain %23 %117 %30 
                                       f32_4 %119 = OpLoad %118 
                                       f32_3 %120 = OpVectorShuffle %119 %119 0 1 2 
                                         f32 %121 = OpDot %116 %120 
                                Private f32* %124 = OpAccessChain %46 %122 
                                                      OpStore %124 %121 
                                       f32_3 %125 = OpLoad %115 
                              Uniform f32_4* %126 = OpAccessChain %23 %117 %25 
                                       f32_4 %127 = OpLoad %126 
                                       f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
                                         f32 %129 = OpDot %125 %128 
                                Private f32* %130 = OpAccessChain %46 %100 
                                                      OpStore %130 %129 
                                       f32_3 %131 = OpLoad %115 
                              Uniform f32_4* %132 = OpAccessChain %23 %117 %38 
                                       f32_4 %133 = OpLoad %132 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %131 %134 
                                Private f32* %137 = OpAccessChain %46 %136 
                                                      OpStore %137 %135 
                                       f32_4 %139 = OpLoad %46 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_4 %141 = OpLoad %46 
                                       f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
                                         f32 %143 = OpDot %140 %142 
                                                      OpStore %138 %143 
                                         f32 %144 = OpLoad %138 
                                         f32 %145 = OpExtInst %1 32 %144 
                                                      OpStore %138 %145 
                                         f32 %146 = OpLoad %138 
                                       f32_4 %147 = OpCompositeConstruct %146 %146 %146 %146 
                                       f32_4 %148 = OpLoad %46 
                                       f32_4 %149 = OpVectorShuffle %148 %148 0 1 2 2 
                                       f32_4 %150 = OpFMul %147 %149 
                                                      OpStore %46 %150 
                                       f32_4 %153 = OpLoad %46 
                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
                              Uniform f32_3* %156 = OpAccessChain %23 %155 
                                       f32_3 %157 = OpLoad %156 
                                         f32 %158 = OpDot %154 %157 
                                Private f32* %159 = OpAccessChain %152 %122 
                                                      OpStore %159 %158 
                                       f32_3 %161 = OpLoad %152 
                                       f32_2 %162 = OpVectorShuffle %161 %161 0 0 
                                       f32_2 %165 = OpExtInst %1 40 %162 %164 
                                                      OpStore %160 %165 
                                       f32_4 %166 = OpLoad %9 
                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
                                       f32_4 %168 = OpLoad %9 
                                       f32_3 %169 = OpVectorShuffle %168 %168 0 1 2 
                                         f32 %170 = OpDot %167 %169 
                                                      OpStore %138 %170 
                                         f32 %171 = OpLoad %138 
                                         f32 %172 = OpExtInst %1 32 %171 
                                                      OpStore %138 %172 
                                       f32_4 %173 = OpLoad %9 
                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
                                         f32 %175 = OpLoad %138 
                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
                                       f32_3 %177 = OpFMul %174 %176 
                              Uniform f32_3* %178 = OpAccessChain %23 %155 
                                       f32_3 %179 = OpLoad %178 
                                       f32_3 %180 = OpFAdd %177 %179 
                                                      OpStore %152 %180 
                                         f32 %181 = OpLoad %138 
                                       f32_3 %182 = OpCompositeConstruct %181 %181 %181 
                                       f32_4 %183 = OpLoad %9 
                                       f32_3 %184 = OpVectorShuffle %183 %183 0 1 2 
                                       f32_3 %185 = OpFMul %182 %184 
                                       f32_4 %186 = OpLoad %9 
                                       f32_4 %187 = OpVectorShuffle %186 %185 4 5 6 3 
                                                      OpStore %9 %187 
                                       f32_4 %189 = OpLoad %9 
                                       f32_3 %190 = OpVectorShuffle %189 %189 0 1 2 
                                       f32_4 %191 = OpLoad %46 
                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 3 
                                         f32 %193 = OpDot %190 %192 
                                                      OpStore %188 %193 
                                         f32 %194 = OpLoad %188 
                                         f32 %195 = OpFNegate %194 
                                         f32 %197 = OpFAdd %195 %196 
                                                      OpStore %188 %197 
                                         f32 %198 = OpLoad %188 
                                         f32 %200 = OpFMul %198 %199 
                                                      OpStore %188 %200 
                                         f32 %201 = OpLoad %188 
                                         f32 %203 = OpExtInst %1 43 %201 %163 %202 
                                                      OpStore %188 %203 
                                         f32 %205 = OpLoad %188 
                                       f32_3 %206 = OpCompositeConstruct %205 %205 %205 
                              Uniform f32_3* %208 = OpAccessChain %23 %207 
                                       f32_3 %209 = OpLoad %208 
                                       f32_3 %210 = OpFMul %206 %209 
                                                      OpStore %204 %210 
                                       f32_3 %211 = OpLoad %204 
                                       f32_3 %212 = OpLoad %204 
                                       f32_3 %213 = OpFAdd %211 %212 
                                                      OpStore %204 %213 
                                       f32_3 %214 = OpLoad %152 
                                       f32_3 %215 = OpLoad %152 
                                         f32 %216 = OpDot %214 %215 
                                                      OpStore %188 %216 
                                         f32 %217 = OpLoad %188 
                                         f32 %218 = OpExtInst %1 32 %217 
                                                      OpStore %188 %218 
                                         f32 %219 = OpLoad %188 
                                       f32_3 %220 = OpCompositeConstruct %219 %219 %219 
                                       f32_3 %221 = OpLoad %152 
                                       f32_3 %222 = OpFMul %220 %221 
                                                      OpStore %152 %222 
                                       f32_4 %223 = OpLoad %46 
                                       f32_3 %224 = OpVectorShuffle %223 %223 0 1 2 
                                       f32_3 %225 = OpLoad %152 
                                         f32 %226 = OpDot %224 %225 
                                Private f32* %227 = OpAccessChain %152 %122 
                                                      OpStore %227 %226 
                                Private f32* %228 = OpAccessChain %152 %122 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpExtInst %1 40 %229 %163 
                                Private f32* %231 = OpAccessChain %152 %122 
                                                      OpStore %231 %230 
                                Private f32* %232 = OpAccessChain %152 %122 
                                         f32 %233 = OpLoad %232 
                                         f32 %234 = OpExtInst %1 30 %233 
                                Private f32* %235 = OpAccessChain %152 %122 
                                                      OpStore %235 %234 
                                Uniform f32* %239 = OpAccessChain %23 %237 
                                         f32 %240 = OpLoad %239 
                                         f32 %242 = OpFMul %240 %241 
                                                      OpStore %236 %242 
                                Private f32* %243 = OpAccessChain %152 %122 
                                         f32 %244 = OpLoad %243 
                                         f32 %245 = OpLoad %236 
                                         f32 %246 = OpFMul %244 %245 
                                Private f32* %247 = OpAccessChain %152 %122 
                                                      OpStore %247 %246 
                                Private f32* %250 = OpAccessChain %152 %122 
                                         f32 %251 = OpLoad %250 
                                         f32 %252 = OpExtInst %1 29 %251 
                                                      OpStore %249 %252 
                                Uniform i32* %255 = OpAccessChain %23 %253 
                                         i32 %256 = OpLoad %255 
                                         f32 %257 = OpConvertSToF %256 
                                Private f32* %258 = OpAccessChain %152 %122 
                                                      OpStore %258 %257 
                                       f32_3 %261 = OpLoad %152 
                                       f32_3 %262 = OpVectorShuffle %261 %261 0 0 0 
                                       f32_3 %263 = OpLoad %204 
                                       f32_3 %264 = OpFMul %262 %263 
                                                      OpStore %260 %264 
                                Private f32* %265 = OpAccessChain %46 %100 
                                         f32 %266 = OpLoad %265 
                                Private f32* %267 = OpAccessChain %46 %100 
                                         f32 %268 = OpLoad %267 
                                         f32 %269 = OpFMul %266 %268 
                                Private f32* %270 = OpAccessChain %152 %122 
                                                      OpStore %270 %269 
                                Private f32* %271 = OpAccessChain %46 %122 
                                         f32 %272 = OpLoad %271 
                                Private f32* %273 = OpAccessChain %46 %122 
                                         f32 %274 = OpLoad %273 
                                         f32 %275 = OpFMul %272 %274 
                                Private f32* %276 = OpAccessChain %152 %122 
                                         f32 %277 = OpLoad %276 
                                         f32 %278 = OpFNegate %277 
                                         f32 %279 = OpFAdd %275 %278 
                                Private f32* %280 = OpAccessChain %152 %122 
                                                      OpStore %280 %279 
                                       f32_4 %282 = OpLoad %46 
                                       f32_4 %283 = OpVectorShuffle %282 %282 1 2 3 0 
                                       f32_4 %284 = OpLoad %46 
                                       f32_4 %285 = OpVectorShuffle %284 %284 0 1 3 2 
                                       f32_4 %286 = OpFMul %283 %285 
                                                      OpStore %281 %286 
                              Uniform f32_4* %288 = OpAccessChain %23 %287 
                                       f32_4 %289 = OpLoad %288 
                                       f32_4 %290 = OpLoad %281 
                                         f32 %291 = OpDot %289 %290 
                                Private f32* %292 = OpAccessChain %204 %122 
                                                      OpStore %292 %291 
                              Uniform f32_4* %294 = OpAccessChain %23 %293 
                                       f32_4 %295 = OpLoad %294 
                                       f32_4 %296 = OpLoad %281 
                                         f32 %297 = OpDot %295 %296 
                                Private f32* %298 = OpAccessChain %204 %100 
                                                      OpStore %298 %297 
                              Uniform f32_4* %300 = OpAccessChain %23 %299 
                                       f32_4 %301 = OpLoad %300 
                                       f32_4 %302 = OpLoad %281 
                                         f32 %303 = OpDot %301 %302 
                                Private f32* %304 = OpAccessChain %204 %136 
                                                      OpStore %304 %303 
                              Uniform f32_4* %306 = OpAccessChain %23 %305 
                                       f32_4 %307 = OpLoad %306 
                                       f32_3 %308 = OpVectorShuffle %307 %307 0 1 2 
                                       f32_3 %309 = OpLoad %152 
                                       f32_3 %310 = OpVectorShuffle %309 %309 0 0 0 
                                       f32_3 %311 = OpFMul %308 %310 
                                       f32_3 %312 = OpLoad %204 
                                       f32_3 %313 = OpFAdd %311 %312 
                                                      OpStore %152 %313 
                                Private f32* %315 = OpAccessChain %46 %314 
                                                      OpStore %315 %202 
                              Uniform f32_4* %316 = OpAccessChain %23 %25 
                                       f32_4 %317 = OpLoad %316 
                                       f32_4 %318 = OpLoad %46 
                                         f32 %319 = OpDot %317 %318 
                                Private f32* %320 = OpAccessChain %204 %122 
                                                      OpStore %320 %319 
                              Uniform f32_4* %321 = OpAccessChain %23 %38 
                                       f32_4 %322 = OpLoad %321 
                                       f32_4 %323 = OpLoad %46 
                                         f32 %324 = OpDot %322 %323 
                                Private f32* %325 = OpAccessChain %204 %100 
                                                      OpStore %325 %324 
                              Uniform f32_4* %326 = OpAccessChain %23 %48 
                                       f32_4 %327 = OpLoad %326 
                                       f32_4 %328 = OpLoad %46 
                                         f32 %329 = OpDot %327 %328 
                                Private f32* %330 = OpAccessChain %204 %136 
                                                      OpStore %330 %329 
                                       f32_3 %331 = OpLoad %152 
                                       f32_3 %332 = OpLoad %204 
                                       f32_3 %333 = OpFAdd %331 %332 
                                                      OpStore %152 %333 
                                       f32_3 %334 = OpLoad %152 
                                       f32_3 %336 = OpExtInst %1 40 %334 %335 
                                                      OpStore %152 %336 
                                       f32_3 %337 = OpLoad %152 
                                       f32_3 %338 = OpExtInst %1 30 %337 
                                       f32_4 %339 = OpLoad %46 
                                       f32_4 %340 = OpVectorShuffle %339 %338 4 5 6 3 
                                                      OpStore %46 %340 
                                       f32_4 %341 = OpLoad %46 
                                       f32_3 %342 = OpVectorShuffle %341 %341 0 1 2 
                                       f32_3 %345 = OpFMul %342 %344 
                                       f32_4 %346 = OpLoad %46 
                                       f32_4 %347 = OpVectorShuffle %346 %345 4 5 6 3 
                                                      OpStore %46 %347 
                                       f32_4 %348 = OpLoad %46 
                                       f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                       f32_3 %350 = OpExtInst %1 29 %349 
                                       f32_4 %351 = OpLoad %46 
                                       f32_4 %352 = OpVectorShuffle %351 %350 4 5 6 3 
                                                      OpStore %46 %352 
                                       f32_4 %353 = OpLoad %46 
                                       f32_3 %354 = OpVectorShuffle %353 %353 0 1 2 
                                       f32_3 %357 = OpFMul %354 %356 
                                       f32_3 %360 = OpFAdd %357 %359 
                                       f32_4 %361 = OpLoad %46 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 6 3 
                                                      OpStore %46 %362 
                                       f32_4 %363 = OpLoad %46 
                                       f32_3 %364 = OpVectorShuffle %363 %363 0 1 2 
                                       f32_3 %365 = OpExtInst %1 40 %364 %335 
                                       f32_4 %366 = OpLoad %46 
                                       f32_4 %367 = OpVectorShuffle %366 %365 4 5 6 3 
                                                      OpStore %46 %367 
                                       f32_4 %368 = OpLoad %46 
                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                Uniform f32* %371 = OpAccessChain %23 %370 
                                         f32 %372 = OpLoad %371 
                                Uniform f32* %373 = OpAccessChain %23 %370 
                                         f32 %374 = OpLoad %373 
                                Uniform f32* %375 = OpAccessChain %23 %370 
                                         f32 %376 = OpLoad %375 
                                       f32_3 %377 = OpCompositeConstruct %372 %374 %376 
                                         f32 %378 = OpCompositeExtract %377 0 
                                         f32 %379 = OpCompositeExtract %377 1 
                                         f32 %380 = OpCompositeExtract %377 2 
                                       f32_3 %381 = OpCompositeConstruct %378 %379 %380 
                                       f32_3 %382 = OpFMul %369 %381 
                                                      OpStore %152 %382 
                                       f32_3 %384 = OpLoad %152 
                                Uniform f32* %386 = OpAccessChain %23 %385 
                                         f32 %387 = OpLoad %386 
                                Uniform f32* %388 = OpAccessChain %23 %385 
                                         f32 %389 = OpLoad %388 
                                Uniform f32* %390 = OpAccessChain %23 %385 
                                         f32 %391 = OpLoad %390 
                                       f32_3 %392 = OpCompositeConstruct %387 %389 %391 
                                         f32 %393 = OpCompositeExtract %392 0 
                                         f32 %394 = OpCompositeExtract %392 1 
                                         f32 %395 = OpCompositeExtract %392 2 
                                       f32_3 %396 = OpCompositeConstruct %393 %394 %395 
                                       f32_3 %397 = OpFMul %384 %396 
                                                      OpStore %383 %397 
                                 Output f32* %398 = OpAccessChain %104 %30 %100 
                                         f32 %399 = OpLoad %398 
                                         f32 %400 = OpFNegate %399 
                                 Output f32* %401 = OpAccessChain %104 %30 %100 
                                                      OpStore %401 %400 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 105
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %89 %93 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %89 Location 89 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %93 Location 93 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 3 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 2 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 0 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 1 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                              %88 = OpTypePointer Output %19 
                                Output f32_4* %89 = OpVariable Output 
                                 Input f32_3* %93 = OpVariable Input 
                                          i32 %98 = OpConstant 4 
                                         u32 %101 = OpConstant 3 
                                             %102 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %90 = OpLoad %26 
                                        f32_3 %91 = OpLoad %66 
                                        f32_3 %92 = OpFMul %90 %91 
                                        f32_3 %94 = OpLoad %93 
                                        f32_3 %95 = OpFAdd %92 %94 
                                        f32_4 %96 = OpLoad %89 
                                        f32_4 %97 = OpVectorShuffle %96 %95 4 5 6 3 
                                                      OpStore %89 %97 
                                 Uniform f32* %99 = OpAccessChain %32 %98 
                                         f32 %100 = OpLoad %99 
                                 Output f32* %103 = OpAccessChain %89 %101 
                                                      OpStore %103 %100 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "vulkan hw_tier01 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 403
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %110 %112 %115 %160 %249 %260 %383 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 RelaxedPrecision 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %110 RelaxedPrecision 
                                                      OpDecorate %110 Location 110 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %112 Location 112 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %115 Location 115 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %125 RelaxedPrecision 
                                                      OpDecorate %131 RelaxedPrecision 
                                                      OpDecorate %152 RelaxedPrecision 
                                                      OpDecorate %157 RelaxedPrecision 
                                                      OpDecorate %160 RelaxedPrecision 
                                                      OpDecorate %160 Location 160 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %162 RelaxedPrecision 
                                                      OpDecorate %165 RelaxedPrecision 
                                                      OpDecorate %179 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %194 RelaxedPrecision 
                                                      OpDecorate %195 RelaxedPrecision 
                                                      OpDecorate %197 RelaxedPrecision 
                                                      OpDecorate %198 RelaxedPrecision 
                                                      OpDecorate %200 RelaxedPrecision 
                                                      OpDecorate %201 RelaxedPrecision 
                                                      OpDecorate %203 RelaxedPrecision 
                                                      OpDecorate %204 RelaxedPrecision 
                                                      OpDecorate %205 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %209 RelaxedPrecision 
                                                      OpDecorate %210 RelaxedPrecision 
                                                      OpDecorate %211 RelaxedPrecision 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate %213 RelaxedPrecision 
                                                      OpDecorate %214 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %216 RelaxedPrecision 
                                                      OpDecorate %217 RelaxedPrecision 
                                                      OpDecorate %218 RelaxedPrecision 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %220 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %233 RelaxedPrecision 
                                                      OpDecorate %234 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %252 RelaxedPrecision 
                                                      OpDecorate %257 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %260 Location 260 
                                                      OpDecorate %261 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %263 RelaxedPrecision 
                                                      OpDecorate %264 RelaxedPrecision 
                                                      OpDecorate %277 RelaxedPrecision 
                                                      OpDecorate %278 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %289 RelaxedPrecision 
                                                      OpDecorate %290 RelaxedPrecision 
                                                      OpDecorate %291 RelaxedPrecision 
                                                      OpDecorate %295 RelaxedPrecision 
                                                      OpDecorate %296 RelaxedPrecision 
                                                      OpDecorate %297 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %303 RelaxedPrecision 
                                                      OpDecorate %307 RelaxedPrecision 
                                                      OpDecorate %308 RelaxedPrecision 
                                                      OpDecorate %309 RelaxedPrecision 
                                                      OpDecorate %310 RelaxedPrecision 
                                                      OpDecorate %311 RelaxedPrecision 
                                                      OpDecorate %312 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %317 RelaxedPrecision 
                                                      OpDecorate %322 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %338 RelaxedPrecision 
                                                      OpDecorate %372 RelaxedPrecision 
                                                      OpDecorate %374 RelaxedPrecision 
                                                      OpDecorate %376 RelaxedPrecision 
                                                      OpDecorate %383 RelaxedPrecision 
                                                      OpDecorate %383 Location 383 
                                                      OpDecorate %384 RelaxedPrecision 
                                                      OpDecorate %387 RelaxedPrecision 
                                                      OpDecorate %389 RelaxedPrecision 
                                                      OpDecorate %391 RelaxedPrecision 
                                                      OpDecorate %392 RelaxedPrecision 
                                                      OpDecorate %393 RelaxedPrecision 
                                                      OpDecorate %394 RelaxedPrecision 
                                                      OpDecorate %395 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %397 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 8 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 10 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypeVector %6 2 
                                             %109 = OpTypePointer Output %108 
                               Output f32_2* %110 = OpVariable Output 
                                             %111 = OpTypePointer Input %108 
                                Input f32_2* %112 = OpVariable Input 
                                             %114 = OpTypePointer Input %14 
                                Input f32_3* %115 = OpVariable Input 
                                         i32 %117 = OpConstant 9 
                                         u32 %122 = OpConstant 0 
                                             %123 = OpTypePointer Private %6 
                                         u32 %136 = OpConstant 2 
                                Private f32* %138 = OpVariable Private 
                                             %151 = OpTypePointer Private %14 
                              Private f32_3* %152 = OpVariable Private 
                                         i32 %155 = OpConstant 11 
                               Output f32_2* %160 = OpVariable Output 
                                         f32 %163 = OpConstant 3.67402E-40 
                                       f32_2 %164 = OpConstantComposite %163 %163 
                                Private f32* %188 = OpVariable Private 
                                         f32 %196 = OpConstant 3.67402E-40 
                                         f32 %199 = OpConstant 3.67402E-40 
                                         f32 %202 = OpConstant 3.67402E-40 
                              Private f32_3* %204 = OpVariable Private 
                                         i32 %207 = OpConstant 15 
                                Private f32* %236 = OpVariable Private 
                                         i32 %237 = OpConstant 13 
                                             %238 = OpTypePointer Uniform %6 
                                         f32 %241 = OpConstant 3.67402E-40 
                                             %248 = OpTypePointer Output %6 
                                 Output f32* %249 = OpVariable Output 
                                         i32 %253 = OpConstant 16 
                                             %254 = OpTypePointer Uniform %20 
                                             %259 = OpTypePointer Output %14 
                               Output f32_3* %260 = OpVariable Output 
                              Private f32_4* %281 = OpVariable Private 
                                         i32 %287 = OpConstant 4 
                                         i32 %293 = OpConstant 5 
                                         i32 %299 = OpConstant 6 
                                         i32 %305 = OpConstant 7 
                                         u32 %314 = OpConstant 3 
                                       f32_3 %335 = OpConstantComposite %163 %163 %163 
                                         f32 %343 = OpConstant 3.67402E-40 
                                       f32_3 %344 = OpConstantComposite %343 %343 %343 
                                         f32 %355 = OpConstant 3.67402E-40 
                                       f32_3 %356 = OpConstantComposite %355 %355 %355 
                                         f32 %358 = OpConstant 3.67402E-40 
                                       f32_3 %359 = OpConstantComposite %358 %358 %358 
                                         i32 %370 = OpConstant 12 
                               Output f32_3* %383 = OpVariable Output 
                                         i32 %385 = OpConstant 14 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                       f32_2 %113 = OpLoad %112 
                                                      OpStore %110 %113 
                                       f32_3 %116 = OpLoad %115 
                              Uniform f32_4* %118 = OpAccessChain %23 %117 %30 
                                       f32_4 %119 = OpLoad %118 
                                       f32_3 %120 = OpVectorShuffle %119 %119 0 1 2 
                                         f32 %121 = OpDot %116 %120 
                                Private f32* %124 = OpAccessChain %46 %122 
                                                      OpStore %124 %121 
                                       f32_3 %125 = OpLoad %115 
                              Uniform f32_4* %126 = OpAccessChain %23 %117 %25 
                                       f32_4 %127 = OpLoad %126 
                                       f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
                                         f32 %129 = OpDot %125 %128 
                                Private f32* %130 = OpAccessChain %46 %100 
                                                      OpStore %130 %129 
                                       f32_3 %131 = OpLoad %115 
                              Uniform f32_4* %132 = OpAccessChain %23 %117 %38 
                                       f32_4 %133 = OpLoad %132 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %131 %134 
                                Private f32* %137 = OpAccessChain %46 %136 
                                                      OpStore %137 %135 
                                       f32_4 %139 = OpLoad %46 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_4 %141 = OpLoad %46 
                                       f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
                                         f32 %143 = OpDot %140 %142 
                                                      OpStore %138 %143 
                                         f32 %144 = OpLoad %138 
                                         f32 %145 = OpExtInst %1 32 %144 
                                                      OpStore %138 %145 
                                         f32 %146 = OpLoad %138 
                                       f32_4 %147 = OpCompositeConstruct %146 %146 %146 %146 
                                       f32_4 %148 = OpLoad %46 
                                       f32_4 %149 = OpVectorShuffle %148 %148 0 1 2 2 
                                       f32_4 %150 = OpFMul %147 %149 
                                                      OpStore %46 %150 
                                       f32_4 %153 = OpLoad %46 
                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
                              Uniform f32_3* %156 = OpAccessChain %23 %155 
                                       f32_3 %157 = OpLoad %156 
                                         f32 %158 = OpDot %154 %157 
                                Private f32* %159 = OpAccessChain %152 %122 
                                                      OpStore %159 %158 
                                       f32_3 %161 = OpLoad %152 
                                       f32_2 %162 = OpVectorShuffle %161 %161 0 0 
                                       f32_2 %165 = OpExtInst %1 40 %162 %164 
                                                      OpStore %160 %165 
                                       f32_4 %166 = OpLoad %9 
                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
                                       f32_4 %168 = OpLoad %9 
                                       f32_3 %169 = OpVectorShuffle %168 %168 0 1 2 
                                         f32 %170 = OpDot %167 %169 
                                                      OpStore %138 %170 
                                         f32 %171 = OpLoad %138 
                                         f32 %172 = OpExtInst %1 32 %171 
                                                      OpStore %138 %172 
                                       f32_4 %173 = OpLoad %9 
                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
                                         f32 %175 = OpLoad %138 
                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
                                       f32_3 %177 = OpFMul %174 %176 
                              Uniform f32_3* %178 = OpAccessChain %23 %155 
                                       f32_3 %179 = OpLoad %178 
                                       f32_3 %180 = OpFAdd %177 %179 
                                                      OpStore %152 %180 
                                         f32 %181 = OpLoad %138 
                                       f32_3 %182 = OpCompositeConstruct %181 %181 %181 
                                       f32_4 %183 = OpLoad %9 
                                       f32_3 %184 = OpVectorShuffle %183 %183 0 1 2 
                                       f32_3 %185 = OpFMul %182 %184 
                                       f32_4 %186 = OpLoad %9 
                                       f32_4 %187 = OpVectorShuffle %186 %185 4 5 6 3 
                                                      OpStore %9 %187 
                                       f32_4 %189 = OpLoad %9 
                                       f32_3 %190 = OpVectorShuffle %189 %189 0 1 2 
                                       f32_4 %191 = OpLoad %46 
                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 3 
                                         f32 %193 = OpDot %190 %192 
                                                      OpStore %188 %193 
                                         f32 %194 = OpLoad %188 
                                         f32 %195 = OpFNegate %194 
                                         f32 %197 = OpFAdd %195 %196 
                                                      OpStore %188 %197 
                                         f32 %198 = OpLoad %188 
                                         f32 %200 = OpFMul %198 %199 
                                                      OpStore %188 %200 
                                         f32 %201 = OpLoad %188 
                                         f32 %203 = OpExtInst %1 43 %201 %163 %202 
                                                      OpStore %188 %203 
                                         f32 %205 = OpLoad %188 
                                       f32_3 %206 = OpCompositeConstruct %205 %205 %205 
                              Uniform f32_3* %208 = OpAccessChain %23 %207 
                                       f32_3 %209 = OpLoad %208 
                                       f32_3 %210 = OpFMul %206 %209 
                                                      OpStore %204 %210 
                                       f32_3 %211 = OpLoad %204 
                                       f32_3 %212 = OpLoad %204 
                                       f32_3 %213 = OpFAdd %211 %212 
                                                      OpStore %204 %213 
                                       f32_3 %214 = OpLoad %152 
                                       f32_3 %215 = OpLoad %152 
                                         f32 %216 = OpDot %214 %215 
                                                      OpStore %188 %216 
                                         f32 %217 = OpLoad %188 
                                         f32 %218 = OpExtInst %1 32 %217 
                                                      OpStore %188 %218 
                                         f32 %219 = OpLoad %188 
                                       f32_3 %220 = OpCompositeConstruct %219 %219 %219 
                                       f32_3 %221 = OpLoad %152 
                                       f32_3 %222 = OpFMul %220 %221 
                                                      OpStore %152 %222 
                                       f32_4 %223 = OpLoad %46 
                                       f32_3 %224 = OpVectorShuffle %223 %223 0 1 2 
                                       f32_3 %225 = OpLoad %152 
                                         f32 %226 = OpDot %224 %225 
                                Private f32* %227 = OpAccessChain %152 %122 
                                                      OpStore %227 %226 
                                Private f32* %228 = OpAccessChain %152 %122 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpExtInst %1 40 %229 %163 
                                Private f32* %231 = OpAccessChain %152 %122 
                                                      OpStore %231 %230 
                                Private f32* %232 = OpAccessChain %152 %122 
                                         f32 %233 = OpLoad %232 
                                         f32 %234 = OpExtInst %1 30 %233 
                                Private f32* %235 = OpAccessChain %152 %122 
                                                      OpStore %235 %234 
                                Uniform f32* %239 = OpAccessChain %23 %237 
                                         f32 %240 = OpLoad %239 
                                         f32 %242 = OpFMul %240 %241 
                                                      OpStore %236 %242 
                                Private f32* %243 = OpAccessChain %152 %122 
                                         f32 %244 = OpLoad %243 
                                         f32 %245 = OpLoad %236 
                                         f32 %246 = OpFMul %244 %245 
                                Private f32* %247 = OpAccessChain %152 %122 
                                                      OpStore %247 %246 
                                Private f32* %250 = OpAccessChain %152 %122 
                                         f32 %251 = OpLoad %250 
                                         f32 %252 = OpExtInst %1 29 %251 
                                                      OpStore %249 %252 
                                Uniform i32* %255 = OpAccessChain %23 %253 
                                         i32 %256 = OpLoad %255 
                                         f32 %257 = OpConvertSToF %256 
                                Private f32* %258 = OpAccessChain %152 %122 
                                                      OpStore %258 %257 
                                       f32_3 %261 = OpLoad %152 
                                       f32_3 %262 = OpVectorShuffle %261 %261 0 0 0 
                                       f32_3 %263 = OpLoad %204 
                                       f32_3 %264 = OpFMul %262 %263 
                                                      OpStore %260 %264 
                                Private f32* %265 = OpAccessChain %46 %100 
                                         f32 %266 = OpLoad %265 
                                Private f32* %267 = OpAccessChain %46 %100 
                                         f32 %268 = OpLoad %267 
                                         f32 %269 = OpFMul %266 %268 
                                Private f32* %270 = OpAccessChain %152 %122 
                                                      OpStore %270 %269 
                                Private f32* %271 = OpAccessChain %46 %122 
                                         f32 %272 = OpLoad %271 
                                Private f32* %273 = OpAccessChain %46 %122 
                                         f32 %274 = OpLoad %273 
                                         f32 %275 = OpFMul %272 %274 
                                Private f32* %276 = OpAccessChain %152 %122 
                                         f32 %277 = OpLoad %276 
                                         f32 %278 = OpFNegate %277 
                                         f32 %279 = OpFAdd %275 %278 
                                Private f32* %280 = OpAccessChain %152 %122 
                                                      OpStore %280 %279 
                                       f32_4 %282 = OpLoad %46 
                                       f32_4 %283 = OpVectorShuffle %282 %282 1 2 3 0 
                                       f32_4 %284 = OpLoad %46 
                                       f32_4 %285 = OpVectorShuffle %284 %284 0 1 3 2 
                                       f32_4 %286 = OpFMul %283 %285 
                                                      OpStore %281 %286 
                              Uniform f32_4* %288 = OpAccessChain %23 %287 
                                       f32_4 %289 = OpLoad %288 
                                       f32_4 %290 = OpLoad %281 
                                         f32 %291 = OpDot %289 %290 
                                Private f32* %292 = OpAccessChain %204 %122 
                                                      OpStore %292 %291 
                              Uniform f32_4* %294 = OpAccessChain %23 %293 
                                       f32_4 %295 = OpLoad %294 
                                       f32_4 %296 = OpLoad %281 
                                         f32 %297 = OpDot %295 %296 
                                Private f32* %298 = OpAccessChain %204 %100 
                                                      OpStore %298 %297 
                              Uniform f32_4* %300 = OpAccessChain %23 %299 
                                       f32_4 %301 = OpLoad %300 
                                       f32_4 %302 = OpLoad %281 
                                         f32 %303 = OpDot %301 %302 
                                Private f32* %304 = OpAccessChain %204 %136 
                                                      OpStore %304 %303 
                              Uniform f32_4* %306 = OpAccessChain %23 %305 
                                       f32_4 %307 = OpLoad %306 
                                       f32_3 %308 = OpVectorShuffle %307 %307 0 1 2 
                                       f32_3 %309 = OpLoad %152 
                                       f32_3 %310 = OpVectorShuffle %309 %309 0 0 0 
                                       f32_3 %311 = OpFMul %308 %310 
                                       f32_3 %312 = OpLoad %204 
                                       f32_3 %313 = OpFAdd %311 %312 
                                                      OpStore %152 %313 
                                Private f32* %315 = OpAccessChain %46 %314 
                                                      OpStore %315 %202 
                              Uniform f32_4* %316 = OpAccessChain %23 %25 
                                       f32_4 %317 = OpLoad %316 
                                       f32_4 %318 = OpLoad %46 
                                         f32 %319 = OpDot %317 %318 
                                Private f32* %320 = OpAccessChain %204 %122 
                                                      OpStore %320 %319 
                              Uniform f32_4* %321 = OpAccessChain %23 %38 
                                       f32_4 %322 = OpLoad %321 
                                       f32_4 %323 = OpLoad %46 
                                         f32 %324 = OpDot %322 %323 
                                Private f32* %325 = OpAccessChain %204 %100 
                                                      OpStore %325 %324 
                              Uniform f32_4* %326 = OpAccessChain %23 %48 
                                       f32_4 %327 = OpLoad %326 
                                       f32_4 %328 = OpLoad %46 
                                         f32 %329 = OpDot %327 %328 
                                Private f32* %330 = OpAccessChain %204 %136 
                                                      OpStore %330 %329 
                                       f32_3 %331 = OpLoad %152 
                                       f32_3 %332 = OpLoad %204 
                                       f32_3 %333 = OpFAdd %331 %332 
                                                      OpStore %152 %333 
                                       f32_3 %334 = OpLoad %152 
                                       f32_3 %336 = OpExtInst %1 40 %334 %335 
                                                      OpStore %152 %336 
                                       f32_3 %337 = OpLoad %152 
                                       f32_3 %338 = OpExtInst %1 30 %337 
                                       f32_4 %339 = OpLoad %46 
                                       f32_4 %340 = OpVectorShuffle %339 %338 4 5 6 3 
                                                      OpStore %46 %340 
                                       f32_4 %341 = OpLoad %46 
                                       f32_3 %342 = OpVectorShuffle %341 %341 0 1 2 
                                       f32_3 %345 = OpFMul %342 %344 
                                       f32_4 %346 = OpLoad %46 
                                       f32_4 %347 = OpVectorShuffle %346 %345 4 5 6 3 
                                                      OpStore %46 %347 
                                       f32_4 %348 = OpLoad %46 
                                       f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                       f32_3 %350 = OpExtInst %1 29 %349 
                                       f32_4 %351 = OpLoad %46 
                                       f32_4 %352 = OpVectorShuffle %351 %350 4 5 6 3 
                                                      OpStore %46 %352 
                                       f32_4 %353 = OpLoad %46 
                                       f32_3 %354 = OpVectorShuffle %353 %353 0 1 2 
                                       f32_3 %357 = OpFMul %354 %356 
                                       f32_3 %360 = OpFAdd %357 %359 
                                       f32_4 %361 = OpLoad %46 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 6 3 
                                                      OpStore %46 %362 
                                       f32_4 %363 = OpLoad %46 
                                       f32_3 %364 = OpVectorShuffle %363 %363 0 1 2 
                                       f32_3 %365 = OpExtInst %1 40 %364 %335 
                                       f32_4 %366 = OpLoad %46 
                                       f32_4 %367 = OpVectorShuffle %366 %365 4 5 6 3 
                                                      OpStore %46 %367 
                                       f32_4 %368 = OpLoad %46 
                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                Uniform f32* %371 = OpAccessChain %23 %370 
                                         f32 %372 = OpLoad %371 
                                Uniform f32* %373 = OpAccessChain %23 %370 
                                         f32 %374 = OpLoad %373 
                                Uniform f32* %375 = OpAccessChain %23 %370 
                                         f32 %376 = OpLoad %375 
                                       f32_3 %377 = OpCompositeConstruct %372 %374 %376 
                                         f32 %378 = OpCompositeExtract %377 0 
                                         f32 %379 = OpCompositeExtract %377 1 
                                         f32 %380 = OpCompositeExtract %377 2 
                                       f32_3 %381 = OpCompositeConstruct %378 %379 %380 
                                       f32_3 %382 = OpFMul %369 %381 
                                                      OpStore %152 %382 
                                       f32_3 %384 = OpLoad %152 
                                Uniform f32* %386 = OpAccessChain %23 %385 
                                         f32 %387 = OpLoad %386 
                                Uniform f32* %388 = OpAccessChain %23 %385 
                                         f32 %389 = OpLoad %388 
                                Uniform f32* %390 = OpAccessChain %23 %385 
                                         f32 %391 = OpLoad %390 
                                       f32_3 %392 = OpCompositeConstruct %387 %389 %391 
                                         f32 %393 = OpCompositeExtract %392 0 
                                         f32 %394 = OpCompositeExtract %392 1 
                                         f32 %395 = OpCompositeExtract %392 2 
                                       f32_3 %396 = OpCompositeConstruct %393 %394 %395 
                                       f32_3 %397 = OpFMul %384 %396 
                                                      OpStore %383 %397 
                                 Output f32* %398 = OpAccessChain %104 %30 %100 
                                         f32 %399 = OpLoad %398 
                                         f32 %400 = OpFNegate %399 
                                 Output f32* %401 = OpAccessChain %104 %30 %100 
                                                      OpStore %401 %400 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 105
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %89 %93 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %89 Location 89 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %93 Location 93 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 3 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 2 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 0 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 1 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                              %88 = OpTypePointer Output %19 
                                Output f32_4* %89 = OpVariable Output 
                                 Input f32_3* %93 = OpVariable Input 
                                          i32 %98 = OpConstant 4 
                                         u32 %101 = OpConstant 3 
                                             %102 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %90 = OpLoad %26 
                                        f32_3 %91 = OpLoad %66 
                                        f32_3 %92 = OpFMul %90 %91 
                                        f32_3 %94 = OpLoad %93 
                                        f32_3 %95 = OpFAdd %92 %94 
                                        f32_4 %96 = OpLoad %89 
                                        f32_4 %97 = OpVectorShuffle %96 %95 4 5 6 3 
                                                      OpStore %89 %97 
                                 Uniform f32* %99 = OpAccessChain %32 %98 
                                         f32 %100 = OpLoad %99 
                                 Output f32* %103 = OpAccessChain %89 %101 
                                                      OpStore %103 %100 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "vulkan hw_tier02 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 403
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %110 %112 %115 %160 %249 %260 %383 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 RelaxedPrecision 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 RelaxedPrecision 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 RelaxedPrecision 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %110 RelaxedPrecision 
                                                      OpDecorate %110 Location 110 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %112 Location 112 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %115 Location 115 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %125 RelaxedPrecision 
                                                      OpDecorate %131 RelaxedPrecision 
                                                      OpDecorate %152 RelaxedPrecision 
                                                      OpDecorate %157 RelaxedPrecision 
                                                      OpDecorate %160 RelaxedPrecision 
                                                      OpDecorate %160 Location 160 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %162 RelaxedPrecision 
                                                      OpDecorate %165 RelaxedPrecision 
                                                      OpDecorate %179 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %194 RelaxedPrecision 
                                                      OpDecorate %195 RelaxedPrecision 
                                                      OpDecorate %197 RelaxedPrecision 
                                                      OpDecorate %198 RelaxedPrecision 
                                                      OpDecorate %200 RelaxedPrecision 
                                                      OpDecorate %201 RelaxedPrecision 
                                                      OpDecorate %203 RelaxedPrecision 
                                                      OpDecorate %204 RelaxedPrecision 
                                                      OpDecorate %205 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %209 RelaxedPrecision 
                                                      OpDecorate %210 RelaxedPrecision 
                                                      OpDecorate %211 RelaxedPrecision 
                                                      OpDecorate %212 RelaxedPrecision 
                                                      OpDecorate %213 RelaxedPrecision 
                                                      OpDecorate %214 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %216 RelaxedPrecision 
                                                      OpDecorate %217 RelaxedPrecision 
                                                      OpDecorate %218 RelaxedPrecision 
                                                      OpDecorate %219 RelaxedPrecision 
                                                      OpDecorate %220 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %233 RelaxedPrecision 
                                                      OpDecorate %234 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %249 RelaxedPrecision 
                                                      OpDecorate %249 Location 249 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %252 RelaxedPrecision 
                                                      OpDecorate %257 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %260 Location 260 
                                                      OpDecorate %261 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %263 RelaxedPrecision 
                                                      OpDecorate %264 RelaxedPrecision 
                                                      OpDecorate %277 RelaxedPrecision 
                                                      OpDecorate %278 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %289 RelaxedPrecision 
                                                      OpDecorate %290 RelaxedPrecision 
                                                      OpDecorate %291 RelaxedPrecision 
                                                      OpDecorate %295 RelaxedPrecision 
                                                      OpDecorate %296 RelaxedPrecision 
                                                      OpDecorate %297 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %303 RelaxedPrecision 
                                                      OpDecorate %307 RelaxedPrecision 
                                                      OpDecorate %308 RelaxedPrecision 
                                                      OpDecorate %309 RelaxedPrecision 
                                                      OpDecorate %310 RelaxedPrecision 
                                                      OpDecorate %311 RelaxedPrecision 
                                                      OpDecorate %312 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %317 RelaxedPrecision 
                                                      OpDecorate %322 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %338 RelaxedPrecision 
                                                      OpDecorate %372 RelaxedPrecision 
                                                      OpDecorate %374 RelaxedPrecision 
                                                      OpDecorate %376 RelaxedPrecision 
                                                      OpDecorate %383 RelaxedPrecision 
                                                      OpDecorate %383 Location 383 
                                                      OpDecorate %384 RelaxedPrecision 
                                                      OpDecorate %387 RelaxedPrecision 
                                                      OpDecorate %389 RelaxedPrecision 
                                                      OpDecorate %391 RelaxedPrecision 
                                                      OpDecorate %392 RelaxedPrecision 
                                                      OpDecorate %393 RelaxedPrecision 
                                                      OpDecorate %394 RelaxedPrecision 
                                                      OpDecorate %395 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %397 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 8 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 10 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypeVector %6 2 
                                             %109 = OpTypePointer Output %108 
                               Output f32_2* %110 = OpVariable Output 
                                             %111 = OpTypePointer Input %108 
                                Input f32_2* %112 = OpVariable Input 
                                             %114 = OpTypePointer Input %14 
                                Input f32_3* %115 = OpVariable Input 
                                         i32 %117 = OpConstant 9 
                                         u32 %122 = OpConstant 0 
                                             %123 = OpTypePointer Private %6 
                                         u32 %136 = OpConstant 2 
                                Private f32* %138 = OpVariable Private 
                                             %151 = OpTypePointer Private %14 
                              Private f32_3* %152 = OpVariable Private 
                                         i32 %155 = OpConstant 11 
                               Output f32_2* %160 = OpVariable Output 
                                         f32 %163 = OpConstant 3.67402E-40 
                                       f32_2 %164 = OpConstantComposite %163 %163 
                                Private f32* %188 = OpVariable Private 
                                         f32 %196 = OpConstant 3.67402E-40 
                                         f32 %199 = OpConstant 3.67402E-40 
                                         f32 %202 = OpConstant 3.67402E-40 
                              Private f32_3* %204 = OpVariable Private 
                                         i32 %207 = OpConstant 15 
                                Private f32* %236 = OpVariable Private 
                                         i32 %237 = OpConstant 13 
                                             %238 = OpTypePointer Uniform %6 
                                         f32 %241 = OpConstant 3.67402E-40 
                                             %248 = OpTypePointer Output %6 
                                 Output f32* %249 = OpVariable Output 
                                         i32 %253 = OpConstant 16 
                                             %254 = OpTypePointer Uniform %20 
                                             %259 = OpTypePointer Output %14 
                               Output f32_3* %260 = OpVariable Output 
                              Private f32_4* %281 = OpVariable Private 
                                         i32 %287 = OpConstant 4 
                                         i32 %293 = OpConstant 5 
                                         i32 %299 = OpConstant 6 
                                         i32 %305 = OpConstant 7 
                                         u32 %314 = OpConstant 3 
                                       f32_3 %335 = OpConstantComposite %163 %163 %163 
                                         f32 %343 = OpConstant 3.67402E-40 
                                       f32_3 %344 = OpConstantComposite %343 %343 %343 
                                         f32 %355 = OpConstant 3.67402E-40 
                                       f32_3 %356 = OpConstantComposite %355 %355 %355 
                                         f32 %358 = OpConstant 3.67402E-40 
                                       f32_3 %359 = OpConstantComposite %358 %358 %358 
                                         i32 %370 = OpConstant 12 
                               Output f32_3* %383 = OpVariable Output 
                                         i32 %385 = OpConstant 14 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                       f32_2 %113 = OpLoad %112 
                                                      OpStore %110 %113 
                                       f32_3 %116 = OpLoad %115 
                              Uniform f32_4* %118 = OpAccessChain %23 %117 %30 
                                       f32_4 %119 = OpLoad %118 
                                       f32_3 %120 = OpVectorShuffle %119 %119 0 1 2 
                                         f32 %121 = OpDot %116 %120 
                                Private f32* %124 = OpAccessChain %46 %122 
                                                      OpStore %124 %121 
                                       f32_3 %125 = OpLoad %115 
                              Uniform f32_4* %126 = OpAccessChain %23 %117 %25 
                                       f32_4 %127 = OpLoad %126 
                                       f32_3 %128 = OpVectorShuffle %127 %127 0 1 2 
                                         f32 %129 = OpDot %125 %128 
                                Private f32* %130 = OpAccessChain %46 %100 
                                                      OpStore %130 %129 
                                       f32_3 %131 = OpLoad %115 
                              Uniform f32_4* %132 = OpAccessChain %23 %117 %38 
                                       f32_4 %133 = OpLoad %132 
                                       f32_3 %134 = OpVectorShuffle %133 %133 0 1 2 
                                         f32 %135 = OpDot %131 %134 
                                Private f32* %137 = OpAccessChain %46 %136 
                                                      OpStore %137 %135 
                                       f32_4 %139 = OpLoad %46 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_4 %141 = OpLoad %46 
                                       f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
                                         f32 %143 = OpDot %140 %142 
                                                      OpStore %138 %143 
                                         f32 %144 = OpLoad %138 
                                         f32 %145 = OpExtInst %1 32 %144 
                                                      OpStore %138 %145 
                                         f32 %146 = OpLoad %138 
                                       f32_4 %147 = OpCompositeConstruct %146 %146 %146 %146 
                                       f32_4 %148 = OpLoad %46 
                                       f32_4 %149 = OpVectorShuffle %148 %148 0 1 2 2 
                                       f32_4 %150 = OpFMul %147 %149 
                                                      OpStore %46 %150 
                                       f32_4 %153 = OpLoad %46 
                                       f32_3 %154 = OpVectorShuffle %153 %153 0 1 2 
                              Uniform f32_3* %156 = OpAccessChain %23 %155 
                                       f32_3 %157 = OpLoad %156 
                                         f32 %158 = OpDot %154 %157 
                                Private f32* %159 = OpAccessChain %152 %122 
                                                      OpStore %159 %158 
                                       f32_3 %161 = OpLoad %152 
                                       f32_2 %162 = OpVectorShuffle %161 %161 0 0 
                                       f32_2 %165 = OpExtInst %1 40 %162 %164 
                                                      OpStore %160 %165 
                                       f32_4 %166 = OpLoad %9 
                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
                                       f32_4 %168 = OpLoad %9 
                                       f32_3 %169 = OpVectorShuffle %168 %168 0 1 2 
                                         f32 %170 = OpDot %167 %169 
                                                      OpStore %138 %170 
                                         f32 %171 = OpLoad %138 
                                         f32 %172 = OpExtInst %1 32 %171 
                                                      OpStore %138 %172 
                                       f32_4 %173 = OpLoad %9 
                                       f32_3 %174 = OpVectorShuffle %173 %173 0 1 2 
                                         f32 %175 = OpLoad %138 
                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
                                       f32_3 %177 = OpFMul %174 %176 
                              Uniform f32_3* %178 = OpAccessChain %23 %155 
                                       f32_3 %179 = OpLoad %178 
                                       f32_3 %180 = OpFAdd %177 %179 
                                                      OpStore %152 %180 
                                         f32 %181 = OpLoad %138 
                                       f32_3 %182 = OpCompositeConstruct %181 %181 %181 
                                       f32_4 %183 = OpLoad %9 
                                       f32_3 %184 = OpVectorShuffle %183 %183 0 1 2 
                                       f32_3 %185 = OpFMul %182 %184 
                                       f32_4 %186 = OpLoad %9 
                                       f32_4 %187 = OpVectorShuffle %186 %185 4 5 6 3 
                                                      OpStore %9 %187 
                                       f32_4 %189 = OpLoad %9 
                                       f32_3 %190 = OpVectorShuffle %189 %189 0 1 2 
                                       f32_4 %191 = OpLoad %46 
                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 3 
                                         f32 %193 = OpDot %190 %192 
                                                      OpStore %188 %193 
                                         f32 %194 = OpLoad %188 
                                         f32 %195 = OpFNegate %194 
                                         f32 %197 = OpFAdd %195 %196 
                                                      OpStore %188 %197 
                                         f32 %198 = OpLoad %188 
                                         f32 %200 = OpFMul %198 %199 
                                                      OpStore %188 %200 
                                         f32 %201 = OpLoad %188 
                                         f32 %203 = OpExtInst %1 43 %201 %163 %202 
                                                      OpStore %188 %203 
                                         f32 %205 = OpLoad %188 
                                       f32_3 %206 = OpCompositeConstruct %205 %205 %205 
                              Uniform f32_3* %208 = OpAccessChain %23 %207 
                                       f32_3 %209 = OpLoad %208 
                                       f32_3 %210 = OpFMul %206 %209 
                                                      OpStore %204 %210 
                                       f32_3 %211 = OpLoad %204 
                                       f32_3 %212 = OpLoad %204 
                                       f32_3 %213 = OpFAdd %211 %212 
                                                      OpStore %204 %213 
                                       f32_3 %214 = OpLoad %152 
                                       f32_3 %215 = OpLoad %152 
                                         f32 %216 = OpDot %214 %215 
                                                      OpStore %188 %216 
                                         f32 %217 = OpLoad %188 
                                         f32 %218 = OpExtInst %1 32 %217 
                                                      OpStore %188 %218 
                                         f32 %219 = OpLoad %188 
                                       f32_3 %220 = OpCompositeConstruct %219 %219 %219 
                                       f32_3 %221 = OpLoad %152 
                                       f32_3 %222 = OpFMul %220 %221 
                                                      OpStore %152 %222 
                                       f32_4 %223 = OpLoad %46 
                                       f32_3 %224 = OpVectorShuffle %223 %223 0 1 2 
                                       f32_3 %225 = OpLoad %152 
                                         f32 %226 = OpDot %224 %225 
                                Private f32* %227 = OpAccessChain %152 %122 
                                                      OpStore %227 %226 
                                Private f32* %228 = OpAccessChain %152 %122 
                                         f32 %229 = OpLoad %228 
                                         f32 %230 = OpExtInst %1 40 %229 %163 
                                Private f32* %231 = OpAccessChain %152 %122 
                                                      OpStore %231 %230 
                                Private f32* %232 = OpAccessChain %152 %122 
                                         f32 %233 = OpLoad %232 
                                         f32 %234 = OpExtInst %1 30 %233 
                                Private f32* %235 = OpAccessChain %152 %122 
                                                      OpStore %235 %234 
                                Uniform f32* %239 = OpAccessChain %23 %237 
                                         f32 %240 = OpLoad %239 
                                         f32 %242 = OpFMul %240 %241 
                                                      OpStore %236 %242 
                                Private f32* %243 = OpAccessChain %152 %122 
                                         f32 %244 = OpLoad %243 
                                         f32 %245 = OpLoad %236 
                                         f32 %246 = OpFMul %244 %245 
                                Private f32* %247 = OpAccessChain %152 %122 
                                                      OpStore %247 %246 
                                Private f32* %250 = OpAccessChain %152 %122 
                                         f32 %251 = OpLoad %250 
                                         f32 %252 = OpExtInst %1 29 %251 
                                                      OpStore %249 %252 
                                Uniform i32* %255 = OpAccessChain %23 %253 
                                         i32 %256 = OpLoad %255 
                                         f32 %257 = OpConvertSToF %256 
                                Private f32* %258 = OpAccessChain %152 %122 
                                                      OpStore %258 %257 
                                       f32_3 %261 = OpLoad %152 
                                       f32_3 %262 = OpVectorShuffle %261 %261 0 0 0 
                                       f32_3 %263 = OpLoad %204 
                                       f32_3 %264 = OpFMul %262 %263 
                                                      OpStore %260 %264 
                                Private f32* %265 = OpAccessChain %46 %100 
                                         f32 %266 = OpLoad %265 
                                Private f32* %267 = OpAccessChain %46 %100 
                                         f32 %268 = OpLoad %267 
                                         f32 %269 = OpFMul %266 %268 
                                Private f32* %270 = OpAccessChain %152 %122 
                                                      OpStore %270 %269 
                                Private f32* %271 = OpAccessChain %46 %122 
                                         f32 %272 = OpLoad %271 
                                Private f32* %273 = OpAccessChain %46 %122 
                                         f32 %274 = OpLoad %273 
                                         f32 %275 = OpFMul %272 %274 
                                Private f32* %276 = OpAccessChain %152 %122 
                                         f32 %277 = OpLoad %276 
                                         f32 %278 = OpFNegate %277 
                                         f32 %279 = OpFAdd %275 %278 
                                Private f32* %280 = OpAccessChain %152 %122 
                                                      OpStore %280 %279 
                                       f32_4 %282 = OpLoad %46 
                                       f32_4 %283 = OpVectorShuffle %282 %282 1 2 3 0 
                                       f32_4 %284 = OpLoad %46 
                                       f32_4 %285 = OpVectorShuffle %284 %284 0 1 3 2 
                                       f32_4 %286 = OpFMul %283 %285 
                                                      OpStore %281 %286 
                              Uniform f32_4* %288 = OpAccessChain %23 %287 
                                       f32_4 %289 = OpLoad %288 
                                       f32_4 %290 = OpLoad %281 
                                         f32 %291 = OpDot %289 %290 
                                Private f32* %292 = OpAccessChain %204 %122 
                                                      OpStore %292 %291 
                              Uniform f32_4* %294 = OpAccessChain %23 %293 
                                       f32_4 %295 = OpLoad %294 
                                       f32_4 %296 = OpLoad %281 
                                         f32 %297 = OpDot %295 %296 
                                Private f32* %298 = OpAccessChain %204 %100 
                                                      OpStore %298 %297 
                              Uniform f32_4* %300 = OpAccessChain %23 %299 
                                       f32_4 %301 = OpLoad %300 
                                       f32_4 %302 = OpLoad %281 
                                         f32 %303 = OpDot %301 %302 
                                Private f32* %304 = OpAccessChain %204 %136 
                                                      OpStore %304 %303 
                              Uniform f32_4* %306 = OpAccessChain %23 %305 
                                       f32_4 %307 = OpLoad %306 
                                       f32_3 %308 = OpVectorShuffle %307 %307 0 1 2 
                                       f32_3 %309 = OpLoad %152 
                                       f32_3 %310 = OpVectorShuffle %309 %309 0 0 0 
                                       f32_3 %311 = OpFMul %308 %310 
                                       f32_3 %312 = OpLoad %204 
                                       f32_3 %313 = OpFAdd %311 %312 
                                                      OpStore %152 %313 
                                Private f32* %315 = OpAccessChain %46 %314 
                                                      OpStore %315 %202 
                              Uniform f32_4* %316 = OpAccessChain %23 %25 
                                       f32_4 %317 = OpLoad %316 
                                       f32_4 %318 = OpLoad %46 
                                         f32 %319 = OpDot %317 %318 
                                Private f32* %320 = OpAccessChain %204 %122 
                                                      OpStore %320 %319 
                              Uniform f32_4* %321 = OpAccessChain %23 %38 
                                       f32_4 %322 = OpLoad %321 
                                       f32_4 %323 = OpLoad %46 
                                         f32 %324 = OpDot %322 %323 
                                Private f32* %325 = OpAccessChain %204 %100 
                                                      OpStore %325 %324 
                              Uniform f32_4* %326 = OpAccessChain %23 %48 
                                       f32_4 %327 = OpLoad %326 
                                       f32_4 %328 = OpLoad %46 
                                         f32 %329 = OpDot %327 %328 
                                Private f32* %330 = OpAccessChain %204 %136 
                                                      OpStore %330 %329 
                                       f32_3 %331 = OpLoad %152 
                                       f32_3 %332 = OpLoad %204 
                                       f32_3 %333 = OpFAdd %331 %332 
                                                      OpStore %152 %333 
                                       f32_3 %334 = OpLoad %152 
                                       f32_3 %336 = OpExtInst %1 40 %334 %335 
                                                      OpStore %152 %336 
                                       f32_3 %337 = OpLoad %152 
                                       f32_3 %338 = OpExtInst %1 30 %337 
                                       f32_4 %339 = OpLoad %46 
                                       f32_4 %340 = OpVectorShuffle %339 %338 4 5 6 3 
                                                      OpStore %46 %340 
                                       f32_4 %341 = OpLoad %46 
                                       f32_3 %342 = OpVectorShuffle %341 %341 0 1 2 
                                       f32_3 %345 = OpFMul %342 %344 
                                       f32_4 %346 = OpLoad %46 
                                       f32_4 %347 = OpVectorShuffle %346 %345 4 5 6 3 
                                                      OpStore %46 %347 
                                       f32_4 %348 = OpLoad %46 
                                       f32_3 %349 = OpVectorShuffle %348 %348 0 1 2 
                                       f32_3 %350 = OpExtInst %1 29 %349 
                                       f32_4 %351 = OpLoad %46 
                                       f32_4 %352 = OpVectorShuffle %351 %350 4 5 6 3 
                                                      OpStore %46 %352 
                                       f32_4 %353 = OpLoad %46 
                                       f32_3 %354 = OpVectorShuffle %353 %353 0 1 2 
                                       f32_3 %357 = OpFMul %354 %356 
                                       f32_3 %360 = OpFAdd %357 %359 
                                       f32_4 %361 = OpLoad %46 
                                       f32_4 %362 = OpVectorShuffle %361 %360 4 5 6 3 
                                                      OpStore %46 %362 
                                       f32_4 %363 = OpLoad %46 
                                       f32_3 %364 = OpVectorShuffle %363 %363 0 1 2 
                                       f32_3 %365 = OpExtInst %1 40 %364 %335 
                                       f32_4 %366 = OpLoad %46 
                                       f32_4 %367 = OpVectorShuffle %366 %365 4 5 6 3 
                                                      OpStore %46 %367 
                                       f32_4 %368 = OpLoad %46 
                                       f32_3 %369 = OpVectorShuffle %368 %368 0 1 2 
                                Uniform f32* %371 = OpAccessChain %23 %370 
                                         f32 %372 = OpLoad %371 
                                Uniform f32* %373 = OpAccessChain %23 %370 
                                         f32 %374 = OpLoad %373 
                                Uniform f32* %375 = OpAccessChain %23 %370 
                                         f32 %376 = OpLoad %375 
                                       f32_3 %377 = OpCompositeConstruct %372 %374 %376 
                                         f32 %378 = OpCompositeExtract %377 0 
                                         f32 %379 = OpCompositeExtract %377 1 
                                         f32 %380 = OpCompositeExtract %377 2 
                                       f32_3 %381 = OpCompositeConstruct %378 %379 %380 
                                       f32_3 %382 = OpFMul %369 %381 
                                                      OpStore %152 %382 
                                       f32_3 %384 = OpLoad %152 
                                Uniform f32* %386 = OpAccessChain %23 %385 
                                         f32 %387 = OpLoad %386 
                                Uniform f32* %388 = OpAccessChain %23 %385 
                                         f32 %389 = OpLoad %388 
                                Uniform f32* %390 = OpAccessChain %23 %385 
                                         f32 %391 = OpLoad %390 
                                       f32_3 %392 = OpCompositeConstruct %387 %389 %391 
                                         f32 %393 = OpCompositeExtract %392 0 
                                         f32 %394 = OpCompositeExtract %392 1 
                                         f32 %395 = OpCompositeExtract %392 2 
                                       f32_3 %396 = OpCompositeConstruct %393 %394 %395 
                                       f32_3 %397 = OpFMul %384 %396 
                                                      OpStore %383 %397 
                                 Output f32* %398 = OpAccessChain %104 %30 %100 
                                         f32 %399 = OpLoad %398 
                                         f32 %400 = OpFNegate %399 
                                 Output f32* %401 = OpAccessChain %104 %30 %100 
                                                      OpStore %401 %400 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 105
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %89 %93 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %89 Location 89 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %93 Location 93 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 3 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 2 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 0 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 1 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                              %88 = OpTypePointer Output %19 
                                Output f32_4* %89 = OpVariable Output 
                                 Input f32_3* %93 = OpVariable Input 
                                          i32 %98 = OpConstant 4 
                                         u32 %101 = OpConstant 3 
                                             %102 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %90 = OpLoad %26 
                                        f32_3 %91 = OpLoad %66 
                                        f32_3 %92 = OpFMul %90 %91 
                                        f32_3 %94 = OpLoad %93 
                                        f32_3 %95 = OpFAdd %92 %94 
                                        f32_4 %96 = OpLoad %89 
                                        f32_4 %97 = OpVectorShuffle %96 %95 4 5 6 3 
                                                      OpStore %89 %97 
                                 Uniform f32* %99 = OpAccessChain %32 %98 
                                         f32 %100 = OpLoad %99 
                                 Output f32* %103 = OpAccessChain %89 %101 
                                                      OpStore %103 %100 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 norm_8;
  norm_8 = tmpvar_1;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((norm_8 * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_11;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_3;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  mediump vec3 tmpvar_18;
  tmpvar_18 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_14 = tmpvar_18;
  tmpvar_5 = ((tmpvar_18 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD3 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  xlat_varoutput_1.xyz = mix (unity_FogColor.xyz, xlat_varoutput_1.xyz, vec3(tmpvar_4));
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 norm_8;
  norm_8 = tmpvar_1;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((norm_8 * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_11;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_3;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  mediump vec3 tmpvar_18;
  tmpvar_18 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_14 = tmpvar_18;
  tmpvar_5 = ((tmpvar_18 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD3 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  xlat_varoutput_1.xyz = mix (unity_FogColor.xyz, xlat_varoutput_1.xyz, vec3(tmpvar_4));
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp vec3 _GlobalMainLightVector;
uniform lowp float _GlobalLightProbeIntensity;
uniform lowp float _Roughness_Low;
uniform lowp float _LightProbeIntensity;
uniform lowp vec3 _GlobalEventColor;
uniform highp int _EventToggle;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldViewDir_2;
  lowp vec3 worldNormal_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec3 norm_8;
  norm_8 = tmpvar_1;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((norm_8 * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  worldViewDir_2 = tmpvar_11;
  tmpvar_4 = ((vec3(clamp (
    (((1.0 - dot (worldViewDir_2, worldNormal_3)) + 0.2) * 0.8)
  , 0.0, 1.0)) * (_GlobalEventColor * 2.0)) * float(_EventToggle));
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_3;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  mediump vec3 tmpvar_18;
  tmpvar_18 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_14 = tmpvar_18;
  tmpvar_5 = ((tmpvar_18 * _GlobalLightProbeIntensity) * _LightProbeIntensity);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = vec2(max (0.0, dot (worldNormal_3, _GlobalMainLightVector)));
  xlv_TEXCOORD2 = pow (max (0.0, dot (worldNormal_3, 
    normalize((_GlobalMainLightVector + worldViewDir_2))
  )), (_Roughness_Low * 20.0));
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_COLOR = tmpvar_5;
  xlv_TEXCOORD3 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform lowp vec3 _GlobalAmbientColor;
uniform sampler2D _GlobalRampDiffuseTex;
uniform sampler2D _MainTex;
uniform lowp float _MainX;
uniform sampler2D _MaskBuffer;
uniform lowp float _SpecX_Low;
uniform lowp float _Fade;
varying lowp vec2 xlv_TEXCOORD0;
varying lowp vec2 xlv_TEXCOORD1;
varying lowp float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD4;
varying lowp vec3 xlv_COLOR;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec3 diffColor_2;
  diffColor_2 = (texture2D (_GlobalRampDiffuseTex, xlv_TEXCOORD1).xyz * _LightColor0.xyz);
  diffColor_2 = (diffColor_2 + _GlobalAmbientColor);
  lowp vec3 tmpvar_3;
  tmpvar_3 = max (diffColor_2, (diffColor_2 * xlv_COLOR));
  diffColor_2 = tmpvar_3;
  xlat_varoutput_1.w = 1.0;
  xlat_varoutput_1.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0).xyz * _MainX) + vec3((
    (xlv_TEXCOORD2 * _SpecX_Low)
   * texture2D (_MaskBuffer, xlv_TEXCOORD0).x))) * tmpvar_3);
  xlat_varoutput_1.xyz = (xlat_varoutput_1.xyz + xlv_TEXCOORD4);
  xlat_varoutput_1.w = _Fade;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  xlat_varoutput_1.xyz = mix (unity_FogColor.xyz, xlat_varoutput_1.xyz, vec3(tmpvar_4));
  gl_FragData[0] = xlat_varoutput_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
out highp float vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD3 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
in highp float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
out highp float vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD3 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
in highp float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec3 _GlobalMainLightVector;
uniform 	mediump float _GlobalLightProbeIntensity;
uniform 	mediump float _Roughness_Low;
uniform 	mediump float _LightProbeIntensity;
uniform 	mediump vec3 _GlobalEventColor;
uniform 	int _EventToggle;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_COLOR0;
out highp float vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_8;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD3 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1 = vec4(u_xlat15) * u_xlat1.xyzz;
    u_xlat16_3.x = dot(u_xlat1.xyz, _GlobalMainLightVector.xyz);
    vs_TEXCOORD1.xy = max(u_xlat16_3.xx, vec2(0.0, 0.0));
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat15) + _GlobalMainLightVector.xyz;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_18 = dot(u_xlat0.xyz, u_xlat1.xyw);
    u_xlat16_18 = (-u_xlat16_18) + 1.20000005;
    u_xlat16_18 = u_xlat16_18 * 0.800000012;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _GlobalEventColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = max(u_xlat16_3.x, 0.0);
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8 = _Roughness_Low * 20.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8;
    vs_TEXCOORD2 = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(_EventToggle);
    vs_TEXCOORD4.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz;
    u_xlat16_3.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_3.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_3.x);
    u_xlat16_0 = u_xlat1.yzwx * u_xlat1.xywz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_3.xyz = unity_SHC.xyz * u_xlat16_3.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_4.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_4.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_4.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat1.xyz = log2(u_xlat16_3.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = u_xlat1.xyz * vec3(vec3(_GlobalLightProbeIntensity, _GlobalLightProbeIntensity, _GlobalLightProbeIntensity));
    vs_COLOR0.xyz = u_xlat16_3.xyz * vec3(vec3(_LightProbeIntensity, _LightProbeIntensity, _LightProbeIntensity));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec3 _GlobalAmbientColor;
uniform 	mediump float _MainX;
uniform 	mediump float _SpecX_Low;
uniform 	mediump float _Fade;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskBuffer;
uniform lowp sampler2D _GlobalRampDiffuseTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump float vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_COLOR0;
in highp float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat10_0.x = texture(_MaskBuffer, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = vs_TEXCOORD2 * _SpecX_Low;
    u_xlat16_1.x = u_xlat10_0.x * u_xlat16_1.x;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_MainX) + u_xlat16_1.xxx;
    u_xlat10_0.xyz = texture(_GlobalRampDiffuseTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _LightColor0.xyz + _GlobalAmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Fade;
    return;
}

#endif
"
}
SubProgram "vulkan hw_tier00 " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 427
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %129 %141 %143 %146 %188 %273 %284 %407 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 RelaxedPrecision 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpMemberDecorate %21 17 RelaxedPrecision 
                                                      OpMemberDecorate %21 17 Offset 21 
                                                      OpMemberDecorate %21 18 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %129 Location 129 
                                                      OpDecorate %141 RelaxedPrecision 
                                                      OpDecorate %141 Location 141 
                                                      OpDecorate %143 RelaxedPrecision 
                                                      OpDecorate %143 Location 143 
                                                      OpDecorate %144 RelaxedPrecision 
                                                      OpDecorate %146 RelaxedPrecision 
                                                      OpDecorate %146 Location 146 
                                                      OpDecorate %147 RelaxedPrecision 
                                                      OpDecorate %155 RelaxedPrecision 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %180 RelaxedPrecision 
                                                      OpDecorate %185 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %188 Location 188 
                                                      OpDecorate %189 RelaxedPrecision 
                                                      OpDecorate %190 RelaxedPrecision 
                                                      OpDecorate %192 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %224 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %227 RelaxedPrecision 
                                                      OpDecorate %228 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %231 RelaxedPrecision 
                                                      OpDecorate %232 RelaxedPrecision 
                                                      OpDecorate %235 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %237 RelaxedPrecision 
                                                      OpDecorate %238 RelaxedPrecision 
                                                      OpDecorate %239 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %241 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %243 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %247 RelaxedPrecision 
                                                      OpDecorate %248 RelaxedPrecision 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %255 RelaxedPrecision 
                                                      OpDecorate %256 RelaxedPrecision 
                                                      OpDecorate %259 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %265 RelaxedPrecision 
                                                      OpDecorate %267 RelaxedPrecision 
                                                      OpDecorate %269 RelaxedPrecision 
                                                      OpDecorate %270 RelaxedPrecision 
                                                      OpDecorate %271 RelaxedPrecision 
                                                      OpDecorate %273 RelaxedPrecision 
                                                      OpDecorate %273 Location 273 
                                                      OpDecorate %275 RelaxedPrecision 
                                                      OpDecorate %276 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %284 RelaxedPrecision 
                                                      OpDecorate %284 Location 284 
                                                      OpDecorate %285 RelaxedPrecision 
                                                      OpDecorate %286 RelaxedPrecision 
                                                      OpDecorate %287 RelaxedPrecision 
                                                      OpDecorate %288 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %305 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %314 RelaxedPrecision 
                                                      OpDecorate %315 RelaxedPrecision 
                                                      OpDecorate %319 RelaxedPrecision 
                                                      OpDecorate %320 RelaxedPrecision 
                                                      OpDecorate %321 RelaxedPrecision 
                                                      OpDecorate %325 RelaxedPrecision 
                                                      OpDecorate %326 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %335 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %340 RelaxedPrecision 
                                                      OpDecorate %345 RelaxedPrecision 
                                                      OpDecorate %351 RelaxedPrecision 
                                                      OpDecorate %355 RelaxedPrecision 
                                                      OpDecorate %356 RelaxedPrecision 
                                                      OpDecorate %357 RelaxedPrecision 
                                                      OpDecorate %358 RelaxedPrecision 
                                                      OpDecorate %360 RelaxedPrecision 
                                                      OpDecorate %361 RelaxedPrecision 
                                                      OpDecorate %362 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %398 RelaxedPrecision 
                                                      OpDecorate %400 RelaxedPrecision 
                                                      OpDecorate %407 RelaxedPrecision 
                                                      OpDecorate %407 Location 407 
                                                      OpDecorate %408 RelaxedPrecision 
                                                      OpDecorate %411 RelaxedPrecision 
                                                      OpDecorate %413 RelaxedPrecision 
                                                      OpDecorate %415 RelaxedPrecision 
                                                      OpDecorate %416 RelaxedPrecision 
                                                      OpDecorate %417 RelaxedPrecision 
                                                      OpDecorate %418 RelaxedPrecision 
                                                      OpDecorate %419 RelaxedPrecision 
                                                      OpDecorate %420 RelaxedPrecision 
                                                      OpDecorate %421 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %7 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 9 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 11 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypePointer Private %6 
                                Private f32* %109 = OpVariable Private 
                                         u32 %110 = OpConstant 2 
                                             %113 = OpTypePointer Uniform %6 
                                         f32 %119 = OpConstant 3.67402E-40 
                                         f32 %126 = OpConstant 3.67402E-40 
                                             %128 = OpTypePointer Output %6 
                                 Output f32* %129 = OpVariable Output 
                                         i32 %131 = OpConstant 12 
                                         u32 %135 = OpConstant 3 
                                             %139 = OpTypeVector %6 2 
                                             %140 = OpTypePointer Output %139 
                               Output f32_2* %141 = OpVariable Output 
                                             %142 = OpTypePointer Input %139 
                                Input f32_2* %143 = OpVariable Input 
                                             %145 = OpTypePointer Input %14 
                                Input f32_3* %146 = OpVariable Input 
                                         i32 %148 = OpConstant 10 
                                         u32 %153 = OpConstant 0 
                                             %179 = OpTypePointer Private %14 
                              Private f32_3* %180 = OpVariable Private 
                                         i32 %183 = OpConstant 13 
                               Output f32_2* %188 = OpVariable Output 
                                       f32_2 %191 = OpConstantComposite %126 %126 
                                Private f32* %215 = OpVariable Private 
                                         f32 %223 = OpConstant 3.67402E-40 
                                         f32 %226 = OpConstant 3.67402E-40 
                              Private f32_3* %230 = OpVariable Private 
                                         i32 %233 = OpConstant 17 
                                Private f32* %262 = OpVariable Private 
                                         i32 %263 = OpConstant 15 
                                         f32 %266 = OpConstant 3.67402E-40 
                                 Output f32* %273 = OpVariable Output 
                                         i32 %277 = OpConstant 18 
                                             %278 = OpTypePointer Uniform %20 
                                             %283 = OpTypePointer Output %14 
                               Output f32_3* %284 = OpVariable Output 
                              Private f32_4* %305 = OpVariable Private 
                                         i32 %311 = OpConstant 5 
                                         i32 %317 = OpConstant 6 
                                         i32 %323 = OpConstant 7 
                                         i32 %329 = OpConstant 8 
                                         i32 %349 = OpConstant 4 
                                       f32_3 %359 = OpConstantComposite %126 %126 %126 
                                         f32 %367 = OpConstant 3.67402E-40 
                                       f32_3 %368 = OpConstantComposite %367 %367 %367 
                                         f32 %379 = OpConstant 3.67402E-40 
                                       f32_3 %380 = OpConstantComposite %379 %379 %379 
                                         f32 %382 = OpConstant 3.67402E-40 
                                       f32_3 %383 = OpConstantComposite %382 %382 %382 
                                         i32 %394 = OpConstant 14 
                               Output f32_3* %407 = OpVariable Output 
                                         i32 %409 = OpConstant 16 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                Private f32* %111 = OpAccessChain %46 %110 
                                         f32 %112 = OpLoad %111 
                                Uniform f32* %114 = OpAccessChain %23 %25 %100 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFDiv %112 %115 
                                                      OpStore %109 %116 
                                         f32 %117 = OpLoad %109 
                                         f32 %118 = OpFNegate %117 
                                         f32 %120 = OpFAdd %118 %119 
                                                      OpStore %109 %120 
                                         f32 %121 = OpLoad %109 
                                Uniform f32* %122 = OpAccessChain %23 %25 %110 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                                      OpStore %109 %124 
                                         f32 %125 = OpLoad %109 
                                         f32 %127 = OpExtInst %1 40 %125 %126 
                                                      OpStore %109 %127 
                                         f32 %130 = OpLoad %109 
                                Uniform f32* %132 = OpAccessChain %23 %131 %110 
                                         f32 %133 = OpLoad %132 
                                         f32 %134 = OpFMul %130 %133 
                                Uniform f32* %136 = OpAccessChain %23 %131 %135 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFAdd %134 %137 
                                                      OpStore %129 %138 
                                       f32_2 %144 = OpLoad %143 
                                                      OpStore %141 %144 
                                       f32_3 %147 = OpLoad %146 
                              Uniform f32_4* %149 = OpAccessChain %23 %148 %30 
                                       f32_4 %150 = OpLoad %149 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                         f32 %152 = OpDot %147 %151 
                                Private f32* %154 = OpAccessChain %46 %153 
                                                      OpStore %154 %152 
                                       f32_3 %155 = OpLoad %146 
                              Uniform f32_4* %156 = OpAccessChain %23 %148 %25 
                                       f32_4 %157 = OpLoad %156 
                                       f32_3 %158 = OpVectorShuffle %157 %157 0 1 2 
                                         f32 %159 = OpDot %155 %158 
                                Private f32* %160 = OpAccessChain %46 %100 
                                                      OpStore %160 %159 
                                       f32_3 %161 = OpLoad %146 
                              Uniform f32_4* %162 = OpAccessChain %23 %148 %38 
                                       f32_4 %163 = OpLoad %162 
                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
                                         f32 %165 = OpDot %161 %164 
                                Private f32* %166 = OpAccessChain %46 %110 
                                                      OpStore %166 %165 
                                       f32_4 %167 = OpLoad %46 
                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
                                       f32_4 %169 = OpLoad %46 
                                       f32_3 %170 = OpVectorShuffle %169 %169 0 1 2 
                                         f32 %171 = OpDot %168 %170 
                                                      OpStore %109 %171 
                                         f32 %172 = OpLoad %109 
                                         f32 %173 = OpExtInst %1 32 %172 
                                                      OpStore %109 %173 
                                         f32 %174 = OpLoad %109 
                                       f32_4 %175 = OpCompositeConstruct %174 %174 %174 %174 
                                       f32_4 %176 = OpLoad %46 
                                       f32_4 %177 = OpVectorShuffle %176 %176 0 1 2 2 
                                       f32_4 %178 = OpFMul %175 %177 
                                                      OpStore %46 %178 
                                       f32_4 %181 = OpLoad %46 
                                       f32_3 %182 = OpVectorShuffle %181 %181 0 1 2 
                              Uniform f32_3* %184 = OpAccessChain %23 %183 
                                       f32_3 %185 = OpLoad %184 
                                         f32 %186 = OpDot %182 %185 
                                Private f32* %187 = OpAccessChain %180 %153 
                                                      OpStore %187 %186 
                                       f32_3 %189 = OpLoad %180 
                                       f32_2 %190 = OpVectorShuffle %189 %189 0 0 
                                       f32_2 %192 = OpExtInst %1 40 %190 %191 
                                                      OpStore %188 %192 
                                       f32_4 %193 = OpLoad %9 
                                       f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
                                       f32_4 %195 = OpLoad %9 
                                       f32_3 %196 = OpVectorShuffle %195 %195 0 1 2 
                                         f32 %197 = OpDot %194 %196 
                                                      OpStore %109 %197 
                                         f32 %198 = OpLoad %109 
                                         f32 %199 = OpExtInst %1 32 %198 
                                                      OpStore %109 %199 
                                       f32_4 %200 = OpLoad %9 
                                       f32_3 %201 = OpVectorShuffle %200 %200 0 1 2 
                                         f32 %202 = OpLoad %109 
                                       f32_3 %203 = OpCompositeConstruct %202 %202 %202 
                                       f32_3 %204 = OpFMul %201 %203 
                              Uniform f32_3* %205 = OpAccessChain %23 %183 
                                       f32_3 %206 = OpLoad %205 
                                       f32_3 %207 = OpFAdd %204 %206 
                                                      OpStore %180 %207 
                                         f32 %208 = OpLoad %109 
                                       f32_3 %209 = OpCompositeConstruct %208 %208 %208 
                                       f32_4 %210 = OpLoad %9 
                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
                                       f32_3 %212 = OpFMul %209 %211 
                                       f32_4 %213 = OpLoad %9 
                                       f32_4 %214 = OpVectorShuffle %213 %212 4 5 6 3 
                                                      OpStore %9 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
                                       f32_4 %218 = OpLoad %46 
                                       f32_3 %219 = OpVectorShuffle %218 %218 0 1 3 
                                         f32 %220 = OpDot %217 %219 
                                                      OpStore %215 %220 
                                         f32 %221 = OpLoad %215 
                                         f32 %222 = OpFNegate %221 
                                         f32 %224 = OpFAdd %222 %223 
                                                      OpStore %215 %224 
                                         f32 %225 = OpLoad %215 
                                         f32 %227 = OpFMul %225 %226 
                                                      OpStore %215 %227 
                                         f32 %228 = OpLoad %215 
                                         f32 %229 = OpExtInst %1 43 %228 %126 %119 
                                                      OpStore %215 %229 
                                         f32 %231 = OpLoad %215 
                                       f32_3 %232 = OpCompositeConstruct %231 %231 %231 
                              Uniform f32_3* %234 = OpAccessChain %23 %233 
                                       f32_3 %235 = OpLoad %234 
                                       f32_3 %236 = OpFMul %232 %235 
                                                      OpStore %230 %236 
                                       f32_3 %237 = OpLoad %230 
                                       f32_3 %238 = OpLoad %230 
                                       f32_3 %239 = OpFAdd %237 %238 
                                                      OpStore %230 %239 
                                       f32_3 %240 = OpLoad %180 
                                       f32_3 %241 = OpLoad %180 
                                         f32 %242 = OpDot %240 %241 
                                                      OpStore %215 %242 
                                         f32 %243 = OpLoad %215 
                                         f32 %244 = OpExtInst %1 32 %243 
                                                      OpStore %215 %244 
                                         f32 %245 = OpLoad %215 
                                       f32_3 %246 = OpCompositeConstruct %245 %245 %245 
                                       f32_3 %247 = OpLoad %180 
                                       f32_3 %248 = OpFMul %246 %247 
                                                      OpStore %180 %248 
                                       f32_4 %249 = OpLoad %46 
                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
                                       f32_3 %251 = OpLoad %180 
                                         f32 %252 = OpDot %250 %251 
                                Private f32* %253 = OpAccessChain %180 %153 
                                                      OpStore %253 %252 
                                Private f32* %254 = OpAccessChain %180 %153 
                                         f32 %255 = OpLoad %254 
                                         f32 %256 = OpExtInst %1 40 %255 %126 
                                Private f32* %257 = OpAccessChain %180 %153 
                                                      OpStore %257 %256 
                                Private f32* %258 = OpAccessChain %180 %153 
                                         f32 %259 = OpLoad %258 
                                         f32 %260 = OpExtInst %1 30 %259 
                                Private f32* %261 = OpAccessChain %180 %153 
                                                      OpStore %261 %260 
                                Uniform f32* %264 = OpAccessChain %23 %263 
                                         f32 %265 = OpLoad %264 
                                         f32 %267 = OpFMul %265 %266 
                                                      OpStore %262 %267 
                                Private f32* %268 = OpAccessChain %180 %153 
                                         f32 %269 = OpLoad %268 
                                         f32 %270 = OpLoad %262 
                                         f32 %271 = OpFMul %269 %270 
                                Private f32* %272 = OpAccessChain %180 %153 
                                                      OpStore %272 %271 
                                Private f32* %274 = OpAccessChain %180 %153 
                                         f32 %275 = OpLoad %274 
                                         f32 %276 = OpExtInst %1 29 %275 
                                                      OpStore %273 %276 
                                Uniform i32* %279 = OpAccessChain %23 %277 
                                         i32 %280 = OpLoad %279 
                                         f32 %281 = OpConvertSToF %280 
                                Private f32* %282 = OpAccessChain %180 %153 
                                                      OpStore %282 %281 
                                       f32_3 %285 = OpLoad %180 
                                       f32_3 %286 = OpVectorShuffle %285 %285 0 0 0 
                                       f32_3 %287 = OpLoad %230 
                                       f32_3 %288 = OpFMul %286 %287 
                                                      OpStore %284 %288 
                                Private f32* %289 = OpAccessChain %46 %100 
                                         f32 %290 = OpLoad %289 
                                Private f32* %291 = OpAccessChain %46 %100 
                                         f32 %292 = OpLoad %291 
                                         f32 %293 = OpFMul %290 %292 
                                Private f32* %294 = OpAccessChain %180 %153 
                                                      OpStore %294 %293 
                                Private f32* %295 = OpAccessChain %46 %153 
                                         f32 %296 = OpLoad %295 
                                Private f32* %297 = OpAccessChain %46 %153 
                                         f32 %298 = OpLoad %297 
                                         f32 %299 = OpFMul %296 %298 
                                Private f32* %300 = OpAccessChain %180 %153 
                                         f32 %301 = OpLoad %300 
                                         f32 %302 = OpFNegate %301 
                                         f32 %303 = OpFAdd %299 %302 
                                Private f32* %304 = OpAccessChain %180 %153 
                                                      OpStore %304 %303 
                                       f32_4 %306 = OpLoad %46 
                                       f32_4 %307 = OpVectorShuffle %306 %306 1 2 3 0 
                                       f32_4 %308 = OpLoad %46 
                                       f32_4 %309 = OpVectorShuffle %308 %308 0 1 3 2 
                                       f32_4 %310 = OpFMul %307 %309 
                                                      OpStore %305 %310 
                              Uniform f32_4* %312 = OpAccessChain %23 %311 
                                       f32_4 %313 = OpLoad %312 
                                       f32_4 %314 = OpLoad %305 
                                         f32 %315 = OpDot %313 %314 
                                Private f32* %316 = OpAccessChain %230 %153 
                                                      OpStore %316 %315 
                              Uniform f32_4* %318 = OpAccessChain %23 %317 
                                       f32_4 %319 = OpLoad %318 
                                       f32_4 %320 = OpLoad %305 
                                         f32 %321 = OpDot %319 %320 
                                Private f32* %322 = OpAccessChain %230 %100 
                                                      OpStore %322 %321 
                              Uniform f32_4* %324 = OpAccessChain %23 %323 
                                       f32_4 %325 = OpLoad %324 
                                       f32_4 %326 = OpLoad %305 
                                         f32 %327 = OpDot %325 %326 
                                Private f32* %328 = OpAccessChain %230 %110 
                                                      OpStore %328 %327 
                              Uniform f32_4* %330 = OpAccessChain %23 %329 
                                       f32_4 %331 = OpLoad %330 
                                       f32_3 %332 = OpVectorShuffle %331 %331 0 1 2 
                                       f32_3 %333 = OpLoad %180 
                                       f32_3 %334 = OpVectorShuffle %333 %333 0 0 0 
                                       f32_3 %335 = OpFMul %332 %334 
                                       f32_3 %336 = OpLoad %230 
                                       f32_3 %337 = OpFAdd %335 %336 
                                                      OpStore %180 %337 
                                Private f32* %338 = OpAccessChain %46 %135 
                                                      OpStore %338 %119 
                              Uniform f32_4* %339 = OpAccessChain %23 %38 
                                       f32_4 %340 = OpLoad %339 
                                       f32_4 %341 = OpLoad %46 
                                         f32 %342 = OpDot %340 %341 
                                Private f32* %343 = OpAccessChain %230 %153 
                                                      OpStore %343 %342 
                              Uniform f32_4* %344 = OpAccessChain %23 %48 
                                       f32_4 %345 = OpLoad %344 
                                       f32_4 %346 = OpLoad %46 
                                         f32 %347 = OpDot %345 %346 
                                Private f32* %348 = OpAccessChain %230 %100 
                                                      OpStore %348 %347 
                              Uniform f32_4* %350 = OpAccessChain %23 %349 
                                       f32_4 %351 = OpLoad %350 
                                       f32_4 %352 = OpLoad %46 
                                         f32 %353 = OpDot %351 %352 
                                Private f32* %354 = OpAccessChain %230 %110 
                                                      OpStore %354 %353 
                                       f32_3 %355 = OpLoad %180 
                                       f32_3 %356 = OpLoad %230 
                                       f32_3 %357 = OpFAdd %355 %356 
                                                      OpStore %180 %357 
                                       f32_3 %358 = OpLoad %180 
                                       f32_3 %360 = OpExtInst %1 40 %358 %359 
                                                      OpStore %180 %360 
                                       f32_3 %361 = OpLoad %180 
                                       f32_3 %362 = OpExtInst %1 30 %361 
                                       f32_4 %363 = OpLoad %46 
                                       f32_4 %364 = OpVectorShuffle %363 %362 4 5 6 3 
                                                      OpStore %46 %364 
                                       f32_4 %365 = OpLoad %46 
                                       f32_3 %366 = OpVectorShuffle %365 %365 0 1 2 
                                       f32_3 %369 = OpFMul %366 %368 
                                       f32_4 %370 = OpLoad %46 
                                       f32_4 %371 = OpVectorShuffle %370 %369 4 5 6 3 
                                                      OpStore %46 %371 
                                       f32_4 %372 = OpLoad %46 
                                       f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
                                       f32_3 %374 = OpExtInst %1 29 %373 
                                       f32_4 %375 = OpLoad %46 
                                       f32_4 %376 = OpVectorShuffle %375 %374 4 5 6 3 
                                                      OpStore %46 %376 
                                       f32_4 %377 = OpLoad %46 
                                       f32_3 %378 = OpVectorShuffle %377 %377 0 1 2 
                                       f32_3 %381 = OpFMul %378 %380 
                                       f32_3 %384 = OpFAdd %381 %383 
                                       f32_4 %385 = OpLoad %46 
                                       f32_4 %386 = OpVectorShuffle %385 %384 4 5 6 3 
                                                      OpStore %46 %386 
                                       f32_4 %387 = OpLoad %46 
                                       f32_3 %388 = OpVectorShuffle %387 %387 0 1 2 
                                       f32_3 %389 = OpExtInst %1 40 %388 %359 
                                       f32_4 %390 = OpLoad %46 
                                       f32_4 %391 = OpVectorShuffle %390 %389 4 5 6 3 
                                                      OpStore %46 %391 
                                       f32_4 %392 = OpLoad %46 
                                       f32_3 %393 = OpVectorShuffle %392 %392 0 1 2 
                                Uniform f32* %395 = OpAccessChain %23 %394 
                                         f32 %396 = OpLoad %395 
                                Uniform f32* %397 = OpAccessChain %23 %394 
                                         f32 %398 = OpLoad %397 
                                Uniform f32* %399 = OpAccessChain %23 %394 
                                         f32 %400 = OpLoad %399 
                                       f32_3 %401 = OpCompositeConstruct %396 %398 %400 
                                         f32 %402 = OpCompositeExtract %401 0 
                                         f32 %403 = OpCompositeExtract %401 1 
                                         f32 %404 = OpCompositeExtract %401 2 
                                       f32_3 %405 = OpCompositeConstruct %402 %403 %404 
                                       f32_3 %406 = OpFMul %393 %405 
                                                      OpStore %180 %406 
                                       f32_3 %408 = OpLoad %180 
                                Uniform f32* %410 = OpAccessChain %23 %409 
                                         f32 %411 = OpLoad %410 
                                Uniform f32* %412 = OpAccessChain %23 %409 
                                         f32 %413 = OpLoad %412 
                                Uniform f32* %414 = OpAccessChain %23 %409 
                                         f32 %415 = OpLoad %414 
                                       f32_3 %416 = OpCompositeConstruct %411 %413 %415 
                                         f32 %417 = OpCompositeExtract %416 0 
                                         f32 %418 = OpCompositeExtract %416 1 
                                         f32 %419 = OpCompositeExtract %416 2 
                                       f32_3 %420 = OpCompositeConstruct %417 %418 %419 
                                       f32_3 %421 = OpFMul %408 %420 
                                                      OpStore %407 %421 
                                 Output f32* %422 = OpAccessChain %104 %30 %100 
                                         f32 %423 = OpLoad %422 
                                         f32 %424 = OpFNegate %423 
                                 Output f32* %425 = OpAccessChain %104 %30 %100 
                                                      OpStore %425 %424 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 130
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %91 %103 %119 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpMemberDecorate %30 5 RelaxedPrecision 
                                                      OpMemberDecorate %30 5 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %88 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %91 Location 91 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %98 RelaxedPrecision 
                                                      OpDecorate %99 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                                      OpDecorate %101 RelaxedPrecision 
                                                      OpDecorate %103 Location 103 
                                                      OpDecorate %111 RelaxedPrecision 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %117 RelaxedPrecision 
                                                      OpDecorate %119 RelaxedPrecision 
                                                      OpDecorate %119 Location 119 
                                                      OpDecorate %125 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 4 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 3 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 1 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 2 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                 Input f32_3* %91 = OpVariable Input 
                               Private f32_3* %94 = OpVariable Private 
                                          i32 %96 = OpConstant 0 
                                Private f32* %102 = OpVariable Private 
                                  Input f32* %103 = OpVariable Input 
                                         f32 %106 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                              Private f32_3* %109 = OpVariable Private 
                                             %118 = OpTypePointer Output %19 
                               Output f32_4* %119 = OpVariable Output 
                                         i32 %123 = OpConstant 5 
                                         u32 %126 = OpConstant 3 
                                             %127 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %88 = OpLoad %26 
                                        f32_3 %89 = OpLoad %66 
                                        f32_3 %90 = OpFMul %88 %89 
                                        f32_3 %92 = OpLoad %91 
                                        f32_3 %93 = OpFAdd %90 %92 
                                                      OpStore %26 %93 
                                        f32_3 %95 = OpLoad %26 
                               Uniform f32_4* %97 = OpAccessChain %32 %96 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
                                       f32_3 %100 = OpFNegate %99 
                                       f32_3 %101 = OpFAdd %95 %100 
                                                      OpStore %94 %101 
                                         f32 %104 = OpLoad %103 
                                                      OpStore %102 %104 
                                         f32 %105 = OpLoad %102 
                                         f32 %108 = OpExtInst %1 43 %105 %106 %107 
                                                      OpStore %102 %108 
                                         f32 %110 = OpLoad %102 
                                       f32_3 %111 = OpCompositeConstruct %110 %110 %110 
                                       f32_3 %112 = OpLoad %94 
                                       f32_3 %113 = OpFMul %111 %112 
                              Uniform f32_4* %114 = OpAccessChain %32 %96 
                                       f32_4 %115 = OpLoad %114 
                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
                                       f32_3 %117 = OpFAdd %113 %116 
                                                      OpStore %109 %117 
                                       f32_3 %120 = OpLoad %109 
                                       f32_4 %121 = OpLoad %119 
                                       f32_4 %122 = OpVectorShuffle %121 %120 4 5 6 3 
                                                      OpStore %119 %122 
                                Uniform f32* %124 = OpAccessChain %32 %123 
                                         f32 %125 = OpLoad %124 
                                 Output f32* %128 = OpAccessChain %119 %126 
                                                      OpStore %128 %125 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "vulkan hw_tier01 " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 427
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %129 %141 %143 %146 %188 %273 %284 %407 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 RelaxedPrecision 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpMemberDecorate %21 17 RelaxedPrecision 
                                                      OpMemberDecorate %21 17 Offset 21 
                                                      OpMemberDecorate %21 18 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %129 Location 129 
                                                      OpDecorate %141 RelaxedPrecision 
                                                      OpDecorate %141 Location 141 
                                                      OpDecorate %143 RelaxedPrecision 
                                                      OpDecorate %143 Location 143 
                                                      OpDecorate %144 RelaxedPrecision 
                                                      OpDecorate %146 RelaxedPrecision 
                                                      OpDecorate %146 Location 146 
                                                      OpDecorate %147 RelaxedPrecision 
                                                      OpDecorate %155 RelaxedPrecision 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %180 RelaxedPrecision 
                                                      OpDecorate %185 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %188 Location 188 
                                                      OpDecorate %189 RelaxedPrecision 
                                                      OpDecorate %190 RelaxedPrecision 
                                                      OpDecorate %192 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %224 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %227 RelaxedPrecision 
                                                      OpDecorate %228 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %231 RelaxedPrecision 
                                                      OpDecorate %232 RelaxedPrecision 
                                                      OpDecorate %235 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %237 RelaxedPrecision 
                                                      OpDecorate %238 RelaxedPrecision 
                                                      OpDecorate %239 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %241 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %243 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %247 RelaxedPrecision 
                                                      OpDecorate %248 RelaxedPrecision 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %255 RelaxedPrecision 
                                                      OpDecorate %256 RelaxedPrecision 
                                                      OpDecorate %259 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %265 RelaxedPrecision 
                                                      OpDecorate %267 RelaxedPrecision 
                                                      OpDecorate %269 RelaxedPrecision 
                                                      OpDecorate %270 RelaxedPrecision 
                                                      OpDecorate %271 RelaxedPrecision 
                                                      OpDecorate %273 RelaxedPrecision 
                                                      OpDecorate %273 Location 273 
                                                      OpDecorate %275 RelaxedPrecision 
                                                      OpDecorate %276 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %284 RelaxedPrecision 
                                                      OpDecorate %284 Location 284 
                                                      OpDecorate %285 RelaxedPrecision 
                                                      OpDecorate %286 RelaxedPrecision 
                                                      OpDecorate %287 RelaxedPrecision 
                                                      OpDecorate %288 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %305 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %314 RelaxedPrecision 
                                                      OpDecorate %315 RelaxedPrecision 
                                                      OpDecorate %319 RelaxedPrecision 
                                                      OpDecorate %320 RelaxedPrecision 
                                                      OpDecorate %321 RelaxedPrecision 
                                                      OpDecorate %325 RelaxedPrecision 
                                                      OpDecorate %326 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %335 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %340 RelaxedPrecision 
                                                      OpDecorate %345 RelaxedPrecision 
                                                      OpDecorate %351 RelaxedPrecision 
                                                      OpDecorate %355 RelaxedPrecision 
                                                      OpDecorate %356 RelaxedPrecision 
                                                      OpDecorate %357 RelaxedPrecision 
                                                      OpDecorate %358 RelaxedPrecision 
                                                      OpDecorate %360 RelaxedPrecision 
                                                      OpDecorate %361 RelaxedPrecision 
                                                      OpDecorate %362 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %398 RelaxedPrecision 
                                                      OpDecorate %400 RelaxedPrecision 
                                                      OpDecorate %407 RelaxedPrecision 
                                                      OpDecorate %407 Location 407 
                                                      OpDecorate %408 RelaxedPrecision 
                                                      OpDecorate %411 RelaxedPrecision 
                                                      OpDecorate %413 RelaxedPrecision 
                                                      OpDecorate %415 RelaxedPrecision 
                                                      OpDecorate %416 RelaxedPrecision 
                                                      OpDecorate %417 RelaxedPrecision 
                                                      OpDecorate %418 RelaxedPrecision 
                                                      OpDecorate %419 RelaxedPrecision 
                                                      OpDecorate %420 RelaxedPrecision 
                                                      OpDecorate %421 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %7 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 9 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 11 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypePointer Private %6 
                                Private f32* %109 = OpVariable Private 
                                         u32 %110 = OpConstant 2 
                                             %113 = OpTypePointer Uniform %6 
                                         f32 %119 = OpConstant 3.67402E-40 
                                         f32 %126 = OpConstant 3.67402E-40 
                                             %128 = OpTypePointer Output %6 
                                 Output f32* %129 = OpVariable Output 
                                         i32 %131 = OpConstant 12 
                                         u32 %135 = OpConstant 3 
                                             %139 = OpTypeVector %6 2 
                                             %140 = OpTypePointer Output %139 
                               Output f32_2* %141 = OpVariable Output 
                                             %142 = OpTypePointer Input %139 
                                Input f32_2* %143 = OpVariable Input 
                                             %145 = OpTypePointer Input %14 
                                Input f32_3* %146 = OpVariable Input 
                                         i32 %148 = OpConstant 10 
                                         u32 %153 = OpConstant 0 
                                             %179 = OpTypePointer Private %14 
                              Private f32_3* %180 = OpVariable Private 
                                         i32 %183 = OpConstant 13 
                               Output f32_2* %188 = OpVariable Output 
                                       f32_2 %191 = OpConstantComposite %126 %126 
                                Private f32* %215 = OpVariable Private 
                                         f32 %223 = OpConstant 3.67402E-40 
                                         f32 %226 = OpConstant 3.67402E-40 
                              Private f32_3* %230 = OpVariable Private 
                                         i32 %233 = OpConstant 17 
                                Private f32* %262 = OpVariable Private 
                                         i32 %263 = OpConstant 15 
                                         f32 %266 = OpConstant 3.67402E-40 
                                 Output f32* %273 = OpVariable Output 
                                         i32 %277 = OpConstant 18 
                                             %278 = OpTypePointer Uniform %20 
                                             %283 = OpTypePointer Output %14 
                               Output f32_3* %284 = OpVariable Output 
                              Private f32_4* %305 = OpVariable Private 
                                         i32 %311 = OpConstant 5 
                                         i32 %317 = OpConstant 6 
                                         i32 %323 = OpConstant 7 
                                         i32 %329 = OpConstant 8 
                                         i32 %349 = OpConstant 4 
                                       f32_3 %359 = OpConstantComposite %126 %126 %126 
                                         f32 %367 = OpConstant 3.67402E-40 
                                       f32_3 %368 = OpConstantComposite %367 %367 %367 
                                         f32 %379 = OpConstant 3.67402E-40 
                                       f32_3 %380 = OpConstantComposite %379 %379 %379 
                                         f32 %382 = OpConstant 3.67402E-40 
                                       f32_3 %383 = OpConstantComposite %382 %382 %382 
                                         i32 %394 = OpConstant 14 
                               Output f32_3* %407 = OpVariable Output 
                                         i32 %409 = OpConstant 16 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                Private f32* %111 = OpAccessChain %46 %110 
                                         f32 %112 = OpLoad %111 
                                Uniform f32* %114 = OpAccessChain %23 %25 %100 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFDiv %112 %115 
                                                      OpStore %109 %116 
                                         f32 %117 = OpLoad %109 
                                         f32 %118 = OpFNegate %117 
                                         f32 %120 = OpFAdd %118 %119 
                                                      OpStore %109 %120 
                                         f32 %121 = OpLoad %109 
                                Uniform f32* %122 = OpAccessChain %23 %25 %110 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                                      OpStore %109 %124 
                                         f32 %125 = OpLoad %109 
                                         f32 %127 = OpExtInst %1 40 %125 %126 
                                                      OpStore %109 %127 
                                         f32 %130 = OpLoad %109 
                                Uniform f32* %132 = OpAccessChain %23 %131 %110 
                                         f32 %133 = OpLoad %132 
                                         f32 %134 = OpFMul %130 %133 
                                Uniform f32* %136 = OpAccessChain %23 %131 %135 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFAdd %134 %137 
                                                      OpStore %129 %138 
                                       f32_2 %144 = OpLoad %143 
                                                      OpStore %141 %144 
                                       f32_3 %147 = OpLoad %146 
                              Uniform f32_4* %149 = OpAccessChain %23 %148 %30 
                                       f32_4 %150 = OpLoad %149 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                         f32 %152 = OpDot %147 %151 
                                Private f32* %154 = OpAccessChain %46 %153 
                                                      OpStore %154 %152 
                                       f32_3 %155 = OpLoad %146 
                              Uniform f32_4* %156 = OpAccessChain %23 %148 %25 
                                       f32_4 %157 = OpLoad %156 
                                       f32_3 %158 = OpVectorShuffle %157 %157 0 1 2 
                                         f32 %159 = OpDot %155 %158 
                                Private f32* %160 = OpAccessChain %46 %100 
                                                      OpStore %160 %159 
                                       f32_3 %161 = OpLoad %146 
                              Uniform f32_4* %162 = OpAccessChain %23 %148 %38 
                                       f32_4 %163 = OpLoad %162 
                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
                                         f32 %165 = OpDot %161 %164 
                                Private f32* %166 = OpAccessChain %46 %110 
                                                      OpStore %166 %165 
                                       f32_4 %167 = OpLoad %46 
                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
                                       f32_4 %169 = OpLoad %46 
                                       f32_3 %170 = OpVectorShuffle %169 %169 0 1 2 
                                         f32 %171 = OpDot %168 %170 
                                                      OpStore %109 %171 
                                         f32 %172 = OpLoad %109 
                                         f32 %173 = OpExtInst %1 32 %172 
                                                      OpStore %109 %173 
                                         f32 %174 = OpLoad %109 
                                       f32_4 %175 = OpCompositeConstruct %174 %174 %174 %174 
                                       f32_4 %176 = OpLoad %46 
                                       f32_4 %177 = OpVectorShuffle %176 %176 0 1 2 2 
                                       f32_4 %178 = OpFMul %175 %177 
                                                      OpStore %46 %178 
                                       f32_4 %181 = OpLoad %46 
                                       f32_3 %182 = OpVectorShuffle %181 %181 0 1 2 
                              Uniform f32_3* %184 = OpAccessChain %23 %183 
                                       f32_3 %185 = OpLoad %184 
                                         f32 %186 = OpDot %182 %185 
                                Private f32* %187 = OpAccessChain %180 %153 
                                                      OpStore %187 %186 
                                       f32_3 %189 = OpLoad %180 
                                       f32_2 %190 = OpVectorShuffle %189 %189 0 0 
                                       f32_2 %192 = OpExtInst %1 40 %190 %191 
                                                      OpStore %188 %192 
                                       f32_4 %193 = OpLoad %9 
                                       f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
                                       f32_4 %195 = OpLoad %9 
                                       f32_3 %196 = OpVectorShuffle %195 %195 0 1 2 
                                         f32 %197 = OpDot %194 %196 
                                                      OpStore %109 %197 
                                         f32 %198 = OpLoad %109 
                                         f32 %199 = OpExtInst %1 32 %198 
                                                      OpStore %109 %199 
                                       f32_4 %200 = OpLoad %9 
                                       f32_3 %201 = OpVectorShuffle %200 %200 0 1 2 
                                         f32 %202 = OpLoad %109 
                                       f32_3 %203 = OpCompositeConstruct %202 %202 %202 
                                       f32_3 %204 = OpFMul %201 %203 
                              Uniform f32_3* %205 = OpAccessChain %23 %183 
                                       f32_3 %206 = OpLoad %205 
                                       f32_3 %207 = OpFAdd %204 %206 
                                                      OpStore %180 %207 
                                         f32 %208 = OpLoad %109 
                                       f32_3 %209 = OpCompositeConstruct %208 %208 %208 
                                       f32_4 %210 = OpLoad %9 
                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
                                       f32_3 %212 = OpFMul %209 %211 
                                       f32_4 %213 = OpLoad %9 
                                       f32_4 %214 = OpVectorShuffle %213 %212 4 5 6 3 
                                                      OpStore %9 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
                                       f32_4 %218 = OpLoad %46 
                                       f32_3 %219 = OpVectorShuffle %218 %218 0 1 3 
                                         f32 %220 = OpDot %217 %219 
                                                      OpStore %215 %220 
                                         f32 %221 = OpLoad %215 
                                         f32 %222 = OpFNegate %221 
                                         f32 %224 = OpFAdd %222 %223 
                                                      OpStore %215 %224 
                                         f32 %225 = OpLoad %215 
                                         f32 %227 = OpFMul %225 %226 
                                                      OpStore %215 %227 
                                         f32 %228 = OpLoad %215 
                                         f32 %229 = OpExtInst %1 43 %228 %126 %119 
                                                      OpStore %215 %229 
                                         f32 %231 = OpLoad %215 
                                       f32_3 %232 = OpCompositeConstruct %231 %231 %231 
                              Uniform f32_3* %234 = OpAccessChain %23 %233 
                                       f32_3 %235 = OpLoad %234 
                                       f32_3 %236 = OpFMul %232 %235 
                                                      OpStore %230 %236 
                                       f32_3 %237 = OpLoad %230 
                                       f32_3 %238 = OpLoad %230 
                                       f32_3 %239 = OpFAdd %237 %238 
                                                      OpStore %230 %239 
                                       f32_3 %240 = OpLoad %180 
                                       f32_3 %241 = OpLoad %180 
                                         f32 %242 = OpDot %240 %241 
                                                      OpStore %215 %242 
                                         f32 %243 = OpLoad %215 
                                         f32 %244 = OpExtInst %1 32 %243 
                                                      OpStore %215 %244 
                                         f32 %245 = OpLoad %215 
                                       f32_3 %246 = OpCompositeConstruct %245 %245 %245 
                                       f32_3 %247 = OpLoad %180 
                                       f32_3 %248 = OpFMul %246 %247 
                                                      OpStore %180 %248 
                                       f32_4 %249 = OpLoad %46 
                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
                                       f32_3 %251 = OpLoad %180 
                                         f32 %252 = OpDot %250 %251 
                                Private f32* %253 = OpAccessChain %180 %153 
                                                      OpStore %253 %252 
                                Private f32* %254 = OpAccessChain %180 %153 
                                         f32 %255 = OpLoad %254 
                                         f32 %256 = OpExtInst %1 40 %255 %126 
                                Private f32* %257 = OpAccessChain %180 %153 
                                                      OpStore %257 %256 
                                Private f32* %258 = OpAccessChain %180 %153 
                                         f32 %259 = OpLoad %258 
                                         f32 %260 = OpExtInst %1 30 %259 
                                Private f32* %261 = OpAccessChain %180 %153 
                                                      OpStore %261 %260 
                                Uniform f32* %264 = OpAccessChain %23 %263 
                                         f32 %265 = OpLoad %264 
                                         f32 %267 = OpFMul %265 %266 
                                                      OpStore %262 %267 
                                Private f32* %268 = OpAccessChain %180 %153 
                                         f32 %269 = OpLoad %268 
                                         f32 %270 = OpLoad %262 
                                         f32 %271 = OpFMul %269 %270 
                                Private f32* %272 = OpAccessChain %180 %153 
                                                      OpStore %272 %271 
                                Private f32* %274 = OpAccessChain %180 %153 
                                         f32 %275 = OpLoad %274 
                                         f32 %276 = OpExtInst %1 29 %275 
                                                      OpStore %273 %276 
                                Uniform i32* %279 = OpAccessChain %23 %277 
                                         i32 %280 = OpLoad %279 
                                         f32 %281 = OpConvertSToF %280 
                                Private f32* %282 = OpAccessChain %180 %153 
                                                      OpStore %282 %281 
                                       f32_3 %285 = OpLoad %180 
                                       f32_3 %286 = OpVectorShuffle %285 %285 0 0 0 
                                       f32_3 %287 = OpLoad %230 
                                       f32_3 %288 = OpFMul %286 %287 
                                                      OpStore %284 %288 
                                Private f32* %289 = OpAccessChain %46 %100 
                                         f32 %290 = OpLoad %289 
                                Private f32* %291 = OpAccessChain %46 %100 
                                         f32 %292 = OpLoad %291 
                                         f32 %293 = OpFMul %290 %292 
                                Private f32* %294 = OpAccessChain %180 %153 
                                                      OpStore %294 %293 
                                Private f32* %295 = OpAccessChain %46 %153 
                                         f32 %296 = OpLoad %295 
                                Private f32* %297 = OpAccessChain %46 %153 
                                         f32 %298 = OpLoad %297 
                                         f32 %299 = OpFMul %296 %298 
                                Private f32* %300 = OpAccessChain %180 %153 
                                         f32 %301 = OpLoad %300 
                                         f32 %302 = OpFNegate %301 
                                         f32 %303 = OpFAdd %299 %302 
                                Private f32* %304 = OpAccessChain %180 %153 
                                                      OpStore %304 %303 
                                       f32_4 %306 = OpLoad %46 
                                       f32_4 %307 = OpVectorShuffle %306 %306 1 2 3 0 
                                       f32_4 %308 = OpLoad %46 
                                       f32_4 %309 = OpVectorShuffle %308 %308 0 1 3 2 
                                       f32_4 %310 = OpFMul %307 %309 
                                                      OpStore %305 %310 
                              Uniform f32_4* %312 = OpAccessChain %23 %311 
                                       f32_4 %313 = OpLoad %312 
                                       f32_4 %314 = OpLoad %305 
                                         f32 %315 = OpDot %313 %314 
                                Private f32* %316 = OpAccessChain %230 %153 
                                                      OpStore %316 %315 
                              Uniform f32_4* %318 = OpAccessChain %23 %317 
                                       f32_4 %319 = OpLoad %318 
                                       f32_4 %320 = OpLoad %305 
                                         f32 %321 = OpDot %319 %320 
                                Private f32* %322 = OpAccessChain %230 %100 
                                                      OpStore %322 %321 
                              Uniform f32_4* %324 = OpAccessChain %23 %323 
                                       f32_4 %325 = OpLoad %324 
                                       f32_4 %326 = OpLoad %305 
                                         f32 %327 = OpDot %325 %326 
                                Private f32* %328 = OpAccessChain %230 %110 
                                                      OpStore %328 %327 
                              Uniform f32_4* %330 = OpAccessChain %23 %329 
                                       f32_4 %331 = OpLoad %330 
                                       f32_3 %332 = OpVectorShuffle %331 %331 0 1 2 
                                       f32_3 %333 = OpLoad %180 
                                       f32_3 %334 = OpVectorShuffle %333 %333 0 0 0 
                                       f32_3 %335 = OpFMul %332 %334 
                                       f32_3 %336 = OpLoad %230 
                                       f32_3 %337 = OpFAdd %335 %336 
                                                      OpStore %180 %337 
                                Private f32* %338 = OpAccessChain %46 %135 
                                                      OpStore %338 %119 
                              Uniform f32_4* %339 = OpAccessChain %23 %38 
                                       f32_4 %340 = OpLoad %339 
                                       f32_4 %341 = OpLoad %46 
                                         f32 %342 = OpDot %340 %341 
                                Private f32* %343 = OpAccessChain %230 %153 
                                                      OpStore %343 %342 
                              Uniform f32_4* %344 = OpAccessChain %23 %48 
                                       f32_4 %345 = OpLoad %344 
                                       f32_4 %346 = OpLoad %46 
                                         f32 %347 = OpDot %345 %346 
                                Private f32* %348 = OpAccessChain %230 %100 
                                                      OpStore %348 %347 
                              Uniform f32_4* %350 = OpAccessChain %23 %349 
                                       f32_4 %351 = OpLoad %350 
                                       f32_4 %352 = OpLoad %46 
                                         f32 %353 = OpDot %351 %352 
                                Private f32* %354 = OpAccessChain %230 %110 
                                                      OpStore %354 %353 
                                       f32_3 %355 = OpLoad %180 
                                       f32_3 %356 = OpLoad %230 
                                       f32_3 %357 = OpFAdd %355 %356 
                                                      OpStore %180 %357 
                                       f32_3 %358 = OpLoad %180 
                                       f32_3 %360 = OpExtInst %1 40 %358 %359 
                                                      OpStore %180 %360 
                                       f32_3 %361 = OpLoad %180 
                                       f32_3 %362 = OpExtInst %1 30 %361 
                                       f32_4 %363 = OpLoad %46 
                                       f32_4 %364 = OpVectorShuffle %363 %362 4 5 6 3 
                                                      OpStore %46 %364 
                                       f32_4 %365 = OpLoad %46 
                                       f32_3 %366 = OpVectorShuffle %365 %365 0 1 2 
                                       f32_3 %369 = OpFMul %366 %368 
                                       f32_4 %370 = OpLoad %46 
                                       f32_4 %371 = OpVectorShuffle %370 %369 4 5 6 3 
                                                      OpStore %46 %371 
                                       f32_4 %372 = OpLoad %46 
                                       f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
                                       f32_3 %374 = OpExtInst %1 29 %373 
                                       f32_4 %375 = OpLoad %46 
                                       f32_4 %376 = OpVectorShuffle %375 %374 4 5 6 3 
                                                      OpStore %46 %376 
                                       f32_4 %377 = OpLoad %46 
                                       f32_3 %378 = OpVectorShuffle %377 %377 0 1 2 
                                       f32_3 %381 = OpFMul %378 %380 
                                       f32_3 %384 = OpFAdd %381 %383 
                                       f32_4 %385 = OpLoad %46 
                                       f32_4 %386 = OpVectorShuffle %385 %384 4 5 6 3 
                                                      OpStore %46 %386 
                                       f32_4 %387 = OpLoad %46 
                                       f32_3 %388 = OpVectorShuffle %387 %387 0 1 2 
                                       f32_3 %389 = OpExtInst %1 40 %388 %359 
                                       f32_4 %390 = OpLoad %46 
                                       f32_4 %391 = OpVectorShuffle %390 %389 4 5 6 3 
                                                      OpStore %46 %391 
                                       f32_4 %392 = OpLoad %46 
                                       f32_3 %393 = OpVectorShuffle %392 %392 0 1 2 
                                Uniform f32* %395 = OpAccessChain %23 %394 
                                         f32 %396 = OpLoad %395 
                                Uniform f32* %397 = OpAccessChain %23 %394 
                                         f32 %398 = OpLoad %397 
                                Uniform f32* %399 = OpAccessChain %23 %394 
                                         f32 %400 = OpLoad %399 
                                       f32_3 %401 = OpCompositeConstruct %396 %398 %400 
                                         f32 %402 = OpCompositeExtract %401 0 
                                         f32 %403 = OpCompositeExtract %401 1 
                                         f32 %404 = OpCompositeExtract %401 2 
                                       f32_3 %405 = OpCompositeConstruct %402 %403 %404 
                                       f32_3 %406 = OpFMul %393 %405 
                                                      OpStore %180 %406 
                                       f32_3 %408 = OpLoad %180 
                                Uniform f32* %410 = OpAccessChain %23 %409 
                                         f32 %411 = OpLoad %410 
                                Uniform f32* %412 = OpAccessChain %23 %409 
                                         f32 %413 = OpLoad %412 
                                Uniform f32* %414 = OpAccessChain %23 %409 
                                         f32 %415 = OpLoad %414 
                                       f32_3 %416 = OpCompositeConstruct %411 %413 %415 
                                         f32 %417 = OpCompositeExtract %416 0 
                                         f32 %418 = OpCompositeExtract %416 1 
                                         f32 %419 = OpCompositeExtract %416 2 
                                       f32_3 %420 = OpCompositeConstruct %417 %418 %419 
                                       f32_3 %421 = OpFMul %408 %420 
                                                      OpStore %407 %421 
                                 Output f32* %422 = OpAccessChain %104 %30 %100 
                                         f32 %423 = OpLoad %422 
                                         f32 %424 = OpFNegate %423 
                                 Output f32* %425 = OpAccessChain %104 %30 %100 
                                                      OpStore %425 %424 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 130
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %91 %103 %119 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpMemberDecorate %30 5 RelaxedPrecision 
                                                      OpMemberDecorate %30 5 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %88 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %91 Location 91 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %98 RelaxedPrecision 
                                                      OpDecorate %99 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                                      OpDecorate %101 RelaxedPrecision 
                                                      OpDecorate %103 Location 103 
                                                      OpDecorate %111 RelaxedPrecision 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %117 RelaxedPrecision 
                                                      OpDecorate %119 RelaxedPrecision 
                                                      OpDecorate %119 Location 119 
                                                      OpDecorate %125 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 4 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 3 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 1 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 2 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                 Input f32_3* %91 = OpVariable Input 
                               Private f32_3* %94 = OpVariable Private 
                                          i32 %96 = OpConstant 0 
                                Private f32* %102 = OpVariable Private 
                                  Input f32* %103 = OpVariable Input 
                                         f32 %106 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                              Private f32_3* %109 = OpVariable Private 
                                             %118 = OpTypePointer Output %19 
                               Output f32_4* %119 = OpVariable Output 
                                         i32 %123 = OpConstant 5 
                                         u32 %126 = OpConstant 3 
                                             %127 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %88 = OpLoad %26 
                                        f32_3 %89 = OpLoad %66 
                                        f32_3 %90 = OpFMul %88 %89 
                                        f32_3 %92 = OpLoad %91 
                                        f32_3 %93 = OpFAdd %90 %92 
                                                      OpStore %26 %93 
                                        f32_3 %95 = OpLoad %26 
                               Uniform f32_4* %97 = OpAccessChain %32 %96 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
                                       f32_3 %100 = OpFNegate %99 
                                       f32_3 %101 = OpFAdd %95 %100 
                                                      OpStore %94 %101 
                                         f32 %104 = OpLoad %103 
                                                      OpStore %102 %104 
                                         f32 %105 = OpLoad %102 
                                         f32 %108 = OpExtInst %1 43 %105 %106 %107 
                                                      OpStore %102 %108 
                                         f32 %110 = OpLoad %102 
                                       f32_3 %111 = OpCompositeConstruct %110 %110 %110 
                                       f32_3 %112 = OpLoad %94 
                                       f32_3 %113 = OpFMul %111 %112 
                              Uniform f32_4* %114 = OpAccessChain %32 %96 
                                       f32_4 %115 = OpLoad %114 
                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
                                       f32_3 %117 = OpFAdd %113 %116 
                                                      OpStore %109 %117 
                                       f32_3 %120 = OpLoad %109 
                                       f32_4 %121 = OpLoad %119 
                                       f32_4 %122 = OpVectorShuffle %121 %120 4 5 6 3 
                                                      OpStore %119 %122 
                                Uniform f32* %124 = OpAccessChain %32 %123 
                                         f32 %125 = OpLoad %124 
                                 Output f32* %128 = OpAccessChain %119 %126 
                                                      OpStore %128 %125 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "vulkan hw_tier02 " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 427
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %104 %129 %141 %143 %146 %188 %273 %284 %407 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpDecorate %19 ArrayStride 19 
                                                      OpMemberDecorate %21 0 Offset 21 
                                                      OpMemberDecorate %21 1 Offset 21 
                                                      OpMemberDecorate %21 2 RelaxedPrecision 
                                                      OpMemberDecorate %21 2 Offset 21 
                                                      OpMemberDecorate %21 3 RelaxedPrecision 
                                                      OpMemberDecorate %21 3 Offset 21 
                                                      OpMemberDecorate %21 4 RelaxedPrecision 
                                                      OpMemberDecorate %21 4 Offset 21 
                                                      OpMemberDecorate %21 5 RelaxedPrecision 
                                                      OpMemberDecorate %21 5 Offset 21 
                                                      OpMemberDecorate %21 6 RelaxedPrecision 
                                                      OpMemberDecorate %21 6 Offset 21 
                                                      OpMemberDecorate %21 7 RelaxedPrecision 
                                                      OpMemberDecorate %21 7 Offset 21 
                                                      OpMemberDecorate %21 8 RelaxedPrecision 
                                                      OpMemberDecorate %21 8 Offset 21 
                                                      OpMemberDecorate %21 9 Offset 21 
                                                      OpMemberDecorate %21 10 Offset 21 
                                                      OpMemberDecorate %21 11 Offset 21 
                                                      OpMemberDecorate %21 12 Offset 21 
                                                      OpMemberDecorate %21 13 RelaxedPrecision 
                                                      OpMemberDecorate %21 13 Offset 21 
                                                      OpMemberDecorate %21 14 RelaxedPrecision 
                                                      OpMemberDecorate %21 14 Offset 21 
                                                      OpMemberDecorate %21 15 RelaxedPrecision 
                                                      OpMemberDecorate %21 15 Offset 21 
                                                      OpMemberDecorate %21 16 RelaxedPrecision 
                                                      OpMemberDecorate %21 16 Offset 21 
                                                      OpMemberDecorate %21 17 RelaxedPrecision 
                                                      OpMemberDecorate %21 17 Offset 21 
                                                      OpMemberDecorate %21 18 Offset 21 
                                                      OpDecorate %21 Block 
                                                      OpDecorate %23 DescriptorSet 23 
                                                      OpDecorate %23 Binding 23 
                                                      OpDecorate %33 RelaxedPrecision 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpMemberDecorate %102 0 BuiltIn 102 
                                                      OpMemberDecorate %102 1 BuiltIn 102 
                                                      OpMemberDecorate %102 2 BuiltIn 102 
                                                      OpDecorate %102 Block 
                                                      OpDecorate %129 Location 129 
                                                      OpDecorate %141 RelaxedPrecision 
                                                      OpDecorate %141 Location 141 
                                                      OpDecorate %143 RelaxedPrecision 
                                                      OpDecorate %143 Location 143 
                                                      OpDecorate %144 RelaxedPrecision 
                                                      OpDecorate %146 RelaxedPrecision 
                                                      OpDecorate %146 Location 146 
                                                      OpDecorate %147 RelaxedPrecision 
                                                      OpDecorate %155 RelaxedPrecision 
                                                      OpDecorate %161 RelaxedPrecision 
                                                      OpDecorate %180 RelaxedPrecision 
                                                      OpDecorate %185 RelaxedPrecision 
                                                      OpDecorate %188 RelaxedPrecision 
                                                      OpDecorate %188 Location 188 
                                                      OpDecorate %189 RelaxedPrecision 
                                                      OpDecorate %190 RelaxedPrecision 
                                                      OpDecorate %192 RelaxedPrecision 
                                                      OpDecorate %206 RelaxedPrecision 
                                                      OpDecorate %215 RelaxedPrecision 
                                                      OpDecorate %221 RelaxedPrecision 
                                                      OpDecorate %222 RelaxedPrecision 
                                                      OpDecorate %224 RelaxedPrecision 
                                                      OpDecorate %225 RelaxedPrecision 
                                                      OpDecorate %227 RelaxedPrecision 
                                                      OpDecorate %228 RelaxedPrecision 
                                                      OpDecorate %229 RelaxedPrecision 
                                                      OpDecorate %230 RelaxedPrecision 
                                                      OpDecorate %231 RelaxedPrecision 
                                                      OpDecorate %232 RelaxedPrecision 
                                                      OpDecorate %235 RelaxedPrecision 
                                                      OpDecorate %236 RelaxedPrecision 
                                                      OpDecorate %237 RelaxedPrecision 
                                                      OpDecorate %238 RelaxedPrecision 
                                                      OpDecorate %239 RelaxedPrecision 
                                                      OpDecorate %240 RelaxedPrecision 
                                                      OpDecorate %241 RelaxedPrecision 
                                                      OpDecorate %242 RelaxedPrecision 
                                                      OpDecorate %243 RelaxedPrecision 
                                                      OpDecorate %244 RelaxedPrecision 
                                                      OpDecorate %245 RelaxedPrecision 
                                                      OpDecorate %246 RelaxedPrecision 
                                                      OpDecorate %247 RelaxedPrecision 
                                                      OpDecorate %248 RelaxedPrecision 
                                                      OpDecorate %251 RelaxedPrecision 
                                                      OpDecorate %255 RelaxedPrecision 
                                                      OpDecorate %256 RelaxedPrecision 
                                                      OpDecorate %259 RelaxedPrecision 
                                                      OpDecorate %260 RelaxedPrecision 
                                                      OpDecorate %262 RelaxedPrecision 
                                                      OpDecorate %265 RelaxedPrecision 
                                                      OpDecorate %267 RelaxedPrecision 
                                                      OpDecorate %269 RelaxedPrecision 
                                                      OpDecorate %270 RelaxedPrecision 
                                                      OpDecorate %271 RelaxedPrecision 
                                                      OpDecorate %273 RelaxedPrecision 
                                                      OpDecorate %273 Location 273 
                                                      OpDecorate %275 RelaxedPrecision 
                                                      OpDecorate %276 RelaxedPrecision 
                                                      OpDecorate %281 RelaxedPrecision 
                                                      OpDecorate %284 RelaxedPrecision 
                                                      OpDecorate %284 Location 284 
                                                      OpDecorate %285 RelaxedPrecision 
                                                      OpDecorate %286 RelaxedPrecision 
                                                      OpDecorate %287 RelaxedPrecision 
                                                      OpDecorate %288 RelaxedPrecision 
                                                      OpDecorate %301 RelaxedPrecision 
                                                      OpDecorate %302 RelaxedPrecision 
                                                      OpDecorate %305 RelaxedPrecision 
                                                      OpDecorate %313 RelaxedPrecision 
                                                      OpDecorate %314 RelaxedPrecision 
                                                      OpDecorate %315 RelaxedPrecision 
                                                      OpDecorate %319 RelaxedPrecision 
                                                      OpDecorate %320 RelaxedPrecision 
                                                      OpDecorate %321 RelaxedPrecision 
                                                      OpDecorate %325 RelaxedPrecision 
                                                      OpDecorate %326 RelaxedPrecision 
                                                      OpDecorate %327 RelaxedPrecision 
                                                      OpDecorate %331 RelaxedPrecision 
                                                      OpDecorate %332 RelaxedPrecision 
                                                      OpDecorate %333 RelaxedPrecision 
                                                      OpDecorate %334 RelaxedPrecision 
                                                      OpDecorate %335 RelaxedPrecision 
                                                      OpDecorate %336 RelaxedPrecision 
                                                      OpDecorate %337 RelaxedPrecision 
                                                      OpDecorate %340 RelaxedPrecision 
                                                      OpDecorate %345 RelaxedPrecision 
                                                      OpDecorate %351 RelaxedPrecision 
                                                      OpDecorate %355 RelaxedPrecision 
                                                      OpDecorate %356 RelaxedPrecision 
                                                      OpDecorate %357 RelaxedPrecision 
                                                      OpDecorate %358 RelaxedPrecision 
                                                      OpDecorate %360 RelaxedPrecision 
                                                      OpDecorate %361 RelaxedPrecision 
                                                      OpDecorate %362 RelaxedPrecision 
                                                      OpDecorate %396 RelaxedPrecision 
                                                      OpDecorate %398 RelaxedPrecision 
                                                      OpDecorate %400 RelaxedPrecision 
                                                      OpDecorate %407 RelaxedPrecision 
                                                      OpDecorate %407 Location 407 
                                                      OpDecorate %408 RelaxedPrecision 
                                                      OpDecorate %411 RelaxedPrecision 
                                                      OpDecorate %413 RelaxedPrecision 
                                                      OpDecorate %415 RelaxedPrecision 
                                                      OpDecorate %416 RelaxedPrecision 
                                                      OpDecorate %417 RelaxedPrecision 
                                                      OpDecorate %418 RelaxedPrecision 
                                                      OpDecorate %419 RelaxedPrecision 
                                                      OpDecorate %420 RelaxedPrecision 
                                                      OpDecorate %421 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeVector %6 3 
                                              %15 = OpTypeInt 32 0 
                                          u32 %16 = OpConstant 4 
                                              %17 = OpTypeArray %7 %16 
                                              %18 = OpTypeArray %7 %16 
                                              %19 = OpTypeArray %7 %16 
                                              %20 = OpTypeInt 32 1 
                                              %21 = OpTypeStruct %14 %7 %7 %7 %7 %7 %7 %7 %7 %17 %18 %19 %7 %14 %6 %6 %6 %14 %20 
                                              %22 = OpTypePointer Uniform %21 
Uniform struct {f32_3; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_3; f32; f32; f32; f32_3; i32;}* %23 = OpVariable Uniform 
                                          i32 %24 = OpConstant 9 
                                          i32 %25 = OpConstant 1 
                                              %26 = OpTypePointer Uniform %7 
                                          i32 %30 = OpConstant 0 
                                          i32 %38 = OpConstant 2 
                               Private f32_4* %46 = OpVariable Private 
                                          i32 %48 = OpConstant 3 
                                              %66 = OpTypePointer Uniform %14 
                               Private f32_4* %72 = OpVariable Private 
                                          i32 %75 = OpConstant 11 
                                         u32 %100 = OpConstant 1 
                                             %101 = OpTypeArray %6 %100 
                                             %102 = OpTypeStruct %7 %6 %101 
                                             %103 = OpTypePointer Output %102 
        Output struct {f32_4; f32; f32[1];}* %104 = OpVariable Output 
                                             %106 = OpTypePointer Output %7 
                                             %108 = OpTypePointer Private %6 
                                Private f32* %109 = OpVariable Private 
                                         u32 %110 = OpConstant 2 
                                             %113 = OpTypePointer Uniform %6 
                                         f32 %119 = OpConstant 3.67402E-40 
                                         f32 %126 = OpConstant 3.67402E-40 
                                             %128 = OpTypePointer Output %6 
                                 Output f32* %129 = OpVariable Output 
                                         i32 %131 = OpConstant 12 
                                         u32 %135 = OpConstant 3 
                                             %139 = OpTypeVector %6 2 
                                             %140 = OpTypePointer Output %139 
                               Output f32_2* %141 = OpVariable Output 
                                             %142 = OpTypePointer Input %139 
                                Input f32_2* %143 = OpVariable Input 
                                             %145 = OpTypePointer Input %14 
                                Input f32_3* %146 = OpVariable Input 
                                         i32 %148 = OpConstant 10 
                                         u32 %153 = OpConstant 0 
                                             %179 = OpTypePointer Private %14 
                              Private f32_3* %180 = OpVariable Private 
                                         i32 %183 = OpConstant 13 
                               Output f32_2* %188 = OpVariable Output 
                                       f32_2 %191 = OpConstantComposite %126 %126 
                                Private f32* %215 = OpVariable Private 
                                         f32 %223 = OpConstant 3.67402E-40 
                                         f32 %226 = OpConstant 3.67402E-40 
                              Private f32_3* %230 = OpVariable Private 
                                         i32 %233 = OpConstant 17 
                                Private f32* %262 = OpVariable Private 
                                         i32 %263 = OpConstant 15 
                                         f32 %266 = OpConstant 3.67402E-40 
                                 Output f32* %273 = OpVariable Output 
                                         i32 %277 = OpConstant 18 
                                             %278 = OpTypePointer Uniform %20 
                                             %283 = OpTypePointer Output %14 
                               Output f32_3* %284 = OpVariable Output 
                              Private f32_4* %305 = OpVariable Private 
                                         i32 %311 = OpConstant 5 
                                         i32 %317 = OpConstant 6 
                                         i32 %323 = OpConstant 7 
                                         i32 %329 = OpConstant 8 
                                         i32 %349 = OpConstant 4 
                                       f32_3 %359 = OpConstantComposite %126 %126 %126 
                                         f32 %367 = OpConstant 3.67402E-40 
                                       f32_3 %368 = OpConstantComposite %367 %367 %367 
                                         f32 %379 = OpConstant 3.67402E-40 
                                       f32_3 %380 = OpConstantComposite %379 %379 %379 
                                         f32 %382 = OpConstant 3.67402E-40 
                                       f32_3 %383 = OpConstantComposite %382 %382 %382 
                                         i32 %394 = OpConstant 14 
                               Output f32_3* %407 = OpVariable Output 
                                         i32 %409 = OpConstant 16 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %27 = OpAccessChain %23 %24 %25 
                                        f32_4 %28 = OpLoad %27 
                                        f32_4 %29 = OpFMul %13 %28 
                                                      OpStore %9 %29 
                               Uniform f32_4* %31 = OpAccessChain %23 %24 %30 
                                        f32_4 %32 = OpLoad %31 
                                        f32_4 %33 = OpLoad %11 
                                        f32_4 %34 = OpVectorShuffle %33 %33 0 0 0 0 
                                        f32_4 %35 = OpFMul %32 %34 
                                        f32_4 %36 = OpLoad %9 
                                        f32_4 %37 = OpFAdd %35 %36 
                                                      OpStore %9 %37 
                               Uniform f32_4* %39 = OpAccessChain %23 %24 %38 
                                        f32_4 %40 = OpLoad %39 
                                        f32_4 %41 = OpLoad %11 
                                        f32_4 %42 = OpVectorShuffle %41 %41 2 2 2 2 
                                        f32_4 %43 = OpFMul %40 %42 
                                        f32_4 %44 = OpLoad %9 
                                        f32_4 %45 = OpFAdd %43 %44 
                                                      OpStore %9 %45 
                                        f32_4 %47 = OpLoad %9 
                               Uniform f32_4* %49 = OpAccessChain %23 %24 %48 
                                        f32_4 %50 = OpLoad %49 
                                        f32_4 %51 = OpFAdd %47 %50 
                                                      OpStore %46 %51 
                               Uniform f32_4* %52 = OpAccessChain %23 %24 %48 
                                        f32_4 %53 = OpLoad %52 
                                        f32_3 %54 = OpVectorShuffle %53 %53 0 1 2 
                                        f32_4 %55 = OpLoad %11 
                                        f32_3 %56 = OpVectorShuffle %55 %55 3 3 3 
                                        f32_3 %57 = OpFMul %54 %56 
                                        f32_4 %58 = OpLoad %9 
                                        f32_3 %59 = OpVectorShuffle %58 %58 0 1 2 
                                        f32_3 %60 = OpFAdd %57 %59 
                                        f32_4 %61 = OpLoad %9 
                                        f32_4 %62 = OpVectorShuffle %61 %60 4 5 6 3 
                                                      OpStore %9 %62 
                                        f32_4 %63 = OpLoad %9 
                                        f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
                                        f32_3 %65 = OpFNegate %64 
                               Uniform f32_3* %67 = OpAccessChain %23 %30 
                                        f32_3 %68 = OpLoad %67 
                                        f32_3 %69 = OpFAdd %65 %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %9 %71 
                                        f32_4 %73 = OpLoad %46 
                                        f32_4 %74 = OpVectorShuffle %73 %73 1 1 1 1 
                               Uniform f32_4* %76 = OpAccessChain %23 %75 %25 
                                        f32_4 %77 = OpLoad %76 
                                        f32_4 %78 = OpFMul %74 %77 
                                                      OpStore %72 %78 
                               Uniform f32_4* %79 = OpAccessChain %23 %75 %30 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %46 
                                        f32_4 %82 = OpVectorShuffle %81 %81 0 0 0 0 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %72 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %72 %85 
                               Uniform f32_4* %86 = OpAccessChain %23 %75 %38 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %46 
                                        f32_4 %89 = OpVectorShuffle %88 %88 2 2 2 2 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %72 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %72 %92 
                               Uniform f32_4* %93 = OpAccessChain %23 %75 %48 
                                        f32_4 %94 = OpLoad %93 
                                        f32_4 %95 = OpLoad %46 
                                        f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
                                        f32_4 %97 = OpFMul %94 %96 
                                        f32_4 %98 = OpLoad %72 
                                        f32_4 %99 = OpFAdd %97 %98 
                                                      OpStore %46 %99 
                                       f32_4 %105 = OpLoad %46 
                               Output f32_4* %107 = OpAccessChain %104 %30 
                                                      OpStore %107 %105 
                                Private f32* %111 = OpAccessChain %46 %110 
                                         f32 %112 = OpLoad %111 
                                Uniform f32* %114 = OpAccessChain %23 %25 %100 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFDiv %112 %115 
                                                      OpStore %109 %116 
                                         f32 %117 = OpLoad %109 
                                         f32 %118 = OpFNegate %117 
                                         f32 %120 = OpFAdd %118 %119 
                                                      OpStore %109 %120 
                                         f32 %121 = OpLoad %109 
                                Uniform f32* %122 = OpAccessChain %23 %25 %110 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                                      OpStore %109 %124 
                                         f32 %125 = OpLoad %109 
                                         f32 %127 = OpExtInst %1 40 %125 %126 
                                                      OpStore %109 %127 
                                         f32 %130 = OpLoad %109 
                                Uniform f32* %132 = OpAccessChain %23 %131 %110 
                                         f32 %133 = OpLoad %132 
                                         f32 %134 = OpFMul %130 %133 
                                Uniform f32* %136 = OpAccessChain %23 %131 %135 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFAdd %134 %137 
                                                      OpStore %129 %138 
                                       f32_2 %144 = OpLoad %143 
                                                      OpStore %141 %144 
                                       f32_3 %147 = OpLoad %146 
                              Uniform f32_4* %149 = OpAccessChain %23 %148 %30 
                                       f32_4 %150 = OpLoad %149 
                                       f32_3 %151 = OpVectorShuffle %150 %150 0 1 2 
                                         f32 %152 = OpDot %147 %151 
                                Private f32* %154 = OpAccessChain %46 %153 
                                                      OpStore %154 %152 
                                       f32_3 %155 = OpLoad %146 
                              Uniform f32_4* %156 = OpAccessChain %23 %148 %25 
                                       f32_4 %157 = OpLoad %156 
                                       f32_3 %158 = OpVectorShuffle %157 %157 0 1 2 
                                         f32 %159 = OpDot %155 %158 
                                Private f32* %160 = OpAccessChain %46 %100 
                                                      OpStore %160 %159 
                                       f32_3 %161 = OpLoad %146 
                              Uniform f32_4* %162 = OpAccessChain %23 %148 %38 
                                       f32_4 %163 = OpLoad %162 
                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
                                         f32 %165 = OpDot %161 %164 
                                Private f32* %166 = OpAccessChain %46 %110 
                                                      OpStore %166 %165 
                                       f32_4 %167 = OpLoad %46 
                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
                                       f32_4 %169 = OpLoad %46 
                                       f32_3 %170 = OpVectorShuffle %169 %169 0 1 2 
                                         f32 %171 = OpDot %168 %170 
                                                      OpStore %109 %171 
                                         f32 %172 = OpLoad %109 
                                         f32 %173 = OpExtInst %1 32 %172 
                                                      OpStore %109 %173 
                                         f32 %174 = OpLoad %109 
                                       f32_4 %175 = OpCompositeConstruct %174 %174 %174 %174 
                                       f32_4 %176 = OpLoad %46 
                                       f32_4 %177 = OpVectorShuffle %176 %176 0 1 2 2 
                                       f32_4 %178 = OpFMul %175 %177 
                                                      OpStore %46 %178 
                                       f32_4 %181 = OpLoad %46 
                                       f32_3 %182 = OpVectorShuffle %181 %181 0 1 2 
                              Uniform f32_3* %184 = OpAccessChain %23 %183 
                                       f32_3 %185 = OpLoad %184 
                                         f32 %186 = OpDot %182 %185 
                                Private f32* %187 = OpAccessChain %180 %153 
                                                      OpStore %187 %186 
                                       f32_3 %189 = OpLoad %180 
                                       f32_2 %190 = OpVectorShuffle %189 %189 0 0 
                                       f32_2 %192 = OpExtInst %1 40 %190 %191 
                                                      OpStore %188 %192 
                                       f32_4 %193 = OpLoad %9 
                                       f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
                                       f32_4 %195 = OpLoad %9 
                                       f32_3 %196 = OpVectorShuffle %195 %195 0 1 2 
                                         f32 %197 = OpDot %194 %196 
                                                      OpStore %109 %197 
                                         f32 %198 = OpLoad %109 
                                         f32 %199 = OpExtInst %1 32 %198 
                                                      OpStore %109 %199 
                                       f32_4 %200 = OpLoad %9 
                                       f32_3 %201 = OpVectorShuffle %200 %200 0 1 2 
                                         f32 %202 = OpLoad %109 
                                       f32_3 %203 = OpCompositeConstruct %202 %202 %202 
                                       f32_3 %204 = OpFMul %201 %203 
                              Uniform f32_3* %205 = OpAccessChain %23 %183 
                                       f32_3 %206 = OpLoad %205 
                                       f32_3 %207 = OpFAdd %204 %206 
                                                      OpStore %180 %207 
                                         f32 %208 = OpLoad %109 
                                       f32_3 %209 = OpCompositeConstruct %208 %208 %208 
                                       f32_4 %210 = OpLoad %9 
                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
                                       f32_3 %212 = OpFMul %209 %211 
                                       f32_4 %213 = OpLoad %9 
                                       f32_4 %214 = OpVectorShuffle %213 %212 4 5 6 3 
                                                      OpStore %9 %214 
                                       f32_4 %216 = OpLoad %9 
                                       f32_3 %217 = OpVectorShuffle %216 %216 0 1 2 
                                       f32_4 %218 = OpLoad %46 
                                       f32_3 %219 = OpVectorShuffle %218 %218 0 1 3 
                                         f32 %220 = OpDot %217 %219 
                                                      OpStore %215 %220 
                                         f32 %221 = OpLoad %215 
                                         f32 %222 = OpFNegate %221 
                                         f32 %224 = OpFAdd %222 %223 
                                                      OpStore %215 %224 
                                         f32 %225 = OpLoad %215 
                                         f32 %227 = OpFMul %225 %226 
                                                      OpStore %215 %227 
                                         f32 %228 = OpLoad %215 
                                         f32 %229 = OpExtInst %1 43 %228 %126 %119 
                                                      OpStore %215 %229 
                                         f32 %231 = OpLoad %215 
                                       f32_3 %232 = OpCompositeConstruct %231 %231 %231 
                              Uniform f32_3* %234 = OpAccessChain %23 %233 
                                       f32_3 %235 = OpLoad %234 
                                       f32_3 %236 = OpFMul %232 %235 
                                                      OpStore %230 %236 
                                       f32_3 %237 = OpLoad %230 
                                       f32_3 %238 = OpLoad %230 
                                       f32_3 %239 = OpFAdd %237 %238 
                                                      OpStore %230 %239 
                                       f32_3 %240 = OpLoad %180 
                                       f32_3 %241 = OpLoad %180 
                                         f32 %242 = OpDot %240 %241 
                                                      OpStore %215 %242 
                                         f32 %243 = OpLoad %215 
                                         f32 %244 = OpExtInst %1 32 %243 
                                                      OpStore %215 %244 
                                         f32 %245 = OpLoad %215 
                                       f32_3 %246 = OpCompositeConstruct %245 %245 %245 
                                       f32_3 %247 = OpLoad %180 
                                       f32_3 %248 = OpFMul %246 %247 
                                                      OpStore %180 %248 
                                       f32_4 %249 = OpLoad %46 
                                       f32_3 %250 = OpVectorShuffle %249 %249 0 1 2 
                                       f32_3 %251 = OpLoad %180 
                                         f32 %252 = OpDot %250 %251 
                                Private f32* %253 = OpAccessChain %180 %153 
                                                      OpStore %253 %252 
                                Private f32* %254 = OpAccessChain %180 %153 
                                         f32 %255 = OpLoad %254 
                                         f32 %256 = OpExtInst %1 40 %255 %126 
                                Private f32* %257 = OpAccessChain %180 %153 
                                                      OpStore %257 %256 
                                Private f32* %258 = OpAccessChain %180 %153 
                                         f32 %259 = OpLoad %258 
                                         f32 %260 = OpExtInst %1 30 %259 
                                Private f32* %261 = OpAccessChain %180 %153 
                                                      OpStore %261 %260 
                                Uniform f32* %264 = OpAccessChain %23 %263 
                                         f32 %265 = OpLoad %264 
                                         f32 %267 = OpFMul %265 %266 
                                                      OpStore %262 %267 
                                Private f32* %268 = OpAccessChain %180 %153 
                                         f32 %269 = OpLoad %268 
                                         f32 %270 = OpLoad %262 
                                         f32 %271 = OpFMul %269 %270 
                                Private f32* %272 = OpAccessChain %180 %153 
                                                      OpStore %272 %271 
                                Private f32* %274 = OpAccessChain %180 %153 
                                         f32 %275 = OpLoad %274 
                                         f32 %276 = OpExtInst %1 29 %275 
                                                      OpStore %273 %276 
                                Uniform i32* %279 = OpAccessChain %23 %277 
                                         i32 %280 = OpLoad %279 
                                         f32 %281 = OpConvertSToF %280 
                                Private f32* %282 = OpAccessChain %180 %153 
                                                      OpStore %282 %281 
                                       f32_3 %285 = OpLoad %180 
                                       f32_3 %286 = OpVectorShuffle %285 %285 0 0 0 
                                       f32_3 %287 = OpLoad %230 
                                       f32_3 %288 = OpFMul %286 %287 
                                                      OpStore %284 %288 
                                Private f32* %289 = OpAccessChain %46 %100 
                                         f32 %290 = OpLoad %289 
                                Private f32* %291 = OpAccessChain %46 %100 
                                         f32 %292 = OpLoad %291 
                                         f32 %293 = OpFMul %290 %292 
                                Private f32* %294 = OpAccessChain %180 %153 
                                                      OpStore %294 %293 
                                Private f32* %295 = OpAccessChain %46 %153 
                                         f32 %296 = OpLoad %295 
                                Private f32* %297 = OpAccessChain %46 %153 
                                         f32 %298 = OpLoad %297 
                                         f32 %299 = OpFMul %296 %298 
                                Private f32* %300 = OpAccessChain %180 %153 
                                         f32 %301 = OpLoad %300 
                                         f32 %302 = OpFNegate %301 
                                         f32 %303 = OpFAdd %299 %302 
                                Private f32* %304 = OpAccessChain %180 %153 
                                                      OpStore %304 %303 
                                       f32_4 %306 = OpLoad %46 
                                       f32_4 %307 = OpVectorShuffle %306 %306 1 2 3 0 
                                       f32_4 %308 = OpLoad %46 
                                       f32_4 %309 = OpVectorShuffle %308 %308 0 1 3 2 
                                       f32_4 %310 = OpFMul %307 %309 
                                                      OpStore %305 %310 
                              Uniform f32_4* %312 = OpAccessChain %23 %311 
                                       f32_4 %313 = OpLoad %312 
                                       f32_4 %314 = OpLoad %305 
                                         f32 %315 = OpDot %313 %314 
                                Private f32* %316 = OpAccessChain %230 %153 
                                                      OpStore %316 %315 
                              Uniform f32_4* %318 = OpAccessChain %23 %317 
                                       f32_4 %319 = OpLoad %318 
                                       f32_4 %320 = OpLoad %305 
                                         f32 %321 = OpDot %319 %320 
                                Private f32* %322 = OpAccessChain %230 %100 
                                                      OpStore %322 %321 
                              Uniform f32_4* %324 = OpAccessChain %23 %323 
                                       f32_4 %325 = OpLoad %324 
                                       f32_4 %326 = OpLoad %305 
                                         f32 %327 = OpDot %325 %326 
                                Private f32* %328 = OpAccessChain %230 %110 
                                                      OpStore %328 %327 
                              Uniform f32_4* %330 = OpAccessChain %23 %329 
                                       f32_4 %331 = OpLoad %330 
                                       f32_3 %332 = OpVectorShuffle %331 %331 0 1 2 
                                       f32_3 %333 = OpLoad %180 
                                       f32_3 %334 = OpVectorShuffle %333 %333 0 0 0 
                                       f32_3 %335 = OpFMul %332 %334 
                                       f32_3 %336 = OpLoad %230 
                                       f32_3 %337 = OpFAdd %335 %336 
                                                      OpStore %180 %337 
                                Private f32* %338 = OpAccessChain %46 %135 
                                                      OpStore %338 %119 
                              Uniform f32_4* %339 = OpAccessChain %23 %38 
                                       f32_4 %340 = OpLoad %339 
                                       f32_4 %341 = OpLoad %46 
                                         f32 %342 = OpDot %340 %341 
                                Private f32* %343 = OpAccessChain %230 %153 
                                                      OpStore %343 %342 
                              Uniform f32_4* %344 = OpAccessChain %23 %48 
                                       f32_4 %345 = OpLoad %344 
                                       f32_4 %346 = OpLoad %46 
                                         f32 %347 = OpDot %345 %346 
                                Private f32* %348 = OpAccessChain %230 %100 
                                                      OpStore %348 %347 
                              Uniform f32_4* %350 = OpAccessChain %23 %349 
                                       f32_4 %351 = OpLoad %350 
                                       f32_4 %352 = OpLoad %46 
                                         f32 %353 = OpDot %351 %352 
                                Private f32* %354 = OpAccessChain %230 %110 
                                                      OpStore %354 %353 
                                       f32_3 %355 = OpLoad %180 
                                       f32_3 %356 = OpLoad %230 
                                       f32_3 %357 = OpFAdd %355 %356 
                                                      OpStore %180 %357 
                                       f32_3 %358 = OpLoad %180 
                                       f32_3 %360 = OpExtInst %1 40 %358 %359 
                                                      OpStore %180 %360 
                                       f32_3 %361 = OpLoad %180 
                                       f32_3 %362 = OpExtInst %1 30 %361 
                                       f32_4 %363 = OpLoad %46 
                                       f32_4 %364 = OpVectorShuffle %363 %362 4 5 6 3 
                                                      OpStore %46 %364 
                                       f32_4 %365 = OpLoad %46 
                                       f32_3 %366 = OpVectorShuffle %365 %365 0 1 2 
                                       f32_3 %369 = OpFMul %366 %368 
                                       f32_4 %370 = OpLoad %46 
                                       f32_4 %371 = OpVectorShuffle %370 %369 4 5 6 3 
                                                      OpStore %46 %371 
                                       f32_4 %372 = OpLoad %46 
                                       f32_3 %373 = OpVectorShuffle %372 %372 0 1 2 
                                       f32_3 %374 = OpExtInst %1 29 %373 
                                       f32_4 %375 = OpLoad %46 
                                       f32_4 %376 = OpVectorShuffle %375 %374 4 5 6 3 
                                                      OpStore %46 %376 
                                       f32_4 %377 = OpLoad %46 
                                       f32_3 %378 = OpVectorShuffle %377 %377 0 1 2 
                                       f32_3 %381 = OpFMul %378 %380 
                                       f32_3 %384 = OpFAdd %381 %383 
                                       f32_4 %385 = OpLoad %46 
                                       f32_4 %386 = OpVectorShuffle %385 %384 4 5 6 3 
                                                      OpStore %46 %386 
                                       f32_4 %387 = OpLoad %46 
                                       f32_3 %388 = OpVectorShuffle %387 %387 0 1 2 
                                       f32_3 %389 = OpExtInst %1 40 %388 %359 
                                       f32_4 %390 = OpLoad %46 
                                       f32_4 %391 = OpVectorShuffle %390 %389 4 5 6 3 
                                                      OpStore %46 %391 
                                       f32_4 %392 = OpLoad %46 
                                       f32_3 %393 = OpVectorShuffle %392 %392 0 1 2 
                                Uniform f32* %395 = OpAccessChain %23 %394 
                                         f32 %396 = OpLoad %395 
                                Uniform f32* %397 = OpAccessChain %23 %394 
                                         f32 %398 = OpLoad %397 
                                Uniform f32* %399 = OpAccessChain %23 %394 
                                         f32 %400 = OpLoad %399 
                                       f32_3 %401 = OpCompositeConstruct %396 %398 %400 
                                         f32 %402 = OpCompositeExtract %401 0 
                                         f32 %403 = OpCompositeExtract %401 1 
                                         f32 %404 = OpCompositeExtract %401 2 
                                       f32_3 %405 = OpCompositeConstruct %402 %403 %404 
                                       f32_3 %406 = OpFMul %393 %405 
                                                      OpStore %180 %406 
                                       f32_3 %408 = OpLoad %180 
                                Uniform f32* %410 = OpAccessChain %23 %409 
                                         f32 %411 = OpLoad %410 
                                Uniform f32* %412 = OpAccessChain %23 %409 
                                         f32 %413 = OpLoad %412 
                                Uniform f32* %414 = OpAccessChain %23 %409 
                                         f32 %415 = OpLoad %414 
                                       f32_3 %416 = OpCompositeConstruct %411 %413 %415 
                                         f32 %417 = OpCompositeExtract %416 0 
                                         f32 %418 = OpCompositeExtract %416 1 
                                         f32 %419 = OpCompositeExtract %416 2 
                                       f32_3 %420 = OpCompositeConstruct %417 %418 %419 
                                       f32_3 %421 = OpFMul %408 %420 
                                                      OpStore %407 %421 
                                 Output f32* %422 = OpAccessChain %104 %30 %100 
                                         f32 %423 = OpLoad %422 
                                         f32 %424 = OpFNegate %423 
                                 Output f32* %425 = OpAccessChain %104 %30 %100 
                                                      OpStore %425 %424 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 130
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %17 %28 %62 %82 %91 %103 %119 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %13 DescriptorSet 13 
                                                      OpDecorate %13 Binding 13 
                                                      OpDecorate %14 RelaxedPrecision 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %18 RelaxedPrecision 
                                                      OpDecorate %23 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpDecorate %28 RelaxedPrecision 
                                                      OpDecorate %28 Location 28 
                                                      OpDecorate %29 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 RelaxedPrecision 
                                                      OpMemberDecorate %30 0 Offset 30 
                                                      OpMemberDecorate %30 1 RelaxedPrecision 
                                                      OpMemberDecorate %30 1 Offset 30 
                                                      OpMemberDecorate %30 2 RelaxedPrecision 
                                                      OpMemberDecorate %30 2 Offset 30 
                                                      OpMemberDecorate %30 3 RelaxedPrecision 
                                                      OpMemberDecorate %30 3 Offset 30 
                                                      OpMemberDecorate %30 4 RelaxedPrecision 
                                                      OpMemberDecorate %30 4 Offset 30 
                                                      OpMemberDecorate %30 5 RelaxedPrecision 
                                                      OpMemberDecorate %30 5 Offset 30 
                                                      OpDecorate %30 Block 
                                                      OpDecorate %32 DescriptorSet 32 
                                                      OpDecorate %32 Binding 32 
                                                      OpDecorate %37 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %41 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %48 RelaxedPrecision 
                                                      OpDecorate %50 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %55 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %60 DescriptorSet 60 
                                                      OpDecorate %60 Binding 60 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %62 Location 62 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %65 RelaxedPrecision 
                                                      OpDecorate %66 RelaxedPrecision 
                                                      OpDecorate %67 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate %72 RelaxedPrecision 
                                                      OpDecorate %73 RelaxedPrecision 
                                                      OpDecorate %77 RelaxedPrecision 
                                                      OpDecorate %78 RelaxedPrecision 
                                                      OpDecorate %79 RelaxedPrecision 
                                                      OpDecorate %80 RelaxedPrecision 
                                                      OpDecorate %82 RelaxedPrecision 
                                                      OpDecorate %82 Location 82 
                                                      OpDecorate %83 RelaxedPrecision 
                                                      OpDecorate %84 RelaxedPrecision 
                                                      OpDecorate %85 RelaxedPrecision 
                                                      OpDecorate %86 RelaxedPrecision 
                                                      OpDecorate %87 RelaxedPrecision 
                                                      OpDecorate %88 RelaxedPrecision 
                                                      OpDecorate %89 RelaxedPrecision 
                                                      OpDecorate %90 RelaxedPrecision 
                                                      OpDecorate %91 RelaxedPrecision 
                                                      OpDecorate %91 Location 91 
                                                      OpDecorate %92 RelaxedPrecision 
                                                      OpDecorate %93 RelaxedPrecision 
                                                      OpDecorate %94 RelaxedPrecision 
                                                      OpDecorate %95 RelaxedPrecision 
                                                      OpDecorate %98 RelaxedPrecision 
                                                      OpDecorate %99 RelaxedPrecision 
                                                      OpDecorate %100 RelaxedPrecision 
                                                      OpDecorate %101 RelaxedPrecision 
                                                      OpDecorate %103 Location 103 
                                                      OpDecorate %111 RelaxedPrecision 
                                                      OpDecorate %112 RelaxedPrecision 
                                                      OpDecorate %113 RelaxedPrecision 
                                                      OpDecorate %115 RelaxedPrecision 
                                                      OpDecorate %116 RelaxedPrecision 
                                                      OpDecorate %117 RelaxedPrecision 
                                                      OpDecorate %119 RelaxedPrecision 
                                                      OpDecorate %119 Location 119 
                                                      OpDecorate %125 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 3 
                                               %8 = OpTypePointer Private %7 
                                Private f32_3* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypeSampledImage %10 
                                              %12 = OpTypePointer UniformConstant %11 
  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                              %15 = OpTypeVector %6 2 
                                              %16 = OpTypePointer Input %15 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 4 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 0 
                                              %24 = OpTypePointer Private %6 
                               Private f32_3* %26 = OpVariable Private 
                                              %27 = OpTypePointer Input %6 
                                   Input f32* %28 = OpVariable Input 
                                              %30 = OpTypeStruct %19 %19 %7 %6 %6 %6 
                                              %31 = OpTypePointer Uniform %30 
Uniform struct {f32_4; f32_4; f32_3; f32; f32; f32;}* %32 = OpVariable Uniform 
                                              %33 = OpTypeInt 32 1 
                                          i32 %34 = OpConstant 4 
                                              %35 = OpTypePointer Uniform %6 
  UniformConstant read_only Texture2DSampled* %46 = OpVariable UniformConstant 
                                          i32 %52 = OpConstant 3 
  UniformConstant read_only Texture2DSampled* %60 = OpVariable UniformConstant 
                                 Input f32_2* %62 = OpVariable Input 
                               Private f32_3* %66 = OpVariable Private 
                                          i32 %68 = OpConstant 1 
                                              %69 = OpTypePointer Uniform %19 
                                          i32 %74 = OpConstant 2 
                                              %75 = OpTypePointer Uniform %7 
                               Private f32_3* %79 = OpVariable Private 
                                              %81 = OpTypePointer Input %7 
                                 Input f32_3* %82 = OpVariable Input 
                                 Input f32_3* %91 = OpVariable Input 
                               Private f32_3* %94 = OpVariable Private 
                                          i32 %96 = OpConstant 0 
                                Private f32* %102 = OpVariable Private 
                                  Input f32* %103 = OpVariable Input 
                                         f32 %106 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                              Private f32_3* %109 = OpVariable Private 
                                             %118 = OpTypePointer Output %19 
                               Output f32_4* %119 = OpVariable Output 
                                         i32 %123 = OpConstant 5 
                                         u32 %126 = OpConstant 3 
                                             %127 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                   read_only Texture2DSampled %14 = OpLoad %13 
                                        f32_2 %18 = OpLoad %17 
                                        f32_4 %20 = OpImageSampleImplicitLod %14 %18 
                                          f32 %23 = OpCompositeExtract %20 0 
                                 Private f32* %25 = OpAccessChain %9 %22 
                                                      OpStore %25 %23 
                                          f32 %29 = OpLoad %28 
                                 Uniform f32* %36 = OpAccessChain %32 %34 
                                          f32 %37 = OpLoad %36 
                                          f32 %38 = OpFMul %29 %37 
                                 Private f32* %39 = OpAccessChain %26 %22 
                                                      OpStore %39 %38 
                                 Private f32* %40 = OpAccessChain %9 %22 
                                          f32 %41 = OpLoad %40 
                                 Private f32* %42 = OpAccessChain %26 %22 
                                          f32 %43 = OpLoad %42 
                                          f32 %44 = OpFMul %41 %43 
                                 Private f32* %45 = OpAccessChain %26 %22 
                                                      OpStore %45 %44 
                   read_only Texture2DSampled %47 = OpLoad %46 
                                        f32_2 %48 = OpLoad %17 
                                        f32_4 %49 = OpImageSampleImplicitLod %47 %48 
                                        f32_3 %50 = OpVectorShuffle %49 %49 0 1 2 
                                                      OpStore %9 %50 
                                        f32_3 %51 = OpLoad %9 
                                 Uniform f32* %53 = OpAccessChain %32 %52 
                                          f32 %54 = OpLoad %53 
                                        f32_3 %55 = OpCompositeConstruct %54 %54 %54 
                                        f32_3 %56 = OpFMul %51 %55 
                                        f32_3 %57 = OpLoad %26 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 0 0 
                                        f32_3 %59 = OpFAdd %56 %58 
                                                      OpStore %26 %59 
                   read_only Texture2DSampled %61 = OpLoad %60 
                                        f32_2 %63 = OpLoad %62 
                                        f32_4 %64 = OpImageSampleImplicitLod %61 %63 
                                        f32_3 %65 = OpVectorShuffle %64 %64 0 1 2 
                                                      OpStore %9 %65 
                                        f32_3 %67 = OpLoad %9 
                               Uniform f32_4* %70 = OpAccessChain %32 %68 
                                        f32_4 %71 = OpLoad %70 
                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
                                        f32_3 %73 = OpFMul %67 %72 
                               Uniform f32_3* %76 = OpAccessChain %32 %74 
                                        f32_3 %77 = OpLoad %76 
                                        f32_3 %78 = OpFAdd %73 %77 
                                                      OpStore %66 %78 
                                        f32_3 %80 = OpLoad %66 
                                        f32_3 %83 = OpLoad %82 
                                        f32_3 %84 = OpFMul %80 %83 
                                                      OpStore %79 %84 
                                        f32_3 %85 = OpLoad %66 
                                        f32_3 %86 = OpLoad %79 
                                        f32_3 %87 = OpExtInst %1 40 %85 %86 
                                                      OpStore %66 %87 
                                        f32_3 %88 = OpLoad %26 
                                        f32_3 %89 = OpLoad %66 
                                        f32_3 %90 = OpFMul %88 %89 
                                        f32_3 %92 = OpLoad %91 
                                        f32_3 %93 = OpFAdd %90 %92 
                                                      OpStore %26 %93 
                                        f32_3 %95 = OpLoad %26 
                               Uniform f32_4* %97 = OpAccessChain %32 %96 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
                                       f32_3 %100 = OpFNegate %99 
                                       f32_3 %101 = OpFAdd %95 %100 
                                                      OpStore %94 %101 
                                         f32 %104 = OpLoad %103 
                                                      OpStore %102 %104 
                                         f32 %105 = OpLoad %102 
                                         f32 %108 = OpExtInst %1 43 %105 %106 %107 
                                                      OpStore %102 %108 
                                         f32 %110 = OpLoad %102 
                                       f32_3 %111 = OpCompositeConstruct %110 %110 %110 
                                       f32_3 %112 = OpLoad %94 
                                       f32_3 %113 = OpFMul %111 %112 
                              Uniform f32_4* %114 = OpAccessChain %32 %96 
                                       f32_4 %115 = OpLoad %114 
                                       f32_3 %116 = OpVectorShuffle %115 %115 0 1 2 
                                       f32_3 %117 = OpFAdd %113 %116 
                                                      OpStore %109 %117 
                                       f32_3 %120 = OpLoad %109 
                                       f32_4 %121 = OpLoad %119 
                                       f32_4 %122 = OpVectorShuffle %121 %120 4 5 6 3 
                                                      OpStore %119 %122 
                                Uniform f32* %124 = OpAccessChain %32 %123 
                                         f32 %125 = OpLoad %124 
                                 Output f32* %128 = OpAccessChain %119 %126 
                                                      OpStore %128 %125 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "vulkan hw_tier00 " {
""
}
SubProgram "vulkan hw_tier01 " {
""
}
SubProgram "vulkan hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "vulkan hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "vulkan hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "vulkan hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
}
}
 UsePass "Hidden/STARWARS/Char_ShadowCaster/SHADOWCASTER"
}
}