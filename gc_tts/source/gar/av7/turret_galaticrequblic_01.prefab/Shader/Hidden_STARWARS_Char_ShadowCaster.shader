//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/STARWARS/Char_ShadowCaster" {
Properties {
}
SubShader {
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE" = "SHADOWCASTER" }
  ZClip Off
  Cull Off
  GpuProgramID 46599
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan hw_tier00 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 254
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %66 %227 
                                                      OpDecorate %12 Location 12 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate %66 Location 66 
                                                      OpMemberDecorate %225 0 BuiltIn 225 
                                                      OpMemberDecorate %225 1 BuiltIn 225 
                                                      OpMemberDecorate %225 2 BuiltIn 225 
                                                      OpDecorate %225 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 3 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_3* %12 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %7 %16 %17 %18 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 3 
                                          i32 %24 = OpConstant 0 
                                              %25 = OpTypePointer Uniform %7 
                                          u32 %30 = OpConstant 0 
                                              %31 = OpTypePointer Private %6 
                                          i32 %34 = OpConstant 1 
                                          u32 %39 = OpConstant 1 
                                          i32 %42 = OpConstant 2 
                                          u32 %47 = OpConstant 2 
                                 Private f32* %49 = OpVariable Private 
                               Private f32_4* %64 = OpVariable Private 
                                              %65 = OpTypePointer Input %7 
                                 Input f32_4* %66 = OpVariable Input 
                               Private f32_4* %93 = OpVariable Private 
                                         f32 %130 = OpConstant 3.67402E-40 
                                             %135 = OpTypePointer Uniform %6 
                                             %150 = OpTypeBool 
                                             %151 = OpTypePointer Private %150 
                               Private bool* %152 = OpVariable Private 
                                         f32 %155 = OpConstant 3.67402E-40 
                                             %157 = OpTypePointer Function %10 
                                         i32 %172 = OpConstant 4 
                                         u32 %199 = OpConstant 3 
                                         f32 %210 = OpConstant 3.67402E-40 
                                Private f32* %213 = OpVariable Private 
                                             %224 = OpTypeArray %6 %39 
                                             %225 = OpTypeStruct %7 %6 %224 
                                             %226 = OpTypePointer Output %225 
        Output struct {f32_4; f32; f32[1];}* %227 = OpVariable Output 
                                             %230 = OpTypePointer Output %7 
                                             %247 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %158 = OpVariable Function 
                                        f32_3 %13 = OpLoad %12 
                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
                                        f32_4 %27 = OpLoad %26 
                                        f32_3 %28 = OpVectorShuffle %27 %27 0 1 2 
                                          f32 %29 = OpDot %13 %28 
                                 Private f32* %32 = OpAccessChain %9 %30 
                                                      OpStore %32 %29 
                                        f32_3 %33 = OpLoad %12 
                               Uniform f32_4* %35 = OpAccessChain %21 %23 %34 
                                        f32_4 %36 = OpLoad %35 
                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                                          f32 %38 = OpDot %33 %37 
                                 Private f32* %40 = OpAccessChain %9 %39 
                                                      OpStore %40 %38 
                                        f32_3 %41 = OpLoad %12 
                               Uniform f32_4* %43 = OpAccessChain %21 %23 %42 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                          f32 %46 = OpDot %41 %45 
                                 Private f32* %48 = OpAccessChain %9 %47 
                                                      OpStore %48 %46 
                                        f32_4 %50 = OpLoad %9 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                          f32 %54 = OpDot %51 %53 
                                                      OpStore %49 %54 
                                          f32 %55 = OpLoad %49 
                                          f32 %56 = OpExtInst %1 32 %55 
                                                      OpStore %49 %56 
                                          f32 %57 = OpLoad %49 
                                        f32_3 %58 = OpCompositeConstruct %57 %57 %57 
                                        f32_4 %59 = OpLoad %9 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFMul %58 %60 
                                        f32_4 %62 = OpLoad %9 
                                        f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                      OpStore %9 %63 
                                        f32_4 %67 = OpLoad %66 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %21 %42 %34 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %68 %70 
                                                      OpStore %64 %71 
                               Uniform f32_4* %72 = OpAccessChain %21 %42 %24 
                                        f32_4 %73 = OpLoad %72 
                                        f32_4 %74 = OpLoad %66 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %64 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %64 %78 
                               Uniform f32_4* %79 = OpAccessChain %21 %42 %42 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %64 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %64 %85 
                               Uniform f32_4* %86 = OpAccessChain %21 %42 %23 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpVectorShuffle %88 %88 3 3 3 3 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %64 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %64 %92 
                                        f32_4 %94 = OpLoad %64 
                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
                                        f32_3 %96 = OpFNegate %95 
                               Uniform f32_4* %97 = OpAccessChain %21 %24 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 3 3 3 
                                       f32_3 %100 = OpFMul %96 %99 
                              Uniform f32_4* %101 = OpAccessChain %21 %24 
                                       f32_4 %102 = OpLoad %101 
                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
                                       f32_3 %104 = OpFAdd %100 %103 
                                       f32_4 %105 = OpLoad %93 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %93 %106 
                                       f32_4 %107 = OpLoad %93 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                       f32_4 %109 = OpLoad %93 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %108 %110 
                                                      OpStore %49 %111 
                                         f32 %112 = OpLoad %49 
                                         f32 %113 = OpExtInst %1 32 %112 
                                                      OpStore %49 %113 
                                         f32 %114 = OpLoad %49 
                                       f32_3 %115 = OpCompositeConstruct %114 %114 %114 
                                       f32_4 %116 = OpLoad %93 
                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
                                       f32_3 %118 = OpFMul %115 %117 
                                       f32_4 %119 = OpLoad %93 
                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                      OpStore %93 %120 
                                       f32_4 %121 = OpLoad %9 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_4 %123 = OpLoad %93 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %122 %124 
                                                      OpStore %49 %125 
                                         f32 %126 = OpLoad %49 
                                         f32 %127 = OpFNegate %126 
                                         f32 %128 = OpLoad %49 
                                         f32 %129 = OpFMul %127 %128 
                                         f32 %131 = OpFAdd %129 %130 
                                                      OpStore %49 %131 
                                         f32 %132 = OpLoad %49 
                                         f32 %133 = OpExtInst %1 31 %132 
                                                      OpStore %49 %133 
                                         f32 %134 = OpLoad %49 
                                Uniform f32* %136 = OpAccessChain %21 %34 %47 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFMul %134 %137 
                                                      OpStore %49 %138 
                                       f32_4 %139 = OpLoad %9 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_3 %141 = OpFNegate %140 
                                         f32 %142 = OpLoad %49 
                                       f32_3 %143 = OpCompositeConstruct %142 %142 %142 
                                       f32_3 %144 = OpFMul %141 %143 
                                       f32_4 %145 = OpLoad %64 
                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
                                       f32_3 %147 = OpFAdd %144 %146 
                                       f32_4 %148 = OpLoad %9 
                                       f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                      OpStore %9 %149 
                                Uniform f32* %153 = OpAccessChain %21 %34 %47 
                                         f32 %154 = OpLoad %153 
                                        bool %156 = OpFOrdNotEqual %154 %155 
                                                      OpStore %152 %156 
                                        bool %159 = OpLoad %152 
                                                      OpSelectionMerge %161 None 
                                                      OpBranchConditional %159 %160 %164 
                                             %160 = OpLabel 
                                       f32_4 %162 = OpLoad %9 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                                      OpStore %158 %163 
                                                      OpBranch %161 
                                             %164 = OpLabel 
                                       f32_4 %165 = OpLoad %64 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                                      OpStore %158 %166 
                                                      OpBranch %161 
                                             %161 = OpLabel 
                                       f32_3 %167 = OpLoad %158 
                                       f32_4 %168 = OpLoad %9 
                                       f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
                                                      OpStore %9 %169 
                                       f32_4 %170 = OpLoad %9 
                                       f32_4 %171 = OpVectorShuffle %170 %170 1 1 1 1 
                              Uniform f32_4* %173 = OpAccessChain %21 %172 %34 
                                       f32_4 %174 = OpLoad %173 
                                       f32_4 %175 = OpFMul %171 %174 
                                                      OpStore %93 %175 
                              Uniform f32_4* %176 = OpAccessChain %21 %172 %24 
                                       f32_4 %177 = OpLoad %176 
                                       f32_4 %178 = OpLoad %9 
                                       f32_4 %179 = OpVectorShuffle %178 %178 0 0 0 0 
                                       f32_4 %180 = OpFMul %177 %179 
                                       f32_4 %181 = OpLoad %93 
                                       f32_4 %182 = OpFAdd %180 %181 
                                                      OpStore %93 %182 
                              Uniform f32_4* %183 = OpAccessChain %21 %172 %42 
                                       f32_4 %184 = OpLoad %183 
                                       f32_4 %185 = OpLoad %9 
                                       f32_4 %186 = OpVectorShuffle %185 %185 2 2 2 2 
                                       f32_4 %187 = OpFMul %184 %186 
                                       f32_4 %188 = OpLoad %93 
                                       f32_4 %189 = OpFAdd %187 %188 
                                                      OpStore %9 %189 
                              Uniform f32_4* %190 = OpAccessChain %21 %172 %23 
                                       f32_4 %191 = OpLoad %190 
                                       f32_4 %192 = OpLoad %64 
                                       f32_4 %193 = OpVectorShuffle %192 %192 3 3 3 3 
                                       f32_4 %194 = OpFMul %191 %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpFAdd %194 %195 
                                                      OpStore %9 %196 
                                Uniform f32* %197 = OpAccessChain %21 %34 %30 
                                         f32 %198 = OpLoad %197 
                                Private f32* %200 = OpAccessChain %9 %199 
                                         f32 %201 = OpLoad %200 
                                         f32 %202 = OpFDiv %198 %201 
                                Private f32* %203 = OpAccessChain %64 %30 
                                                      OpStore %203 %202 
                                Private f32* %204 = OpAccessChain %64 %30 
                                         f32 %205 = OpLoad %204 
                                         f32 %206 = OpExtInst %1 37 %205 %155 
                                Private f32* %207 = OpAccessChain %64 %30 
                                                      OpStore %207 %206 
                                Private f32* %208 = OpAccessChain %64 %30 
                                         f32 %209 = OpLoad %208 
                                         f32 %211 = OpExtInst %1 40 %209 %210 
                                Private f32* %212 = OpAccessChain %64 %30 
                                                      OpStore %212 %211 
                                Private f32* %214 = OpAccessChain %9 %47 
                                         f32 %215 = OpLoad %214 
                                Private f32* %216 = OpAccessChain %64 %30 
                                         f32 %217 = OpLoad %216 
                                         f32 %218 = OpFAdd %215 %217 
                                                      OpStore %213 %218 
                                Private f32* %219 = OpAccessChain %9 %199 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpLoad %213 
                                         f32 %222 = OpExtInst %1 37 %220 %221 
                                Private f32* %223 = OpAccessChain %64 %30 
                                                      OpStore %223 %222 
                                       f32_4 %228 = OpLoad %9 
                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 3 
                               Output f32_4* %231 = OpAccessChain %227 %24 
                                       f32_4 %232 = OpLoad %231 
                                       f32_4 %233 = OpVectorShuffle %232 %229 4 5 2 6 
                                                      OpStore %231 %233 
                                         f32 %234 = OpLoad %213 
                                         f32 %235 = OpFNegate %234 
                                Private f32* %236 = OpAccessChain %64 %30 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFAdd %235 %237 
                                Private f32* %239 = OpAccessChain %9 %30 
                                                      OpStore %239 %238 
                                Uniform f32* %240 = OpAccessChain %21 %34 %39 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %30 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFMul %241 %243 
                                         f32 %245 = OpLoad %213 
                                         f32 %246 = OpFAdd %244 %245 
                                 Output f32* %248 = OpAccessChain %227 %24 %47 
                                                      OpStore %248 %246 
                                 Output f32* %249 = OpAccessChain %227 %24 %39 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpFNegate %250 
                                 Output f32* %252 = OpAccessChain %227 %24 %39 
                                                      OpStore %252 %251 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 13
; Schema: 0
                     OpCapability Shader 
              %1 = OpExtInstImport "GLSL.std.450" 
                     OpMemoryModel Logical GLSL450 
                     OpEntryPoint Fragment %4 "main" %9 
                     OpExecutionMode %4 OriginUpperLeft 
                     OpDecorate %9 Location 9 
              %2 = OpTypeVoid 
              %3 = OpTypeFunction %2 
              %6 = OpTypeFloat 32 
              %7 = OpTypeVector %6 4 
              %8 = OpTypePointer Output %7 
Output f32_4* %9 = OpVariable Output 
         f32 %10 = OpConstant 3.67402E-40 
       f32_4 %11 = OpConstantComposite %10 %10 %10 %10 
         void %4 = OpFunction None %3 
              %5 = OpLabel 
                     OpStore %9 %11 
                     OpReturn
                     OpFunctionEnd
"
}
SubProgram "vulkan hw_tier01 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 254
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %66 %227 
                                                      OpDecorate %12 Location 12 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate %66 Location 66 
                                                      OpMemberDecorate %225 0 BuiltIn 225 
                                                      OpMemberDecorate %225 1 BuiltIn 225 
                                                      OpMemberDecorate %225 2 BuiltIn 225 
                                                      OpDecorate %225 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 3 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_3* %12 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %7 %16 %17 %18 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 3 
                                          i32 %24 = OpConstant 0 
                                              %25 = OpTypePointer Uniform %7 
                                          u32 %30 = OpConstant 0 
                                              %31 = OpTypePointer Private %6 
                                          i32 %34 = OpConstant 1 
                                          u32 %39 = OpConstant 1 
                                          i32 %42 = OpConstant 2 
                                          u32 %47 = OpConstant 2 
                                 Private f32* %49 = OpVariable Private 
                               Private f32_4* %64 = OpVariable Private 
                                              %65 = OpTypePointer Input %7 
                                 Input f32_4* %66 = OpVariable Input 
                               Private f32_4* %93 = OpVariable Private 
                                         f32 %130 = OpConstant 3.67402E-40 
                                             %135 = OpTypePointer Uniform %6 
                                             %150 = OpTypeBool 
                                             %151 = OpTypePointer Private %150 
                               Private bool* %152 = OpVariable Private 
                                         f32 %155 = OpConstant 3.67402E-40 
                                             %157 = OpTypePointer Function %10 
                                         i32 %172 = OpConstant 4 
                                         u32 %199 = OpConstant 3 
                                         f32 %210 = OpConstant 3.67402E-40 
                                Private f32* %213 = OpVariable Private 
                                             %224 = OpTypeArray %6 %39 
                                             %225 = OpTypeStruct %7 %6 %224 
                                             %226 = OpTypePointer Output %225 
        Output struct {f32_4; f32; f32[1];}* %227 = OpVariable Output 
                                             %230 = OpTypePointer Output %7 
                                             %247 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %158 = OpVariable Function 
                                        f32_3 %13 = OpLoad %12 
                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
                                        f32_4 %27 = OpLoad %26 
                                        f32_3 %28 = OpVectorShuffle %27 %27 0 1 2 
                                          f32 %29 = OpDot %13 %28 
                                 Private f32* %32 = OpAccessChain %9 %30 
                                                      OpStore %32 %29 
                                        f32_3 %33 = OpLoad %12 
                               Uniform f32_4* %35 = OpAccessChain %21 %23 %34 
                                        f32_4 %36 = OpLoad %35 
                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                                          f32 %38 = OpDot %33 %37 
                                 Private f32* %40 = OpAccessChain %9 %39 
                                                      OpStore %40 %38 
                                        f32_3 %41 = OpLoad %12 
                               Uniform f32_4* %43 = OpAccessChain %21 %23 %42 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                          f32 %46 = OpDot %41 %45 
                                 Private f32* %48 = OpAccessChain %9 %47 
                                                      OpStore %48 %46 
                                        f32_4 %50 = OpLoad %9 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                          f32 %54 = OpDot %51 %53 
                                                      OpStore %49 %54 
                                          f32 %55 = OpLoad %49 
                                          f32 %56 = OpExtInst %1 32 %55 
                                                      OpStore %49 %56 
                                          f32 %57 = OpLoad %49 
                                        f32_3 %58 = OpCompositeConstruct %57 %57 %57 
                                        f32_4 %59 = OpLoad %9 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFMul %58 %60 
                                        f32_4 %62 = OpLoad %9 
                                        f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                      OpStore %9 %63 
                                        f32_4 %67 = OpLoad %66 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %21 %42 %34 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %68 %70 
                                                      OpStore %64 %71 
                               Uniform f32_4* %72 = OpAccessChain %21 %42 %24 
                                        f32_4 %73 = OpLoad %72 
                                        f32_4 %74 = OpLoad %66 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %64 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %64 %78 
                               Uniform f32_4* %79 = OpAccessChain %21 %42 %42 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %64 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %64 %85 
                               Uniform f32_4* %86 = OpAccessChain %21 %42 %23 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpVectorShuffle %88 %88 3 3 3 3 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %64 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %64 %92 
                                        f32_4 %94 = OpLoad %64 
                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
                                        f32_3 %96 = OpFNegate %95 
                               Uniform f32_4* %97 = OpAccessChain %21 %24 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 3 3 3 
                                       f32_3 %100 = OpFMul %96 %99 
                              Uniform f32_4* %101 = OpAccessChain %21 %24 
                                       f32_4 %102 = OpLoad %101 
                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
                                       f32_3 %104 = OpFAdd %100 %103 
                                       f32_4 %105 = OpLoad %93 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %93 %106 
                                       f32_4 %107 = OpLoad %93 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                       f32_4 %109 = OpLoad %93 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %108 %110 
                                                      OpStore %49 %111 
                                         f32 %112 = OpLoad %49 
                                         f32 %113 = OpExtInst %1 32 %112 
                                                      OpStore %49 %113 
                                         f32 %114 = OpLoad %49 
                                       f32_3 %115 = OpCompositeConstruct %114 %114 %114 
                                       f32_4 %116 = OpLoad %93 
                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
                                       f32_3 %118 = OpFMul %115 %117 
                                       f32_4 %119 = OpLoad %93 
                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                      OpStore %93 %120 
                                       f32_4 %121 = OpLoad %9 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_4 %123 = OpLoad %93 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %122 %124 
                                                      OpStore %49 %125 
                                         f32 %126 = OpLoad %49 
                                         f32 %127 = OpFNegate %126 
                                         f32 %128 = OpLoad %49 
                                         f32 %129 = OpFMul %127 %128 
                                         f32 %131 = OpFAdd %129 %130 
                                                      OpStore %49 %131 
                                         f32 %132 = OpLoad %49 
                                         f32 %133 = OpExtInst %1 31 %132 
                                                      OpStore %49 %133 
                                         f32 %134 = OpLoad %49 
                                Uniform f32* %136 = OpAccessChain %21 %34 %47 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFMul %134 %137 
                                                      OpStore %49 %138 
                                       f32_4 %139 = OpLoad %9 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_3 %141 = OpFNegate %140 
                                         f32 %142 = OpLoad %49 
                                       f32_3 %143 = OpCompositeConstruct %142 %142 %142 
                                       f32_3 %144 = OpFMul %141 %143 
                                       f32_4 %145 = OpLoad %64 
                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
                                       f32_3 %147 = OpFAdd %144 %146 
                                       f32_4 %148 = OpLoad %9 
                                       f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                      OpStore %9 %149 
                                Uniform f32* %153 = OpAccessChain %21 %34 %47 
                                         f32 %154 = OpLoad %153 
                                        bool %156 = OpFOrdNotEqual %154 %155 
                                                      OpStore %152 %156 
                                        bool %159 = OpLoad %152 
                                                      OpSelectionMerge %161 None 
                                                      OpBranchConditional %159 %160 %164 
                                             %160 = OpLabel 
                                       f32_4 %162 = OpLoad %9 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                                      OpStore %158 %163 
                                                      OpBranch %161 
                                             %164 = OpLabel 
                                       f32_4 %165 = OpLoad %64 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                                      OpStore %158 %166 
                                                      OpBranch %161 
                                             %161 = OpLabel 
                                       f32_3 %167 = OpLoad %158 
                                       f32_4 %168 = OpLoad %9 
                                       f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
                                                      OpStore %9 %169 
                                       f32_4 %170 = OpLoad %9 
                                       f32_4 %171 = OpVectorShuffle %170 %170 1 1 1 1 
                              Uniform f32_4* %173 = OpAccessChain %21 %172 %34 
                                       f32_4 %174 = OpLoad %173 
                                       f32_4 %175 = OpFMul %171 %174 
                                                      OpStore %93 %175 
                              Uniform f32_4* %176 = OpAccessChain %21 %172 %24 
                                       f32_4 %177 = OpLoad %176 
                                       f32_4 %178 = OpLoad %9 
                                       f32_4 %179 = OpVectorShuffle %178 %178 0 0 0 0 
                                       f32_4 %180 = OpFMul %177 %179 
                                       f32_4 %181 = OpLoad %93 
                                       f32_4 %182 = OpFAdd %180 %181 
                                                      OpStore %93 %182 
                              Uniform f32_4* %183 = OpAccessChain %21 %172 %42 
                                       f32_4 %184 = OpLoad %183 
                                       f32_4 %185 = OpLoad %9 
                                       f32_4 %186 = OpVectorShuffle %185 %185 2 2 2 2 
                                       f32_4 %187 = OpFMul %184 %186 
                                       f32_4 %188 = OpLoad %93 
                                       f32_4 %189 = OpFAdd %187 %188 
                                                      OpStore %9 %189 
                              Uniform f32_4* %190 = OpAccessChain %21 %172 %23 
                                       f32_4 %191 = OpLoad %190 
                                       f32_4 %192 = OpLoad %64 
                                       f32_4 %193 = OpVectorShuffle %192 %192 3 3 3 3 
                                       f32_4 %194 = OpFMul %191 %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpFAdd %194 %195 
                                                      OpStore %9 %196 
                                Uniform f32* %197 = OpAccessChain %21 %34 %30 
                                         f32 %198 = OpLoad %197 
                                Private f32* %200 = OpAccessChain %9 %199 
                                         f32 %201 = OpLoad %200 
                                         f32 %202 = OpFDiv %198 %201 
                                Private f32* %203 = OpAccessChain %64 %30 
                                                      OpStore %203 %202 
                                Private f32* %204 = OpAccessChain %64 %30 
                                         f32 %205 = OpLoad %204 
                                         f32 %206 = OpExtInst %1 37 %205 %155 
                                Private f32* %207 = OpAccessChain %64 %30 
                                                      OpStore %207 %206 
                                Private f32* %208 = OpAccessChain %64 %30 
                                         f32 %209 = OpLoad %208 
                                         f32 %211 = OpExtInst %1 40 %209 %210 
                                Private f32* %212 = OpAccessChain %64 %30 
                                                      OpStore %212 %211 
                                Private f32* %214 = OpAccessChain %9 %47 
                                         f32 %215 = OpLoad %214 
                                Private f32* %216 = OpAccessChain %64 %30 
                                         f32 %217 = OpLoad %216 
                                         f32 %218 = OpFAdd %215 %217 
                                                      OpStore %213 %218 
                                Private f32* %219 = OpAccessChain %9 %199 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpLoad %213 
                                         f32 %222 = OpExtInst %1 37 %220 %221 
                                Private f32* %223 = OpAccessChain %64 %30 
                                                      OpStore %223 %222 
                                       f32_4 %228 = OpLoad %9 
                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 3 
                               Output f32_4* %231 = OpAccessChain %227 %24 
                                       f32_4 %232 = OpLoad %231 
                                       f32_4 %233 = OpVectorShuffle %232 %229 4 5 2 6 
                                                      OpStore %231 %233 
                                         f32 %234 = OpLoad %213 
                                         f32 %235 = OpFNegate %234 
                                Private f32* %236 = OpAccessChain %64 %30 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFAdd %235 %237 
                                Private f32* %239 = OpAccessChain %9 %30 
                                                      OpStore %239 %238 
                                Uniform f32* %240 = OpAccessChain %21 %34 %39 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %30 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFMul %241 %243 
                                         f32 %245 = OpLoad %213 
                                         f32 %246 = OpFAdd %244 %245 
                                 Output f32* %248 = OpAccessChain %227 %24 %47 
                                                      OpStore %248 %246 
                                 Output f32* %249 = OpAccessChain %227 %24 %39 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpFNegate %250 
                                 Output f32* %252 = OpAccessChain %227 %24 %39 
                                                      OpStore %252 %251 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 13
; Schema: 0
                     OpCapability Shader 
              %1 = OpExtInstImport "GLSL.std.450" 
                     OpMemoryModel Logical GLSL450 
                     OpEntryPoint Fragment %4 "main" %9 
                     OpExecutionMode %4 OriginUpperLeft 
                     OpDecorate %9 Location 9 
              %2 = OpTypeVoid 
              %3 = OpTypeFunction %2 
              %6 = OpTypeFloat 32 
              %7 = OpTypeVector %6 4 
              %8 = OpTypePointer Output %7 
Output f32_4* %9 = OpVariable Output 
         f32 %10 = OpConstant 3.67402E-40 
       f32_4 %11 = OpConstantComposite %10 %10 %10 %10 
         void %4 = OpFunction None %3 
              %5 = OpLabel 
                     OpStore %9 %11 
                     OpReturn
                     OpFunctionEnd
"
}
SubProgram "vulkan hw_tier02 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 254
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %12 %66 %227 
                                                      OpDecorate %12 Location 12 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpDecorate %18 ArrayStride 18 
                                                      OpMemberDecorate %19 0 Offset 19 
                                                      OpMemberDecorate %19 1 Offset 19 
                                                      OpMemberDecorate %19 2 Offset 19 
                                                      OpMemberDecorate %19 3 Offset 19 
                                                      OpMemberDecorate %19 4 Offset 19 
                                                      OpDecorate %19 Block 
                                                      OpDecorate %21 DescriptorSet 21 
                                                      OpDecorate %21 Binding 21 
                                                      OpDecorate %66 Location 66 
                                                      OpMemberDecorate %225 0 BuiltIn 225 
                                                      OpMemberDecorate %225 1 BuiltIn 225 
                                                      OpMemberDecorate %225 2 BuiltIn 225 
                                                      OpDecorate %225 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeVector %6 3 
                                              %11 = OpTypePointer Input %10 
                                 Input f32_3* %12 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeArray %7 %15 
                                              %19 = OpTypeStruct %7 %7 %16 %17 %18 
                                              %20 = OpTypePointer Uniform %19 
Uniform struct {f32_4; f32_4; f32_4[4]; f32_4[4]; f32_4[4];}* %21 = OpVariable Uniform 
                                              %22 = OpTypeInt 32 1 
                                          i32 %23 = OpConstant 3 
                                          i32 %24 = OpConstant 0 
                                              %25 = OpTypePointer Uniform %7 
                                          u32 %30 = OpConstant 0 
                                              %31 = OpTypePointer Private %6 
                                          i32 %34 = OpConstant 1 
                                          u32 %39 = OpConstant 1 
                                          i32 %42 = OpConstant 2 
                                          u32 %47 = OpConstant 2 
                                 Private f32* %49 = OpVariable Private 
                               Private f32_4* %64 = OpVariable Private 
                                              %65 = OpTypePointer Input %7 
                                 Input f32_4* %66 = OpVariable Input 
                               Private f32_4* %93 = OpVariable Private 
                                         f32 %130 = OpConstant 3.67402E-40 
                                             %135 = OpTypePointer Uniform %6 
                                             %150 = OpTypeBool 
                                             %151 = OpTypePointer Private %150 
                               Private bool* %152 = OpVariable Private 
                                         f32 %155 = OpConstant 3.67402E-40 
                                             %157 = OpTypePointer Function %10 
                                         i32 %172 = OpConstant 4 
                                         u32 %199 = OpConstant 3 
                                         f32 %210 = OpConstant 3.67402E-40 
                                Private f32* %213 = OpVariable Private 
                                             %224 = OpTypeArray %6 %39 
                                             %225 = OpTypeStruct %7 %6 %224 
                                             %226 = OpTypePointer Output %225 
        Output struct {f32_4; f32; f32[1];}* %227 = OpVariable Output 
                                             %230 = OpTypePointer Output %7 
                                             %247 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                             Function f32_3* %158 = OpVariable Function 
                                        f32_3 %13 = OpLoad %12 
                               Uniform f32_4* %26 = OpAccessChain %21 %23 %24 
                                        f32_4 %27 = OpLoad %26 
                                        f32_3 %28 = OpVectorShuffle %27 %27 0 1 2 
                                          f32 %29 = OpDot %13 %28 
                                 Private f32* %32 = OpAccessChain %9 %30 
                                                      OpStore %32 %29 
                                        f32_3 %33 = OpLoad %12 
                               Uniform f32_4* %35 = OpAccessChain %21 %23 %34 
                                        f32_4 %36 = OpLoad %35 
                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
                                          f32 %38 = OpDot %33 %37 
                                 Private f32* %40 = OpAccessChain %9 %39 
                                                      OpStore %40 %38 
                                        f32_3 %41 = OpLoad %12 
                               Uniform f32_4* %43 = OpAccessChain %21 %23 %42 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                          f32 %46 = OpDot %41 %45 
                                 Private f32* %48 = OpAccessChain %9 %47 
                                                      OpStore %48 %46 
                                        f32_4 %50 = OpLoad %9 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %9 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                          f32 %54 = OpDot %51 %53 
                                                      OpStore %49 %54 
                                          f32 %55 = OpLoad %49 
                                          f32 %56 = OpExtInst %1 32 %55 
                                                      OpStore %49 %56 
                                          f32 %57 = OpLoad %49 
                                        f32_3 %58 = OpCompositeConstruct %57 %57 %57 
                                        f32_4 %59 = OpLoad %9 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFMul %58 %60 
                                        f32_4 %62 = OpLoad %9 
                                        f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                      OpStore %9 %63 
                                        f32_4 %67 = OpLoad %66 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %69 = OpAccessChain %21 %42 %34 
                                        f32_4 %70 = OpLoad %69 
                                        f32_4 %71 = OpFMul %68 %70 
                                                      OpStore %64 %71 
                               Uniform f32_4* %72 = OpAccessChain %21 %42 %24 
                                        f32_4 %73 = OpLoad %72 
                                        f32_4 %74 = OpLoad %66 
                                        f32_4 %75 = OpVectorShuffle %74 %74 0 0 0 0 
                                        f32_4 %76 = OpFMul %73 %75 
                                        f32_4 %77 = OpLoad %64 
                                        f32_4 %78 = OpFAdd %76 %77 
                                                      OpStore %64 %78 
                               Uniform f32_4* %79 = OpAccessChain %21 %42 %42 
                                        f32_4 %80 = OpLoad %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpVectorShuffle %81 %81 2 2 2 2 
                                        f32_4 %83 = OpFMul %80 %82 
                                        f32_4 %84 = OpLoad %64 
                                        f32_4 %85 = OpFAdd %83 %84 
                                                      OpStore %64 %85 
                               Uniform f32_4* %86 = OpAccessChain %21 %42 %23 
                                        f32_4 %87 = OpLoad %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpVectorShuffle %88 %88 3 3 3 3 
                                        f32_4 %90 = OpFMul %87 %89 
                                        f32_4 %91 = OpLoad %64 
                                        f32_4 %92 = OpFAdd %90 %91 
                                                      OpStore %64 %92 
                                        f32_4 %94 = OpLoad %64 
                                        f32_3 %95 = OpVectorShuffle %94 %94 0 1 2 
                                        f32_3 %96 = OpFNegate %95 
                               Uniform f32_4* %97 = OpAccessChain %21 %24 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 3 3 3 
                                       f32_3 %100 = OpFMul %96 %99 
                              Uniform f32_4* %101 = OpAccessChain %21 %24 
                                       f32_4 %102 = OpLoad %101 
                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
                                       f32_3 %104 = OpFAdd %100 %103 
                                       f32_4 %105 = OpLoad %93 
                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 6 3 
                                                      OpStore %93 %106 
                                       f32_4 %107 = OpLoad %93 
                                       f32_3 %108 = OpVectorShuffle %107 %107 0 1 2 
                                       f32_4 %109 = OpLoad %93 
                                       f32_3 %110 = OpVectorShuffle %109 %109 0 1 2 
                                         f32 %111 = OpDot %108 %110 
                                                      OpStore %49 %111 
                                         f32 %112 = OpLoad %49 
                                         f32 %113 = OpExtInst %1 32 %112 
                                                      OpStore %49 %113 
                                         f32 %114 = OpLoad %49 
                                       f32_3 %115 = OpCompositeConstruct %114 %114 %114 
                                       f32_4 %116 = OpLoad %93 
                                       f32_3 %117 = OpVectorShuffle %116 %116 0 1 2 
                                       f32_3 %118 = OpFMul %115 %117 
                                       f32_4 %119 = OpLoad %93 
                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                      OpStore %93 %120 
                                       f32_4 %121 = OpLoad %9 
                                       f32_3 %122 = OpVectorShuffle %121 %121 0 1 2 
                                       f32_4 %123 = OpLoad %93 
                                       f32_3 %124 = OpVectorShuffle %123 %123 0 1 2 
                                         f32 %125 = OpDot %122 %124 
                                                      OpStore %49 %125 
                                         f32 %126 = OpLoad %49 
                                         f32 %127 = OpFNegate %126 
                                         f32 %128 = OpLoad %49 
                                         f32 %129 = OpFMul %127 %128 
                                         f32 %131 = OpFAdd %129 %130 
                                                      OpStore %49 %131 
                                         f32 %132 = OpLoad %49 
                                         f32 %133 = OpExtInst %1 31 %132 
                                                      OpStore %49 %133 
                                         f32 %134 = OpLoad %49 
                                Uniform f32* %136 = OpAccessChain %21 %34 %47 
                                         f32 %137 = OpLoad %136 
                                         f32 %138 = OpFMul %134 %137 
                                                      OpStore %49 %138 
                                       f32_4 %139 = OpLoad %9 
                                       f32_3 %140 = OpVectorShuffle %139 %139 0 1 2 
                                       f32_3 %141 = OpFNegate %140 
                                         f32 %142 = OpLoad %49 
                                       f32_3 %143 = OpCompositeConstruct %142 %142 %142 
                                       f32_3 %144 = OpFMul %141 %143 
                                       f32_4 %145 = OpLoad %64 
                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
                                       f32_3 %147 = OpFAdd %144 %146 
                                       f32_4 %148 = OpLoad %9 
                                       f32_4 %149 = OpVectorShuffle %148 %147 4 5 6 3 
                                                      OpStore %9 %149 
                                Uniform f32* %153 = OpAccessChain %21 %34 %47 
                                         f32 %154 = OpLoad %153 
                                        bool %156 = OpFOrdNotEqual %154 %155 
                                                      OpStore %152 %156 
                                        bool %159 = OpLoad %152 
                                                      OpSelectionMerge %161 None 
                                                      OpBranchConditional %159 %160 %164 
                                             %160 = OpLabel 
                                       f32_4 %162 = OpLoad %9 
                                       f32_3 %163 = OpVectorShuffle %162 %162 0 1 2 
                                                      OpStore %158 %163 
                                                      OpBranch %161 
                                             %164 = OpLabel 
                                       f32_4 %165 = OpLoad %64 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                                      OpStore %158 %166 
                                                      OpBranch %161 
                                             %161 = OpLabel 
                                       f32_3 %167 = OpLoad %158 
                                       f32_4 %168 = OpLoad %9 
                                       f32_4 %169 = OpVectorShuffle %168 %167 4 5 6 3 
                                                      OpStore %9 %169 
                                       f32_4 %170 = OpLoad %9 
                                       f32_4 %171 = OpVectorShuffle %170 %170 1 1 1 1 
                              Uniform f32_4* %173 = OpAccessChain %21 %172 %34 
                                       f32_4 %174 = OpLoad %173 
                                       f32_4 %175 = OpFMul %171 %174 
                                                      OpStore %93 %175 
                              Uniform f32_4* %176 = OpAccessChain %21 %172 %24 
                                       f32_4 %177 = OpLoad %176 
                                       f32_4 %178 = OpLoad %9 
                                       f32_4 %179 = OpVectorShuffle %178 %178 0 0 0 0 
                                       f32_4 %180 = OpFMul %177 %179 
                                       f32_4 %181 = OpLoad %93 
                                       f32_4 %182 = OpFAdd %180 %181 
                                                      OpStore %93 %182 
                              Uniform f32_4* %183 = OpAccessChain %21 %172 %42 
                                       f32_4 %184 = OpLoad %183 
                                       f32_4 %185 = OpLoad %9 
                                       f32_4 %186 = OpVectorShuffle %185 %185 2 2 2 2 
                                       f32_4 %187 = OpFMul %184 %186 
                                       f32_4 %188 = OpLoad %93 
                                       f32_4 %189 = OpFAdd %187 %188 
                                                      OpStore %9 %189 
                              Uniform f32_4* %190 = OpAccessChain %21 %172 %23 
                                       f32_4 %191 = OpLoad %190 
                                       f32_4 %192 = OpLoad %64 
                                       f32_4 %193 = OpVectorShuffle %192 %192 3 3 3 3 
                                       f32_4 %194 = OpFMul %191 %193 
                                       f32_4 %195 = OpLoad %9 
                                       f32_4 %196 = OpFAdd %194 %195 
                                                      OpStore %9 %196 
                                Uniform f32* %197 = OpAccessChain %21 %34 %30 
                                         f32 %198 = OpLoad %197 
                                Private f32* %200 = OpAccessChain %9 %199 
                                         f32 %201 = OpLoad %200 
                                         f32 %202 = OpFDiv %198 %201 
                                Private f32* %203 = OpAccessChain %64 %30 
                                                      OpStore %203 %202 
                                Private f32* %204 = OpAccessChain %64 %30 
                                         f32 %205 = OpLoad %204 
                                         f32 %206 = OpExtInst %1 37 %205 %155 
                                Private f32* %207 = OpAccessChain %64 %30 
                                                      OpStore %207 %206 
                                Private f32* %208 = OpAccessChain %64 %30 
                                         f32 %209 = OpLoad %208 
                                         f32 %211 = OpExtInst %1 40 %209 %210 
                                Private f32* %212 = OpAccessChain %64 %30 
                                                      OpStore %212 %211 
                                Private f32* %214 = OpAccessChain %9 %47 
                                         f32 %215 = OpLoad %214 
                                Private f32* %216 = OpAccessChain %64 %30 
                                         f32 %217 = OpLoad %216 
                                         f32 %218 = OpFAdd %215 %217 
                                                      OpStore %213 %218 
                                Private f32* %219 = OpAccessChain %9 %199 
                                         f32 %220 = OpLoad %219 
                                         f32 %221 = OpLoad %213 
                                         f32 %222 = OpExtInst %1 37 %220 %221 
                                Private f32* %223 = OpAccessChain %64 %30 
                                                      OpStore %223 %222 
                                       f32_4 %228 = OpLoad %9 
                                       f32_3 %229 = OpVectorShuffle %228 %228 0 1 3 
                               Output f32_4* %231 = OpAccessChain %227 %24 
                                       f32_4 %232 = OpLoad %231 
                                       f32_4 %233 = OpVectorShuffle %232 %229 4 5 2 6 
                                                      OpStore %231 %233 
                                         f32 %234 = OpLoad %213 
                                         f32 %235 = OpFNegate %234 
                                Private f32* %236 = OpAccessChain %64 %30 
                                         f32 %237 = OpLoad %236 
                                         f32 %238 = OpFAdd %235 %237 
                                Private f32* %239 = OpAccessChain %9 %30 
                                                      OpStore %239 %238 
                                Uniform f32* %240 = OpAccessChain %21 %34 %39 
                                         f32 %241 = OpLoad %240 
                                Private f32* %242 = OpAccessChain %9 %30 
                                         f32 %243 = OpLoad %242 
                                         f32 %244 = OpFMul %241 %243 
                                         f32 %245 = OpLoad %213 
                                         f32 %246 = OpFAdd %244 %245 
                                 Output f32* %248 = OpAccessChain %227 %24 %47 
                                                      OpStore %248 %246 
                                 Output f32* %249 = OpAccessChain %227 %24 %39 
                                         f32 %250 = OpLoad %249 
                                         f32 %251 = OpFNegate %250 
                                 Output f32* %252 = OpAccessChain %227 %24 %39 
                                                      OpStore %252 %251 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 13
; Schema: 0
                     OpCapability Shader 
              %1 = OpExtInstImport "GLSL.std.450" 
                     OpMemoryModel Logical GLSL450 
                     OpEntryPoint Fragment %4 "main" %9 
                     OpExecutionMode %4 OriginUpperLeft 
                     OpDecorate %9 Location 9 
              %2 = OpTypeVoid 
              %3 = OpTypeFunction %2 
              %6 = OpTypeFloat 32 
              %7 = OpTypeVector %6 4 
              %8 = OpTypePointer Output %7 
Output f32_4* %9 = OpVariable Output 
         f32 %10 = OpConstant 3.67402E-40 
       f32_4 %11 = OpConstantComposite %10 %10 %10 %10 
         void %4 = OpFunction None %3 
              %5 = OpLabel 
                     OpStore %9 %11 
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
}
}
}
}