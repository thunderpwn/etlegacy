/* vertexLighting_DBS_world_vp.glsl */
#include "lib/deformVertexes"

attribute vec4 attr_Position;
attribute vec4 attr_TexCoord0;
attribute vec4 attr_TexCoord1;
attribute vec3 attr_Tangent;
attribute vec3 attr_Binormal;
attribute vec3 attr_Normal;
attribute vec4 attr_Color;


uniform mat4 u_ModelViewProjectionMatrix;
uniform mat4 u_ModelMatrix;

uniform float u_Time;

uniform vec4 u_ColorModulate;
uniform vec4 u_Color;

varying vec3 var_Position;
varying vec3 var_FragPos;
varying vec2 var_TexCoords;

varying vec2 var_TexLight;
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
#if defined(USE_DEFORM_VERTEXES)
	position = DeformPosition2(position,
	                           attr_Normal,
	                           attr_TexCoord0.st,
	                           u_Time);
#endif

	// transform vertex position into homogenous clip-space
	gl_Position = u_ModelViewProjectionMatrix * position;



	// texcoords
	var_TexCoords.st = attr_TexCoord0.st;
	var_TexLight     = attr_TexCoord1.st;

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

	
 // assign color
	var_LightColor = attr_Color * u_ColorModulate + u_Color;
}
