//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "SWFx/[EX] Multiply" {
Properties {
[DecoHeaderBox(Pass Options, 0)] [CullOption] __Cull ("CULL", Float) = 0
[ZTestOption] __ZTest ("ZTest", Float) = 4
[Int] __Offset ("OFFSET", Float) = 0
[DecoHeaderBox] _MainTex ("Texture", 2D) = "white" { }
_TintColor ("Color [HDR]", Color) = (0.5,0.5,0.5,1)
[HeaderBox(Default Options, 5, 10)] ____box_RQ ("", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  Blend DstColor Zero, DstColor Zero
  ZClip Off
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 15790
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + vec3(u_xlat2);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + vec3(u_xlat2);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2 = (-vs_COLOR0.w) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz + vec3(u_xlat2);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "vulkan hw_tier00 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 98
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Vertex %4 "main" %11 %79 %83 %84 %88 %90 
                                              OpDecorate %11 RelaxedPrecision 
                                              OpDecorate %11 Location 11 
                                              OpDecorate %12 RelaxedPrecision 
                                              OpDecorate %13 RelaxedPrecision 
                                              OpDecorate %16 ArrayStride 16 
                                              OpDecorate %17 ArrayStride 17 
                                              OpMemberDecorate %18 0 Offset 18 
                                              OpMemberDecorate %18 1 Offset 18 
                                              OpDecorate %18 Block 
                                              OpDecorate %20 DescriptorSet 20 
                                              OpDecorate %20 Binding 20 
                                              OpDecorate %30 RelaxedPrecision 
                                              OpDecorate %31 RelaxedPrecision 
                                              OpDecorate %38 RelaxedPrecision 
                                              OpDecorate %39 RelaxedPrecision 
                                              OpMemberDecorate %77 0 BuiltIn 77 
                                              OpMemberDecorate %77 1 BuiltIn 77 
                                              OpMemberDecorate %77 2 BuiltIn 77 
                                              OpDecorate %77 Block 
                                              OpDecorate %83 Location 83 
                                              OpDecorate %84 Location 84 
                                              OpDecorate %88 RelaxedPrecision 
                                              OpDecorate %88 Location 88 
                                              OpDecorate %90 RelaxedPrecision 
                                              OpDecorate %90 Location 90 
                                              OpDecorate %91 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypePointer Input %7 
                         Input f32_4* %11 = OpVariable Input 
                                      %14 = OpTypeInt 32 0 
                                  u32 %15 = OpConstant 4 
                                      %16 = OpTypeArray %7 %15 
                                      %17 = OpTypeArray %7 %15 
                                      %18 = OpTypeStruct %16 %17 
                                      %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                      %21 = OpTypeInt 32 1 
                                  i32 %22 = OpConstant 0 
                                  i32 %23 = OpConstant 1 
                                      %24 = OpTypePointer Uniform %7 
                                  i32 %35 = OpConstant 2 
                                  i32 %44 = OpConstant 3 
                       Private f32_4* %48 = OpVariable Private 
                                  u32 %75 = OpConstant 1 
                                      %76 = OpTypeArray %6 %75 
                                      %77 = OpTypeStruct %7 %6 %76 
                                      %78 = OpTypePointer Output %77 
 Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                      %81 = OpTypePointer Output %7 
                        Output f32_4* %83 = OpVariable Output 
                         Input f32_4* %84 = OpVariable Input 
                                      %86 = OpTypeVector %6 2 
                                      %87 = OpTypePointer Output %86 
                        Output f32_2* %88 = OpVariable Output 
                                      %89 = OpTypePointer Input %86 
                         Input f32_2* %90 = OpVariable Input 
                                      %92 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                                f32_4 %12 = OpLoad %11 
                                f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                       Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                f32_4 %26 = OpLoad %25 
                                f32_4 %27 = OpFMul %13 %26 
                                              OpStore %9 %27 
                       Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                f32_4 %29 = OpLoad %28 
                                f32_4 %30 = OpLoad %11 
                                f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                f32_4 %32 = OpFMul %29 %31 
                                f32_4 %33 = OpLoad %9 
                                f32_4 %34 = OpFAdd %32 %33 
                                              OpStore %9 %34 
                       Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                f32_4 %37 = OpLoad %36 
                                f32_4 %38 = OpLoad %11 
                                f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                f32_4 %40 = OpFMul %37 %39 
                                f32_4 %41 = OpLoad %9 
                                f32_4 %42 = OpFAdd %40 %41 
                                              OpStore %9 %42 
                                f32_4 %43 = OpLoad %9 
                       Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                f32_4 %46 = OpLoad %45 
                                f32_4 %47 = OpFAdd %43 %46 
                                              OpStore %9 %47 
                                f32_4 %49 = OpLoad %9 
                                f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                       Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                f32_4 %52 = OpLoad %51 
                                f32_4 %53 = OpFMul %50 %52 
                                              OpStore %48 %53 
                       Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                f32_4 %55 = OpLoad %54 
                                f32_4 %56 = OpLoad %9 
                                f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                f32_4 %58 = OpFMul %55 %57 
                                f32_4 %59 = OpLoad %48 
                                f32_4 %60 = OpFAdd %58 %59 
                                              OpStore %48 %60 
                       Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                f32_4 %62 = OpLoad %61 
                                f32_4 %63 = OpLoad %9 
                                f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                f32_4 %65 = OpFMul %62 %64 
                                f32_4 %66 = OpLoad %48 
                                f32_4 %67 = OpFAdd %65 %66 
                                              OpStore %48 %67 
                       Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
                                f32_4 %69 = OpLoad %68 
                                f32_4 %70 = OpLoad %9 
                                f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                f32_4 %72 = OpFMul %69 %71 
                                f32_4 %73 = OpLoad %48 
                                f32_4 %74 = OpFAdd %72 %73 
                                              OpStore %9 %74 
                                f32_4 %80 = OpLoad %9 
                        Output f32_4* %82 = OpAccessChain %79 %22 
                                              OpStore %82 %80 
                                f32_4 %85 = OpLoad %84 
                                              OpStore %83 %85 
                                f32_2 %91 = OpLoad %90 
                                              OpStore %88 %91 
                          Output f32* %93 = OpAccessChain %79 %22 %75 
                                  f32 %94 = OpLoad %93 
                                  f32 %95 = OpFNegate %94 
                          Output f32* %96 = OpAccessChain %79 %22 %75 
                                              OpStore %96 %95 
                                              OpReturn
                                              OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 68
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %44 %65 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %44 Location 44 
                                                    OpDecorate %65 RelaxedPrecision 
                                                    OpDecorate %65 Location 65 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypePointer Private %6 
                               Private f32* %42 = OpVariable Private 
                                            %43 = OpTypePointer Input %7 
                               Input f32_4* %44 = OpVariable Input 
                                            %45 = OpTypeInt 32 0 
                                        u32 %46 = OpConstant 3 
                                            %47 = OpTypePointer Input %6 
                                        f32 %51 = OpConstant 3.67402E-40 
                                            %53 = OpTypeVector %6 3 
                                            %64 = OpTypePointer Output %7 
                              Output f32_4* %65 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %48 = OpAccessChain %44 %46 
                                        f32 %49 = OpLoad %48 
                                        f32 %50 = OpFNegate %49 
                                        f32 %52 = OpFAdd %50 %51 
                                                    OpStore %42 %52 
                                      f32_4 %54 = OpLoad %37 
                                      f32_3 %55 = OpVectorShuffle %54 %54 0 1 2 
                                      f32_4 %56 = OpLoad %44 
                                      f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                      f32_3 %58 = OpFMul %55 %57 
                                        f32 %59 = OpLoad %42 
                                      f32_3 %60 = OpCompositeConstruct %59 %59 %59 
                                      f32_3 %61 = OpFAdd %58 %60 
                                      f32_4 %62 = OpLoad %37 
                                      f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                    OpStore %37 %63 
                                      f32_4 %66 = OpLoad %37 
                                                    OpStore %65 %66 
                                                    OpReturn
                                                    OpFunctionEnd
"
}
SubProgram "vulkan hw_tier01 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 98
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Vertex %4 "main" %11 %79 %83 %84 %88 %90 
                                              OpDecorate %11 RelaxedPrecision 
                                              OpDecorate %11 Location 11 
                                              OpDecorate %12 RelaxedPrecision 
                                              OpDecorate %13 RelaxedPrecision 
                                              OpDecorate %16 ArrayStride 16 
                                              OpDecorate %17 ArrayStride 17 
                                              OpMemberDecorate %18 0 Offset 18 
                                              OpMemberDecorate %18 1 Offset 18 
                                              OpDecorate %18 Block 
                                              OpDecorate %20 DescriptorSet 20 
                                              OpDecorate %20 Binding 20 
                                              OpDecorate %30 RelaxedPrecision 
                                              OpDecorate %31 RelaxedPrecision 
                                              OpDecorate %38 RelaxedPrecision 
                                              OpDecorate %39 RelaxedPrecision 
                                              OpMemberDecorate %77 0 BuiltIn 77 
                                              OpMemberDecorate %77 1 BuiltIn 77 
                                              OpMemberDecorate %77 2 BuiltIn 77 
                                              OpDecorate %77 Block 
                                              OpDecorate %83 Location 83 
                                              OpDecorate %84 Location 84 
                                              OpDecorate %88 RelaxedPrecision 
                                              OpDecorate %88 Location 88 
                                              OpDecorate %90 RelaxedPrecision 
                                              OpDecorate %90 Location 90 
                                              OpDecorate %91 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypePointer Input %7 
                         Input f32_4* %11 = OpVariable Input 
                                      %14 = OpTypeInt 32 0 
                                  u32 %15 = OpConstant 4 
                                      %16 = OpTypeArray %7 %15 
                                      %17 = OpTypeArray %7 %15 
                                      %18 = OpTypeStruct %16 %17 
                                      %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                      %21 = OpTypeInt 32 1 
                                  i32 %22 = OpConstant 0 
                                  i32 %23 = OpConstant 1 
                                      %24 = OpTypePointer Uniform %7 
                                  i32 %35 = OpConstant 2 
                                  i32 %44 = OpConstant 3 
                       Private f32_4* %48 = OpVariable Private 
                                  u32 %75 = OpConstant 1 
                                      %76 = OpTypeArray %6 %75 
                                      %77 = OpTypeStruct %7 %6 %76 
                                      %78 = OpTypePointer Output %77 
 Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                      %81 = OpTypePointer Output %7 
                        Output f32_4* %83 = OpVariable Output 
                         Input f32_4* %84 = OpVariable Input 
                                      %86 = OpTypeVector %6 2 
                                      %87 = OpTypePointer Output %86 
                        Output f32_2* %88 = OpVariable Output 
                                      %89 = OpTypePointer Input %86 
                         Input f32_2* %90 = OpVariable Input 
                                      %92 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                                f32_4 %12 = OpLoad %11 
                                f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                       Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                f32_4 %26 = OpLoad %25 
                                f32_4 %27 = OpFMul %13 %26 
                                              OpStore %9 %27 
                       Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                f32_4 %29 = OpLoad %28 
                                f32_4 %30 = OpLoad %11 
                                f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                f32_4 %32 = OpFMul %29 %31 
                                f32_4 %33 = OpLoad %9 
                                f32_4 %34 = OpFAdd %32 %33 
                                              OpStore %9 %34 
                       Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                f32_4 %37 = OpLoad %36 
                                f32_4 %38 = OpLoad %11 
                                f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                f32_4 %40 = OpFMul %37 %39 
                                f32_4 %41 = OpLoad %9 
                                f32_4 %42 = OpFAdd %40 %41 
                                              OpStore %9 %42 
                                f32_4 %43 = OpLoad %9 
                       Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                f32_4 %46 = OpLoad %45 
                                f32_4 %47 = OpFAdd %43 %46 
                                              OpStore %9 %47 
                                f32_4 %49 = OpLoad %9 
                                f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                       Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                f32_4 %52 = OpLoad %51 
                                f32_4 %53 = OpFMul %50 %52 
                                              OpStore %48 %53 
                       Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                f32_4 %55 = OpLoad %54 
                                f32_4 %56 = OpLoad %9 
                                f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                f32_4 %58 = OpFMul %55 %57 
                                f32_4 %59 = OpLoad %48 
                                f32_4 %60 = OpFAdd %58 %59 
                                              OpStore %48 %60 
                       Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                f32_4 %62 = OpLoad %61 
                                f32_4 %63 = OpLoad %9 
                                f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                f32_4 %65 = OpFMul %62 %64 
                                f32_4 %66 = OpLoad %48 
                                f32_4 %67 = OpFAdd %65 %66 
                                              OpStore %48 %67 
                       Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
                                f32_4 %69 = OpLoad %68 
                                f32_4 %70 = OpLoad %9 
                                f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                f32_4 %72 = OpFMul %69 %71 
                                f32_4 %73 = OpLoad %48 
                                f32_4 %74 = OpFAdd %72 %73 
                                              OpStore %9 %74 
                                f32_4 %80 = OpLoad %9 
                        Output f32_4* %82 = OpAccessChain %79 %22 
                                              OpStore %82 %80 
                                f32_4 %85 = OpLoad %84 
                                              OpStore %83 %85 
                                f32_2 %91 = OpLoad %90 
                                              OpStore %88 %91 
                          Output f32* %93 = OpAccessChain %79 %22 %75 
                                  f32 %94 = OpLoad %93 
                                  f32 %95 = OpFNegate %94 
                          Output f32* %96 = OpAccessChain %79 %22 %75 
                                              OpStore %96 %95 
                                              OpReturn
                                              OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 68
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %44 %65 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %44 Location 44 
                                                    OpDecorate %65 RelaxedPrecision 
                                                    OpDecorate %65 Location 65 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypePointer Private %6 
                               Private f32* %42 = OpVariable Private 
                                            %43 = OpTypePointer Input %7 
                               Input f32_4* %44 = OpVariable Input 
                                            %45 = OpTypeInt 32 0 
                                        u32 %46 = OpConstant 3 
                                            %47 = OpTypePointer Input %6 
                                        f32 %51 = OpConstant 3.67402E-40 
                                            %53 = OpTypeVector %6 3 
                                            %64 = OpTypePointer Output %7 
                              Output f32_4* %65 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %48 = OpAccessChain %44 %46 
                                        f32 %49 = OpLoad %48 
                                        f32 %50 = OpFNegate %49 
                                        f32 %52 = OpFAdd %50 %51 
                                                    OpStore %42 %52 
                                      f32_4 %54 = OpLoad %37 
                                      f32_3 %55 = OpVectorShuffle %54 %54 0 1 2 
                                      f32_4 %56 = OpLoad %44 
                                      f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                      f32_3 %58 = OpFMul %55 %57 
                                        f32 %59 = OpLoad %42 
                                      f32_3 %60 = OpCompositeConstruct %59 %59 %59 
                                      f32_3 %61 = OpFAdd %58 %60 
                                      f32_4 %62 = OpLoad %37 
                                      f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                    OpStore %37 %63 
                                      f32_4 %66 = OpLoad %37 
                                                    OpStore %65 %66 
                                                    OpReturn
                                                    OpFunctionEnd
"
}
SubProgram "vulkan hw_tier02 " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 98
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Vertex %4 "main" %11 %79 %83 %84 %88 %90 
                                              OpDecorate %11 RelaxedPrecision 
                                              OpDecorate %11 Location 11 
                                              OpDecorate %12 RelaxedPrecision 
                                              OpDecorate %13 RelaxedPrecision 
                                              OpDecorate %16 ArrayStride 16 
                                              OpDecorate %17 ArrayStride 17 
                                              OpMemberDecorate %18 0 Offset 18 
                                              OpMemberDecorate %18 1 Offset 18 
                                              OpDecorate %18 Block 
                                              OpDecorate %20 DescriptorSet 20 
                                              OpDecorate %20 Binding 20 
                                              OpDecorate %30 RelaxedPrecision 
                                              OpDecorate %31 RelaxedPrecision 
                                              OpDecorate %38 RelaxedPrecision 
                                              OpDecorate %39 RelaxedPrecision 
                                              OpMemberDecorate %77 0 BuiltIn 77 
                                              OpMemberDecorate %77 1 BuiltIn 77 
                                              OpMemberDecorate %77 2 BuiltIn 77 
                                              OpDecorate %77 Block 
                                              OpDecorate %83 Location 83 
                                              OpDecorate %84 Location 84 
                                              OpDecorate %88 RelaxedPrecision 
                                              OpDecorate %88 Location 88 
                                              OpDecorate %90 RelaxedPrecision 
                                              OpDecorate %90 Location 90 
                                              OpDecorate %91 RelaxedPrecision 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypePointer Input %7 
                         Input f32_4* %11 = OpVariable Input 
                                      %14 = OpTypeInt 32 0 
                                  u32 %15 = OpConstant 4 
                                      %16 = OpTypeArray %7 %15 
                                      %17 = OpTypeArray %7 %15 
                                      %18 = OpTypeStruct %16 %17 
                                      %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                      %21 = OpTypeInt 32 1 
                                  i32 %22 = OpConstant 0 
                                  i32 %23 = OpConstant 1 
                                      %24 = OpTypePointer Uniform %7 
                                  i32 %35 = OpConstant 2 
                                  i32 %44 = OpConstant 3 
                       Private f32_4* %48 = OpVariable Private 
                                  u32 %75 = OpConstant 1 
                                      %76 = OpTypeArray %6 %75 
                                      %77 = OpTypeStruct %7 %6 %76 
                                      %78 = OpTypePointer Output %77 
 Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                      %81 = OpTypePointer Output %7 
                        Output f32_4* %83 = OpVariable Output 
                         Input f32_4* %84 = OpVariable Input 
                                      %86 = OpTypeVector %6 2 
                                      %87 = OpTypePointer Output %86 
                        Output f32_2* %88 = OpVariable Output 
                                      %89 = OpTypePointer Input %86 
                         Input f32_2* %90 = OpVariable Input 
                                      %92 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                                f32_4 %12 = OpLoad %11 
                                f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                       Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                f32_4 %26 = OpLoad %25 
                                f32_4 %27 = OpFMul %13 %26 
                                              OpStore %9 %27 
                       Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                f32_4 %29 = OpLoad %28 
                                f32_4 %30 = OpLoad %11 
                                f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                f32_4 %32 = OpFMul %29 %31 
                                f32_4 %33 = OpLoad %9 
                                f32_4 %34 = OpFAdd %32 %33 
                                              OpStore %9 %34 
                       Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                f32_4 %37 = OpLoad %36 
                                f32_4 %38 = OpLoad %11 
                                f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                f32_4 %40 = OpFMul %37 %39 
                                f32_4 %41 = OpLoad %9 
                                f32_4 %42 = OpFAdd %40 %41 
                                              OpStore %9 %42 
                                f32_4 %43 = OpLoad %9 
                       Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                f32_4 %46 = OpLoad %45 
                                f32_4 %47 = OpFAdd %43 %46 
                                              OpStore %9 %47 
                                f32_4 %49 = OpLoad %9 
                                f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                       Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                f32_4 %52 = OpLoad %51 
                                f32_4 %53 = OpFMul %50 %52 
                                              OpStore %48 %53 
                       Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                f32_4 %55 = OpLoad %54 
                                f32_4 %56 = OpLoad %9 
                                f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                f32_4 %58 = OpFMul %55 %57 
                                f32_4 %59 = OpLoad %48 
                                f32_4 %60 = OpFAdd %58 %59 
                                              OpStore %48 %60 
                       Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                f32_4 %62 = OpLoad %61 
                                f32_4 %63 = OpLoad %9 
                                f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                f32_4 %65 = OpFMul %62 %64 
                                f32_4 %66 = OpLoad %48 
                                f32_4 %67 = OpFAdd %65 %66 
                                              OpStore %48 %67 
                       Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
                                f32_4 %69 = OpLoad %68 
                                f32_4 %70 = OpLoad %9 
                                f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                f32_4 %72 = OpFMul %69 %71 
                                f32_4 %73 = OpLoad %48 
                                f32_4 %74 = OpFAdd %72 %73 
                                              OpStore %9 %74 
                                f32_4 %80 = OpLoad %9 
                        Output f32_4* %82 = OpAccessChain %79 %22 
                                              OpStore %82 %80 
                                f32_4 %85 = OpLoad %84 
                                              OpStore %83 %85 
                                f32_2 %91 = OpLoad %90 
                                              OpStore %88 %91 
                          Output f32* %93 = OpAccessChain %79 %22 %75 
                                  f32 %94 = OpLoad %93 
                                  f32 %95 = OpFNegate %94 
                          Output f32* %96 = OpAccessChain %79 %22 %75 
                                              OpStore %96 %95 
                                              OpReturn
                                              OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 68
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %44 %65 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %44 Location 44 
                                                    OpDecorate %65 RelaxedPrecision 
                                                    OpDecorate %65 Location 65 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypePointer Private %6 
                               Private f32* %42 = OpVariable Private 
                                            %43 = OpTypePointer Input %7 
                               Input f32_4* %44 = OpVariable Input 
                                            %45 = OpTypeInt 32 0 
                                        u32 %46 = OpConstant 3 
                                            %47 = OpTypePointer Input %6 
                                        f32 %51 = OpConstant 3.67402E-40 
                                            %53 = OpTypeVector %6 3 
                                            %64 = OpTypePointer Output %7 
                              Output f32_4* %65 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %48 = OpAccessChain %44 %46 
                                        f32 %49 = OpLoad %48 
                                        f32 %50 = OpFNegate %49 
                                        f32 %52 = OpFAdd %50 %51 
                                                    OpStore %42 %52 
                                      f32_4 %54 = OpLoad %37 
                                      f32_3 %55 = OpVectorShuffle %54 %54 0 1 2 
                                      f32_4 %56 = OpLoad %44 
                                      f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                      f32_3 %58 = OpFMul %55 %57 
                                        f32 %59 = OpLoad %42 
                                      f32_3 %60 = OpCompositeConstruct %59 %59 %59 
                                      f32_3 %61 = OpFAdd %58 %60 
                                      f32_4 %62 = OpLoad %37 
                                      f32_4 %63 = OpVectorShuffle %62 %61 4 5 6 3 
                                                    OpStore %37 %63 
                                      f32_4 %66 = OpLoad %37 
                                                    OpStore %65 %66 
                                                    OpReturn
                                                    OpFunctionEnd
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  xlat_varoutput_2.xyz = mix (vec3(1.0, 1.0, 1.0), xlat_varoutput_2.xyz, vec3(tmpvar_4));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  xlat_varoutput_2.xyz = mix (vec3(1.0, 1.0, 1.0), xlat_varoutput_2.xyz, vec3(tmpvar_4));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying lowp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * 1.05) * (_TintColor * 2.0));
  xlat_varoutput_2 = tmpvar_3;
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz * xlv_COLOR.xyz);
  xlat_varoutput_2.xyz = (xlat_varoutput_2.xyz + (1.0 - xlv_COLOR.w));
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  xlat_varoutput_2.xyz = mix (vec3(1.0, 1.0, 1.0), xlat_varoutput_2.xyz, vec3(tmpvar_4));
  tmpvar_1 = xlat_varoutput_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2.x = (-vs_COLOR0.w) + 1.0;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2.x = (-vs_COLOR0.w) + 1.0;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in mediump vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(1.04999995, 1.04999995, 1.04999995, 1.04999995);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat0 = u_xlat16_0 * u_xlat16_1;
    u_xlat2.x = (-vs_COLOR0.w) + 1.0;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.xyz + u_xlat2.xxx;
    u_xlat2.xyz = u_xlat2.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0 = u_xlat0;
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
; Bound: 135
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %79 %111 %121 %122 %126 %128 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpMemberDecorate %18 0 Offset 18 
                                                      OpMemberDecorate %18 1 Offset 18 
                                                      OpMemberDecorate %18 2 Offset 18 
                                                      OpMemberDecorate %18 3 Offset 18 
                                                      OpDecorate %18 Block 
                                                      OpDecorate %20 DescriptorSet 20 
                                                      OpDecorate %20 Binding 20 
                                                      OpDecorate %30 RelaxedPrecision 
                                                      OpDecorate %31 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpMemberDecorate %77 0 BuiltIn 77 
                                                      OpMemberDecorate %77 1 BuiltIn 77 
                                                      OpMemberDecorate %77 2 BuiltIn 77 
                                                      OpDecorate %77 Block 
                                                      OpDecorate %111 Location 111 
                                                      OpDecorate %121 Location 121 
                                                      OpDecorate %122 Location 122 
                                                      OpDecorate %126 RelaxedPrecision 
                                                      OpDecorate %126 Location 126 
                                                      OpDecorate %128 RelaxedPrecision 
                                                      OpDecorate %128 Location 128 
                                                      OpDecorate %129 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeStruct %7 %16 %17 %7 
                                              %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
                                              %21 = OpTypeInt 32 1 
                                          i32 %22 = OpConstant 1 
                                              %23 = OpTypePointer Uniform %7 
                                          i32 %27 = OpConstant 0 
                                          i32 %35 = OpConstant 2 
                                          i32 %44 = OpConstant 3 
                               Private f32_4* %48 = OpVariable Private 
                                          u32 %75 = OpConstant 1 
                                              %76 = OpTypeArray %6 %75 
                                              %77 = OpTypeStruct %7 %6 %76 
                                              %78 = OpTypePointer Output %77 
         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                              %81 = OpTypePointer Output %7 
                                          u32 %83 = OpConstant 2 
                                              %84 = OpTypePointer Private %6 
                                              %87 = OpTypePointer Uniform %6 
                                          u32 %91 = OpConstant 0 
                                          f32 %96 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                                             %110 = OpTypePointer Output %6 
                                 Output f32* %111 = OpVariable Output 
                                         u32 %117 = OpConstant 3 
                               Output f32_4* %121 = OpVariable Output 
                                Input f32_4* %122 = OpVariable Input 
                                             %124 = OpTypeVector %6 2 
                                             %125 = OpTypePointer Output %124 
                               Output f32_2* %126 = OpVariable Output 
                                             %127 = OpTypePointer Input %124 
                                Input f32_2* %128 = OpVariable Input 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                        f32_4 %25 = OpLoad %24 
                                        f32_4 %26 = OpFMul %13 %25 
                                                      OpStore %9 %26 
                               Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                        f32_4 %29 = OpLoad %28 
                                        f32_4 %30 = OpLoad %11 
                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                        f32_4 %32 = OpFMul %29 %31 
                                        f32_4 %33 = OpLoad %9 
                                        f32_4 %34 = OpFAdd %32 %33 
                                                      OpStore %9 %34 
                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                        f32_4 %37 = OpLoad %36 
                                        f32_4 %38 = OpLoad %11 
                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                        f32_4 %40 = OpFMul %37 %39 
                                        f32_4 %41 = OpLoad %9 
                                        f32_4 %42 = OpFAdd %40 %41 
                                                      OpStore %9 %42 
                                        f32_4 %43 = OpLoad %9 
                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                        f32_4 %46 = OpLoad %45 
                                        f32_4 %47 = OpFAdd %43 %46 
                                                      OpStore %9 %47 
                                        f32_4 %49 = OpLoad %9 
                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                               Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                        f32_4 %52 = OpLoad %51 
                                        f32_4 %53 = OpFMul %50 %52 
                                                      OpStore %48 %53 
                               Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                        f32_4 %55 = OpLoad %54 
                                        f32_4 %56 = OpLoad %9 
                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                        f32_4 %58 = OpFMul %55 %57 
                                        f32_4 %59 = OpLoad %48 
                                        f32_4 %60 = OpFAdd %58 %59 
                                                      OpStore %48 %60 
                               Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                        f32_4 %62 = OpLoad %61 
                                        f32_4 %63 = OpLoad %9 
                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                        f32_4 %65 = OpFMul %62 %64 
                                        f32_4 %66 = OpLoad %48 
                                        f32_4 %67 = OpFAdd %65 %66 
                                                      OpStore %48 %67 
                               Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                        f32_4 %69 = OpLoad %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                        f32_4 %72 = OpFMul %69 %71 
                                        f32_4 %73 = OpLoad %48 
                                        f32_4 %74 = OpFAdd %72 %73 
                                                      OpStore %9 %74 
                                        f32_4 %80 = OpLoad %9 
                                Output f32_4* %82 = OpAccessChain %79 %27 
                                                      OpStore %82 %80 
                                 Private f32* %85 = OpAccessChain %9 %83 
                                          f32 %86 = OpLoad %85 
                                 Uniform f32* %88 = OpAccessChain %20 %27 %75 
                                          f32 %89 = OpLoad %88 
                                          f32 %90 = OpFDiv %86 %89 
                                 Private f32* %92 = OpAccessChain %9 %91 
                                                      OpStore %92 %90 
                                 Private f32* %93 = OpAccessChain %9 %91 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFNegate %94 
                                          f32 %97 = OpFAdd %95 %96 
                                 Private f32* %98 = OpAccessChain %9 %91 
                                                      OpStore %98 %97 
                                 Private f32* %99 = OpAccessChain %9 %91 
                                         f32 %100 = OpLoad %99 
                                Uniform f32* %101 = OpAccessChain %20 %27 %83 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                Private f32* %104 = OpAccessChain %9 %91 
                                                      OpStore %104 %103 
                                Private f32* %105 = OpAccessChain %9 %91 
                                         f32 %106 = OpLoad %105 
                                         f32 %108 = OpExtInst %1 40 %106 %107 
                                Private f32* %109 = OpAccessChain %9 %91 
                                                      OpStore %109 %108 
                                Private f32* %112 = OpAccessChain %9 %91 
                                         f32 %113 = OpLoad %112 
                                Uniform f32* %114 = OpAccessChain %20 %44 %83 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %113 %115 
                                Uniform f32* %118 = OpAccessChain %20 %44 %117 
                                         f32 %119 = OpLoad %118 
                                         f32 %120 = OpFAdd %116 %119 
                                                      OpStore %111 %120 
                                       f32_4 %123 = OpLoad %122 
                                                      OpStore %121 %123 
                                       f32_2 %129 = OpLoad %128 
                                                      OpStore %126 %129 
                                 Output f32* %130 = OpAccessChain %79 %27 %75 
                                         f32 %131 = OpLoad %130 
                                         f32 %132 = OpFNegate %131 
                                 Output f32* %133 = OpAccessChain %79 %27 %75 
                                                      OpStore %133 %132 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 87
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %45 %70 %84 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %45 Location 45 
                                                    OpDecorate %70 Location 70 
                                                    OpDecorate %84 RelaxedPrecision 
                                                    OpDecorate %84 Location 84 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypeVector %6 3 
                                            %42 = OpTypePointer Private %41 
                             Private f32_3* %43 = OpVariable Private 
                                            %44 = OpTypePointer Input %7 
                               Input f32_4* %45 = OpVariable Input 
                                            %46 = OpTypeInt 32 0 
                                        u32 %47 = OpConstant 3 
                                            %48 = OpTypePointer Input %6 
                                        f32 %52 = OpConstant 3.67402E-40 
                                        u32 %54 = OpConstant 0 
                                            %55 = OpTypePointer Private %6 
                                        f32 %66 = OpConstant 3.67402E-40 
                                      f32_3 %67 = OpConstantComposite %66 %66 %66 
                               Private f32* %69 = OpVariable Private 
                                 Input f32* %70 = OpVariable Input 
                                        f32 %73 = OpConstant 3.67402E-40 
                                      f32_3 %79 = OpConstantComposite %52 %52 %52 
                                            %83 = OpTypePointer Output %7 
                              Output f32_4* %84 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %49 = OpAccessChain %45 %47 
                                        f32 %50 = OpLoad %49 
                                        f32 %51 = OpFNegate %50 
                                        f32 %53 = OpFAdd %51 %52 
                               Private f32* %56 = OpAccessChain %43 %54 
                                                    OpStore %56 %53 
                                      f32_4 %57 = OpLoad %37 
                                      f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                                      f32_4 %59 = OpLoad %45 
                                      f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                      f32_3 %61 = OpFMul %58 %60 
                                      f32_3 %62 = OpLoad %43 
                                      f32_3 %63 = OpVectorShuffle %62 %62 0 0 0 
                                      f32_3 %64 = OpFAdd %61 %63 
                                                    OpStore %43 %64 
                                      f32_3 %65 = OpLoad %43 
                                      f32_3 %68 = OpFAdd %65 %67 
                                                    OpStore %43 %68 
                                        f32 %71 = OpLoad %70 
                                                    OpStore %69 %71 
                                        f32 %72 = OpLoad %69 
                                        f32 %74 = OpExtInst %1 43 %72 %73 %52 
                                                    OpStore %69 %74 
                                        f32 %75 = OpLoad %69 
                                      f32_3 %76 = OpCompositeConstruct %75 %75 %75 
                                      f32_3 %77 = OpLoad %43 
                                      f32_3 %78 = OpFMul %76 %77 
                                      f32_3 %80 = OpFAdd %78 %79 
                                      f32_4 %81 = OpLoad %37 
                                      f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                    OpStore %37 %82 
                                      f32_4 %85 = OpLoad %37 
                                                    OpStore %84 %85 
                                                    OpReturn
                                                    OpFunctionEnd
"
}
SubProgram "vulkan hw_tier01 " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 135
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %79 %111 %121 %122 %126 %128 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpMemberDecorate %18 0 Offset 18 
                                                      OpMemberDecorate %18 1 Offset 18 
                                                      OpMemberDecorate %18 2 Offset 18 
                                                      OpMemberDecorate %18 3 Offset 18 
                                                      OpDecorate %18 Block 
                                                      OpDecorate %20 DescriptorSet 20 
                                                      OpDecorate %20 Binding 20 
                                                      OpDecorate %30 RelaxedPrecision 
                                                      OpDecorate %31 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpMemberDecorate %77 0 BuiltIn 77 
                                                      OpMemberDecorate %77 1 BuiltIn 77 
                                                      OpMemberDecorate %77 2 BuiltIn 77 
                                                      OpDecorate %77 Block 
                                                      OpDecorate %111 Location 111 
                                                      OpDecorate %121 Location 121 
                                                      OpDecorate %122 Location 122 
                                                      OpDecorate %126 RelaxedPrecision 
                                                      OpDecorate %126 Location 126 
                                                      OpDecorate %128 RelaxedPrecision 
                                                      OpDecorate %128 Location 128 
                                                      OpDecorate %129 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeStruct %7 %16 %17 %7 
                                              %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
                                              %21 = OpTypeInt 32 1 
                                          i32 %22 = OpConstant 1 
                                              %23 = OpTypePointer Uniform %7 
                                          i32 %27 = OpConstant 0 
                                          i32 %35 = OpConstant 2 
                                          i32 %44 = OpConstant 3 
                               Private f32_4* %48 = OpVariable Private 
                                          u32 %75 = OpConstant 1 
                                              %76 = OpTypeArray %6 %75 
                                              %77 = OpTypeStruct %7 %6 %76 
                                              %78 = OpTypePointer Output %77 
         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                              %81 = OpTypePointer Output %7 
                                          u32 %83 = OpConstant 2 
                                              %84 = OpTypePointer Private %6 
                                              %87 = OpTypePointer Uniform %6 
                                          u32 %91 = OpConstant 0 
                                          f32 %96 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                                             %110 = OpTypePointer Output %6 
                                 Output f32* %111 = OpVariable Output 
                                         u32 %117 = OpConstant 3 
                               Output f32_4* %121 = OpVariable Output 
                                Input f32_4* %122 = OpVariable Input 
                                             %124 = OpTypeVector %6 2 
                                             %125 = OpTypePointer Output %124 
                               Output f32_2* %126 = OpVariable Output 
                                             %127 = OpTypePointer Input %124 
                                Input f32_2* %128 = OpVariable Input 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                        f32_4 %25 = OpLoad %24 
                                        f32_4 %26 = OpFMul %13 %25 
                                                      OpStore %9 %26 
                               Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                        f32_4 %29 = OpLoad %28 
                                        f32_4 %30 = OpLoad %11 
                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                        f32_4 %32 = OpFMul %29 %31 
                                        f32_4 %33 = OpLoad %9 
                                        f32_4 %34 = OpFAdd %32 %33 
                                                      OpStore %9 %34 
                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                        f32_4 %37 = OpLoad %36 
                                        f32_4 %38 = OpLoad %11 
                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                        f32_4 %40 = OpFMul %37 %39 
                                        f32_4 %41 = OpLoad %9 
                                        f32_4 %42 = OpFAdd %40 %41 
                                                      OpStore %9 %42 
                                        f32_4 %43 = OpLoad %9 
                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                        f32_4 %46 = OpLoad %45 
                                        f32_4 %47 = OpFAdd %43 %46 
                                                      OpStore %9 %47 
                                        f32_4 %49 = OpLoad %9 
                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                               Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                        f32_4 %52 = OpLoad %51 
                                        f32_4 %53 = OpFMul %50 %52 
                                                      OpStore %48 %53 
                               Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                        f32_4 %55 = OpLoad %54 
                                        f32_4 %56 = OpLoad %9 
                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                        f32_4 %58 = OpFMul %55 %57 
                                        f32_4 %59 = OpLoad %48 
                                        f32_4 %60 = OpFAdd %58 %59 
                                                      OpStore %48 %60 
                               Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                        f32_4 %62 = OpLoad %61 
                                        f32_4 %63 = OpLoad %9 
                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                        f32_4 %65 = OpFMul %62 %64 
                                        f32_4 %66 = OpLoad %48 
                                        f32_4 %67 = OpFAdd %65 %66 
                                                      OpStore %48 %67 
                               Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                        f32_4 %69 = OpLoad %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                        f32_4 %72 = OpFMul %69 %71 
                                        f32_4 %73 = OpLoad %48 
                                        f32_4 %74 = OpFAdd %72 %73 
                                                      OpStore %9 %74 
                                        f32_4 %80 = OpLoad %9 
                                Output f32_4* %82 = OpAccessChain %79 %27 
                                                      OpStore %82 %80 
                                 Private f32* %85 = OpAccessChain %9 %83 
                                          f32 %86 = OpLoad %85 
                                 Uniform f32* %88 = OpAccessChain %20 %27 %75 
                                          f32 %89 = OpLoad %88 
                                          f32 %90 = OpFDiv %86 %89 
                                 Private f32* %92 = OpAccessChain %9 %91 
                                                      OpStore %92 %90 
                                 Private f32* %93 = OpAccessChain %9 %91 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFNegate %94 
                                          f32 %97 = OpFAdd %95 %96 
                                 Private f32* %98 = OpAccessChain %9 %91 
                                                      OpStore %98 %97 
                                 Private f32* %99 = OpAccessChain %9 %91 
                                         f32 %100 = OpLoad %99 
                                Uniform f32* %101 = OpAccessChain %20 %27 %83 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                Private f32* %104 = OpAccessChain %9 %91 
                                                      OpStore %104 %103 
                                Private f32* %105 = OpAccessChain %9 %91 
                                         f32 %106 = OpLoad %105 
                                         f32 %108 = OpExtInst %1 40 %106 %107 
                                Private f32* %109 = OpAccessChain %9 %91 
                                                      OpStore %109 %108 
                                Private f32* %112 = OpAccessChain %9 %91 
                                         f32 %113 = OpLoad %112 
                                Uniform f32* %114 = OpAccessChain %20 %44 %83 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %113 %115 
                                Uniform f32* %118 = OpAccessChain %20 %44 %117 
                                         f32 %119 = OpLoad %118 
                                         f32 %120 = OpFAdd %116 %119 
                                                      OpStore %111 %120 
                                       f32_4 %123 = OpLoad %122 
                                                      OpStore %121 %123 
                                       f32_2 %129 = OpLoad %128 
                                                      OpStore %126 %129 
                                 Output f32* %130 = OpAccessChain %79 %27 %75 
                                         f32 %131 = OpLoad %130 
                                         f32 %132 = OpFNegate %131 
                                 Output f32* %133 = OpAccessChain %79 %27 %75 
                                                      OpStore %133 %132 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 87
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %45 %70 %84 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %45 Location 45 
                                                    OpDecorate %70 Location 70 
                                                    OpDecorate %84 RelaxedPrecision 
                                                    OpDecorate %84 Location 84 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypeVector %6 3 
                                            %42 = OpTypePointer Private %41 
                             Private f32_3* %43 = OpVariable Private 
                                            %44 = OpTypePointer Input %7 
                               Input f32_4* %45 = OpVariable Input 
                                            %46 = OpTypeInt 32 0 
                                        u32 %47 = OpConstant 3 
                                            %48 = OpTypePointer Input %6 
                                        f32 %52 = OpConstant 3.67402E-40 
                                        u32 %54 = OpConstant 0 
                                            %55 = OpTypePointer Private %6 
                                        f32 %66 = OpConstant 3.67402E-40 
                                      f32_3 %67 = OpConstantComposite %66 %66 %66 
                               Private f32* %69 = OpVariable Private 
                                 Input f32* %70 = OpVariable Input 
                                        f32 %73 = OpConstant 3.67402E-40 
                                      f32_3 %79 = OpConstantComposite %52 %52 %52 
                                            %83 = OpTypePointer Output %7 
                              Output f32_4* %84 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %49 = OpAccessChain %45 %47 
                                        f32 %50 = OpLoad %49 
                                        f32 %51 = OpFNegate %50 
                                        f32 %53 = OpFAdd %51 %52 
                               Private f32* %56 = OpAccessChain %43 %54 
                                                    OpStore %56 %53 
                                      f32_4 %57 = OpLoad %37 
                                      f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                                      f32_4 %59 = OpLoad %45 
                                      f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                      f32_3 %61 = OpFMul %58 %60 
                                      f32_3 %62 = OpLoad %43 
                                      f32_3 %63 = OpVectorShuffle %62 %62 0 0 0 
                                      f32_3 %64 = OpFAdd %61 %63 
                                                    OpStore %43 %64 
                                      f32_3 %65 = OpLoad %43 
                                      f32_3 %68 = OpFAdd %65 %67 
                                                    OpStore %43 %68 
                                        f32 %71 = OpLoad %70 
                                                    OpStore %69 %71 
                                        f32 %72 = OpLoad %69 
                                        f32 %74 = OpExtInst %1 43 %72 %73 %52 
                                                    OpStore %69 %74 
                                        f32 %75 = OpLoad %69 
                                      f32_3 %76 = OpCompositeConstruct %75 %75 %75 
                                      f32_3 %77 = OpLoad %43 
                                      f32_3 %78 = OpFMul %76 %77 
                                      f32_3 %80 = OpFAdd %78 %79 
                                      f32_4 %81 = OpLoad %37 
                                      f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                    OpStore %37 %82 
                                      f32_4 %85 = OpLoad %37 
                                                    OpStore %84 %85 
                                                    OpReturn
                                                    OpFunctionEnd
"
}
SubProgram "vulkan hw_tier02 " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 135
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %11 %79 %111 %121 %122 %126 %128 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 ArrayStride 16 
                                                      OpDecorate %17 ArrayStride 17 
                                                      OpMemberDecorate %18 0 Offset 18 
                                                      OpMemberDecorate %18 1 Offset 18 
                                                      OpMemberDecorate %18 2 Offset 18 
                                                      OpMemberDecorate %18 3 Offset 18 
                                                      OpDecorate %18 Block 
                                                      OpDecorate %20 DescriptorSet 20 
                                                      OpDecorate %20 Binding 20 
                                                      OpDecorate %30 RelaxedPrecision 
                                                      OpDecorate %31 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpMemberDecorate %77 0 BuiltIn 77 
                                                      OpMemberDecorate %77 1 BuiltIn 77 
                                                      OpMemberDecorate %77 2 BuiltIn 77 
                                                      OpDecorate %77 Block 
                                                      OpDecorate %111 Location 111 
                                                      OpDecorate %121 Location 121 
                                                      OpDecorate %122 Location 122 
                                                      OpDecorate %126 RelaxedPrecision 
                                                      OpDecorate %126 Location 126 
                                                      OpDecorate %128 RelaxedPrecision 
                                                      OpDecorate %128 Location 128 
                                                      OpDecorate %129 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %14 = OpTypeInt 32 0 
                                          u32 %15 = OpConstant 4 
                                              %16 = OpTypeArray %7 %15 
                                              %17 = OpTypeArray %7 %15 
                                              %18 = OpTypeStruct %7 %16 %17 %7 
                                              %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
                                              %21 = OpTypeInt 32 1 
                                          i32 %22 = OpConstant 1 
                                              %23 = OpTypePointer Uniform %7 
                                          i32 %27 = OpConstant 0 
                                          i32 %35 = OpConstant 2 
                                          i32 %44 = OpConstant 3 
                               Private f32_4* %48 = OpVariable Private 
                                          u32 %75 = OpConstant 1 
                                              %76 = OpTypeArray %6 %75 
                                              %77 = OpTypeStruct %7 %6 %76 
                                              %78 = OpTypePointer Output %77 
         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
                                              %81 = OpTypePointer Output %7 
                                          u32 %83 = OpConstant 2 
                                              %84 = OpTypePointer Private %6 
                                              %87 = OpTypePointer Uniform %6 
                                          u32 %91 = OpConstant 0 
                                          f32 %96 = OpConstant 3.67402E-40 
                                         f32 %107 = OpConstant 3.67402E-40 
                                             %110 = OpTypePointer Output %6 
                                 Output f32* %111 = OpVariable Output 
                                         u32 %117 = OpConstant 3 
                               Output f32_4* %121 = OpVariable Output 
                                Input f32_4* %122 = OpVariable Input 
                                             %124 = OpTypeVector %6 2 
                                             %125 = OpTypePointer Output %124 
                               Output f32_2* %126 = OpVariable Output 
                                             %127 = OpTypePointer Input %124 
                                Input f32_2* %128 = OpVariable Input 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                               Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                        f32_4 %25 = OpLoad %24 
                                        f32_4 %26 = OpFMul %13 %25 
                                                      OpStore %9 %26 
                               Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                        f32_4 %29 = OpLoad %28 
                                        f32_4 %30 = OpLoad %11 
                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                        f32_4 %32 = OpFMul %29 %31 
                                        f32_4 %33 = OpLoad %9 
                                        f32_4 %34 = OpFAdd %32 %33 
                                                      OpStore %9 %34 
                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                        f32_4 %37 = OpLoad %36 
                                        f32_4 %38 = OpLoad %11 
                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                        f32_4 %40 = OpFMul %37 %39 
                                        f32_4 %41 = OpLoad %9 
                                        f32_4 %42 = OpFAdd %40 %41 
                                                      OpStore %9 %42 
                                        f32_4 %43 = OpLoad %9 
                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                        f32_4 %46 = OpLoad %45 
                                        f32_4 %47 = OpFAdd %43 %46 
                                                      OpStore %9 %47 
                                        f32_4 %49 = OpLoad %9 
                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                               Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                        f32_4 %52 = OpLoad %51 
                                        f32_4 %53 = OpFMul %50 %52 
                                                      OpStore %48 %53 
                               Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                        f32_4 %55 = OpLoad %54 
                                        f32_4 %56 = OpLoad %9 
                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                        f32_4 %58 = OpFMul %55 %57 
                                        f32_4 %59 = OpLoad %48 
                                        f32_4 %60 = OpFAdd %58 %59 
                                                      OpStore %48 %60 
                               Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                        f32_4 %62 = OpLoad %61 
                                        f32_4 %63 = OpLoad %9 
                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                        f32_4 %65 = OpFMul %62 %64 
                                        f32_4 %66 = OpLoad %48 
                                        f32_4 %67 = OpFAdd %65 %66 
                                                      OpStore %48 %67 
                               Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                        f32_4 %69 = OpLoad %68 
                                        f32_4 %70 = OpLoad %9 
                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                        f32_4 %72 = OpFMul %69 %71 
                                        f32_4 %73 = OpLoad %48 
                                        f32_4 %74 = OpFAdd %72 %73 
                                                      OpStore %9 %74 
                                        f32_4 %80 = OpLoad %9 
                                Output f32_4* %82 = OpAccessChain %79 %27 
                                                      OpStore %82 %80 
                                 Private f32* %85 = OpAccessChain %9 %83 
                                          f32 %86 = OpLoad %85 
                                 Uniform f32* %88 = OpAccessChain %20 %27 %75 
                                          f32 %89 = OpLoad %88 
                                          f32 %90 = OpFDiv %86 %89 
                                 Private f32* %92 = OpAccessChain %9 %91 
                                                      OpStore %92 %90 
                                 Private f32* %93 = OpAccessChain %9 %91 
                                          f32 %94 = OpLoad %93 
                                          f32 %95 = OpFNegate %94 
                                          f32 %97 = OpFAdd %95 %96 
                                 Private f32* %98 = OpAccessChain %9 %91 
                                                      OpStore %98 %97 
                                 Private f32* %99 = OpAccessChain %9 %91 
                                         f32 %100 = OpLoad %99 
                                Uniform f32* %101 = OpAccessChain %20 %27 %83 
                                         f32 %102 = OpLoad %101 
                                         f32 %103 = OpFMul %100 %102 
                                Private f32* %104 = OpAccessChain %9 %91 
                                                      OpStore %104 %103 
                                Private f32* %105 = OpAccessChain %9 %91 
                                         f32 %106 = OpLoad %105 
                                         f32 %108 = OpExtInst %1 40 %106 %107 
                                Private f32* %109 = OpAccessChain %9 %91 
                                                      OpStore %109 %108 
                                Private f32* %112 = OpAccessChain %9 %91 
                                         f32 %113 = OpLoad %112 
                                Uniform f32* %114 = OpAccessChain %20 %44 %83 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %113 %115 
                                Uniform f32* %118 = OpAccessChain %20 %44 %117 
                                         f32 %119 = OpLoad %118 
                                         f32 %120 = OpFAdd %116 %119 
                                                      OpStore %111 %120 
                                       f32_4 %123 = OpLoad %122 
                                                      OpStore %121 %123 
                                       f32_2 %129 = OpLoad %128 
                                                      OpStore %126 %129 
                                 Output f32* %130 = OpAccessChain %79 %27 %75 
                                         f32 %131 = OpLoad %130 
                                         f32 %132 = OpFNegate %131 
                                 Output f32* %133 = OpAccessChain %79 %27 %75 
                                                      OpStore %133 %132 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 1
; Bound: 87
; Schema: 0
                                                    OpCapability Shader 
                                             %1 = OpExtInstImport "GLSL.std.450" 
                                                    OpMemoryModel Logical GLSL450 
                                                    OpEntryPoint Fragment %4 "main" %17 %45 %70 %84 
                                                    OpExecutionMode %4 OriginUpperLeft 
                                                    OpDecorate %9 RelaxedPrecision 
                                                    OpDecorate %13 RelaxedPrecision 
                                                    OpDecorate %13 DescriptorSet 13 
                                                    OpDecorate %13 Binding 13 
                                                    OpDecorate %14 RelaxedPrecision 
                                                    OpDecorate %17 RelaxedPrecision 
                                                    OpDecorate %17 Location 17 
                                                    OpDecorate %18 RelaxedPrecision 
                                                    OpDecorate %20 RelaxedPrecision 
                                                    OpDecorate %21 RelaxedPrecision 
                                                    OpDecorate %24 RelaxedPrecision 
                                                    OpDecorate %25 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 RelaxedPrecision 
                                                    OpMemberDecorate %26 0 Offset 26 
                                                    OpDecorate %26 Block 
                                                    OpDecorate %28 DescriptorSet 28 
                                                    OpDecorate %28 Binding 28 
                                                    OpDecorate %33 RelaxedPrecision 
                                                    OpDecorate %35 RelaxedPrecision 
                                                    OpDecorate %36 RelaxedPrecision 
                                                    OpDecorate %38 RelaxedPrecision 
                                                    OpDecorate %39 RelaxedPrecision 
                                                    OpDecorate %40 RelaxedPrecision 
                                                    OpDecorate %45 Location 45 
                                                    OpDecorate %70 Location 70 
                                                    OpDecorate %84 RelaxedPrecision 
                                                    OpDecorate %84 Location 84 
                                             %2 = OpTypeVoid 
                                             %3 = OpTypeFunction %2 
                                             %6 = OpTypeFloat 32 
                                             %7 = OpTypeVector %6 4 
                                             %8 = OpTypePointer Private %7 
                              Private f32_4* %9 = OpVariable Private 
                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                            %11 = OpTypeSampledImage %10 
                                            %12 = OpTypePointer UniformConstant %11 
UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
                                            %15 = OpTypeVector %6 2 
                                            %16 = OpTypePointer Input %15 
                               Input f32_2* %17 = OpVariable Input 
                             Private f32_4* %20 = OpVariable Private 
                                        f32 %22 = OpConstant 3.67402E-40 
                                      f32_4 %23 = OpConstantComposite %22 %22 %22 %22 
                             Private f32_4* %25 = OpVariable Private 
                                            %26 = OpTypeStruct %7 
                                            %27 = OpTypePointer Uniform %26 
                   Uniform struct {f32_4;}* %28 = OpVariable Uniform 
                                            %29 = OpTypeInt 32 1 
                                        i32 %30 = OpConstant 0 
                                            %31 = OpTypePointer Uniform %7 
                             Private f32_4* %37 = OpVariable Private 
                                            %41 = OpTypeVector %6 3 
                                            %42 = OpTypePointer Private %41 
                             Private f32_3* %43 = OpVariable Private 
                                            %44 = OpTypePointer Input %7 
                               Input f32_4* %45 = OpVariable Input 
                                            %46 = OpTypeInt 32 0 
                                        u32 %47 = OpConstant 3 
                                            %48 = OpTypePointer Input %6 
                                        f32 %52 = OpConstant 3.67402E-40 
                                        u32 %54 = OpConstant 0 
                                            %55 = OpTypePointer Private %6 
                                        f32 %66 = OpConstant 3.67402E-40 
                                      f32_3 %67 = OpConstantComposite %66 %66 %66 
                               Private f32* %69 = OpVariable Private 
                                 Input f32* %70 = OpVariable Input 
                                        f32 %73 = OpConstant 3.67402E-40 
                                      f32_3 %79 = OpConstantComposite %52 %52 %52 
                                            %83 = OpTypePointer Output %7 
                              Output f32_4* %84 = OpVariable Output 
                                        void %4 = OpFunction None %3 
                                             %5 = OpLabel 
                 read_only Texture2DSampled %14 = OpLoad %13 
                                      f32_2 %18 = OpLoad %17 
                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
                                                    OpStore %9 %19 
                                      f32_4 %21 = OpLoad %9 
                                      f32_4 %24 = OpFMul %21 %23 
                                                    OpStore %20 %24 
                             Uniform f32_4* %32 = OpAccessChain %28 %30 
                                      f32_4 %33 = OpLoad %32 
                             Uniform f32_4* %34 = OpAccessChain %28 %30 
                                      f32_4 %35 = OpLoad %34 
                                      f32_4 %36 = OpFAdd %33 %35 
                                                    OpStore %25 %36 
                                      f32_4 %38 = OpLoad %20 
                                      f32_4 %39 = OpLoad %25 
                                      f32_4 %40 = OpFMul %38 %39 
                                                    OpStore %37 %40 
                                 Input f32* %49 = OpAccessChain %45 %47 
                                        f32 %50 = OpLoad %49 
                                        f32 %51 = OpFNegate %50 
                                        f32 %53 = OpFAdd %51 %52 
                               Private f32* %56 = OpAccessChain %43 %54 
                                                    OpStore %56 %53 
                                      f32_4 %57 = OpLoad %37 
                                      f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                                      f32_4 %59 = OpLoad %45 
                                      f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                      f32_3 %61 = OpFMul %58 %60 
                                      f32_3 %62 = OpLoad %43 
                                      f32_3 %63 = OpVectorShuffle %62 %62 0 0 0 
                                      f32_3 %64 = OpFAdd %61 %63 
                                                    OpStore %43 %64 
                                      f32_3 %65 = OpLoad %43 
                                      f32_3 %68 = OpFAdd %65 %67 
                                                    OpStore %43 %68 
                                        f32 %71 = OpLoad %70 
                                                    OpStore %69 %71 
                                        f32 %72 = OpLoad %69 
                                        f32 %74 = OpExtInst %1 43 %72 %73 %52 
                                                    OpStore %69 %74 
                                        f32 %75 = OpLoad %69 
                                      f32_3 %76 = OpCompositeConstruct %75 %75 %75 
                                      f32_3 %77 = OpLoad %43 
                                      f32_3 %78 = OpFMul %76 %77 
                                      f32_3 %80 = OpFAdd %78 %79 
                                      f32_4 %81 = OpLoad %37 
                                      f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
                                                    OpStore %37 %82 
                                      f32_4 %85 = OpLoad %37 
                                                    OpStore %84 %85 
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
}
}