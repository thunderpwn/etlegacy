/* vertexLighting_DBS_world_vp.glsl */
#include "lib/vertexSkinning"
#include "lib/vertexAnimation"
#include "lib/deformVertexes"

attribute vec4 attr_Position;
attribute vec4 attr_TexCoord0;
attribute vec4 attr_TexCoord1;
attribute vec3 attr_Tangent;
attribute vec3 attr_Binormal;
attribute vec3 attr_Normal;
attribute vec4 attr_Color;
uniform int  u_TCGen_Environment;
attribute vec4 attr_Position2;
attribute vec3 attr_Normal2;

uniform float u_VertexInterpolation;
uniform mat4 u_ModelViewProjectionMatrix;
uniform mat4 u_ModelMatrix;
uniform mat4 u_DiffuseTextureMatrix;
uniform mat4 u_NormalTextureMatrix;
uniform mat4 u_SpecularTextureMatrix;
uniform float u_Time;

uniform vec4 u_ColorModulate;
uniform vec4 u_Color;

varying vec3 var_Position;
varying vec3 var_FragPos;
varying vec2 var_TexCoords;


varying vec4 var_LightColor;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
varying mat3 var_TBN;
varying vec3 var_viewPos;
varying vec3 var_TangentFragPos;
varying vec3 var_TangentViewPos;

void main()
{
	vec4 position = attr_Position;
	vec3 normal;
#if defined(USE_VERTEX_SKINNING)
	VertexSkinning_P_N(attr_Position, attr_Normal, position, normal);
#elif defined(USE_VERTEX_ANIMATION)
	VertexAnimation_P_N(attr_Position, attr_Position2, attr_Normal, attr_Normal2, u_VertexInterpolation, position, normal);
#else
	position = attr_Position;
	normal   = attr_Normal;
#endif

#if defined(USE_DEFORM_VERTEXES)
	position = DeformPosition2(position, normal, attr_TexCoord0.st, u_Time);
#endif
	// transform vertex position into homogenous clip-space
	gl_Position = u_ModelViewProjectionMatrix * position;



	

	mat3 normalMatrix = transpose(inverse(mat3(u_ModelMatrix)));
	
	vec3 T = normalize(normalMatrix * attr_Tangent.xyz);
    vec3 N = normalize(normalMatrix * attr_Normal.xyz);
    T = normalize(T - dot(T, N) * N);
    vec3 B = cross(N, T);
    
    var_TBN = transpose(mat3(T, B, N));

    var_FragPos = vec3(u_ModelMatrix * position).xyz;  
	var_Normal   = attr_Normal.xyz;

	
    var_TangentViewPos = var_TBN * var_viewPos;
    var_TangentFragPos = var_TBN * var_FragPos;

	vec4 texCoord;
	// texcoords
	//var_TexCoords.st = (u_DiffuseTextureMatrix * attr_TexCoord0).st;
	//var_TexLight     = attr_TexCoord1.st;

#if defined(USE_TCGEN_ENVIRONMENT)
	{
		vec3 viewer = normalize(u_ViewOrigin - position.xyz);

		float d = dot(attr_Normal, viewer);

		vec3 reflected = attr_Normal * 2.0 * d - viewer;

		texCoord.s = 0.5 + reflected.y * 0.5;
		texCoord.t = 0.5 - reflected.z * 0.5;
		texCoord.q = 0;
		texCoord.w = 1;
	}
#elif defined(USE_TCGEN_LIGHTMAP)
	texCoord = attr_TexCoord1;
#else
	texCoord = attr_TexCoord0;
#endif
	var_TexCoords.st = (u_DiffuseTextureMatrix * texCoord).st;
 // assign color
	var_LightColor = attr_Color * u_ColorModulate + u_Color;
}
