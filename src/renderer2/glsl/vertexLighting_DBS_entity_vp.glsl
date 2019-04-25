/* vertexLighting_DBS_entity_vp.glsl */
#include "lib/vertexSkinning"
#include "lib/vertexAnimation"
#include "lib/deformVertexes"

attribute vec4 attr_Position;
attribute vec4 attr_TexCoord0;
attribute vec3 attr_Tangent;
attribute vec3 attr_Binormal;
attribute vec3 attr_Normal;

attribute vec4 attr_Position2;
attribute vec3 attr_Tangent2;
attribute vec3 attr_Binormal2;
attribute vec3 attr_Normal2;

uniform float u_VertexInterpolation;
uniform vec3  u_LightDir;

uniform mat4 u_ModelMatrix;
uniform mat4 u_ModelViewProjectionMatrix;

uniform float u_Time;

varying vec3 var_FragPos;
varying vec2 var_TexCoords;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
varying mat3 var_TBN;
varying vec3 var_viewPos;
varying vec3 var_TangentFragPos;
varying vec3 var_TangentViewPos;
varying vec3 var_tangentlight;

void main()
{
	vec4 position;
	vec3 tangent;
	vec3 binormal;
	vec3 normal;

#if defined(USE_VERTEX_SKINNING)

	#if defined(USE_NORMAL_MAPPING)
	VertexSkinning_P_TBN(attr_Position, attr_Tangent, attr_Binormal, attr_Normal,
	                     position, tangent, binormal, normal);
	#else
	VertexSkinning_P_N(attr_Position, attr_Normal,
	                   position, normal);
	#endif

#elif defined(USE_VERTEX_ANIMATION)

	#if defined(USE_NORMAL_MAPPING)
	VertexAnimation_P_TBN(attr_Position, attr_Position2,
	                      attr_Tangent, attr_Tangent2,
	                      attr_Binormal, attr_Binormal2,
	                      attr_Normal, attr_Normal2,
	                      u_VertexInterpolation,
	                      position, tangent, binormal, normal);
	#else
	VertexAnimation_P_N(attr_Position, attr_Position2,
	                    attr_Normal, attr_Normal2,
	                    u_VertexInterpolation,
	                    position, normal);
	#endif

#else
	position = attr_Position;

	#if defined(USE_NORMAL_MAPPING)
	tangent  = attr_Tangent;
	binormal = attr_Binormal;
	#endif

	normal = attr_Normal;
#endif

#if defined(USE_DEFORM_VERTEXES)
	position = DeformPosition2(position,
	                           normal,
	                           attr_TexCoord0.st,
	                           u_Time);
#endif

	// transform vertex position into homogenous clip-space
	gl_Position = u_ModelViewProjectionMatrix * position;


	// transform position into world space
	var_FragPos = (u_ModelMatrix * position).xyz;
   // texcoords
	var_TexCoords.st = attr_TexCoord0.st;
	

	mat3 normalMatrix = transpose(inverse(mat3(u_ModelMatrix)));
	
	vec3 T = normalize(normalMatrix * attr_Tangent.xyz);
    vec3 N = normalize(normalMatrix * attr_Normal.xyz);
    T = normalize(T - dot(T, N) * N);
    vec3 B = cross(N, T);
    
    var_TBN = transpose(mat3(T, B, N));

    var_FragPos = vec3(u_ModelMatrix * position).xyz;  
	var_Normal   = attr_Normal.xyz;
	var_tangentlight = u_LightDir * normalMatrix;
	
    var_TangentViewPos = var_TBN * var_viewPos;
    var_TangentFragPos = var_TBN * var_FragPos;
}
