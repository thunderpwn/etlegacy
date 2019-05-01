/* vertexLighting_DBS_entity_fp.glsl */
#include "lib/reliefMapping"

uniform sampler2D u_DiffuseMap;
uniform sampler2D u_NormalMap;
uniform sampler2D u_SpecularMap;

uniform samplerCube u_EnvironmentMap0;
uniform samplerCube u_EnvironmentMap1;
uniform float       u_EnvironmentInterpolation;
uniform float u_ambientStrenght;
uniform int   u_AlphaTest;
uniform vec3  u_ViewOrigin;
uniform vec3  u_AmbientColor;
uniform vec3  u_LightColor;
//uniform float u_SpecularExponent;
uniform float u_DepthScale;
uniform vec4  u_PortalPlane;
uniform float u_LightWrapAround;
uniform vec3  u_LightDir;
varying vec3 var_tangentlight;
varying vec3 var_FragPos;
varying vec2 var_TexCoords;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
varying mat3 var_TBN;
varying vec3 var_viewPos;
varying vec3 var_TangentFragPos;
varying vec3 var_TangentViewPos;

void main()
{
//this is for looking thru a portal
#if defined(USE_PORTAL_CLIPPING)
	{
		float dist = dot(var_FragPos.xyz, u_PortalPlane.xyz) - u_PortalPlane.w;
		if (dist < 0.0)
		{
			discard;
			return;
		}
	}
#endif

	
	

#if defined(USE_NORMAL_MAPPING)
	vec3 L = u_LightDir;

	L = L*(inverse(var_TBN));
	// compute view direction in tangent space
	vec3 V =  normalize(var_TangentViewPos - var_TangentFragPos);


	// compute the diffuse term
	vec4 diffuse = texture2D(u_DiffuseMap, var_TexCoords);

#if defined(USE_ALPHA_TESTING)
	if (u_AlphaTest == ATEST_GT_0 && diffuse.a <= 0.0)
	{
		discard;
		return;
	}
	else if (u_AlphaTest == ATEST_LT_128 && diffuse.a >= 0.5)
	{
		discard;
		return;
	}
	else if (u_AlphaTest == ATEST_GE_128 && diffuse.a < 0.5)
	{
		discard;
		return;
	}
#endif

    vec3 N = texture2D(u_NormalMap, var_TexCoords).rgb;
	N = normalize(N * 2.0 - vec3(1.0)); // this normal is in tangent space

	L =normalize(L);

	// compute half angle in world space
	vec3 H = normalize(L + V);

	// compute specular reflection
	vec3 R =  reflect(-L, N);

	// compute the light term
	//leave a bit ambient
	float NL = max(dot(N, L),0.5);
	

 	vec3 light = u_LightColor * NL;
	//vec3 ambient = u_AmbientColor * ambNL;
	
	//vec3  specular = texture2D(u_SpecularMap, var_TexCoords).rgb * u_LightColor * pow(NH, r_SpecularExponent) * r_SpecularScale;
	vec3  specular = texture2D(u_SpecularMap, var_TexCoords).rgb * u_LightColor * pow(max(dot(V, R), 0.0), r_SpecularExponent) * r_SpecularScale;

	 // compute final color
    vec4 color = diffuse;
	color.rgb *=u_AmbientColor;
	color.rgb *=light;
	color.rgb +=specular; 
     



	gl_FragColor = color;


#else // else USE_NORMAL_MAPPING

	vec3 N;
	// compute light direction in world space
	vec3 L = -u_LightDir;
#if defined(TWOSIDED)
	if (!gl_FrontFacing)
	{
		N = -normalize(var_Normal);
		
	}
	else
#endif
	{
		N = normalize(var_Normal);
	}




	// compute the diffuse term
	vec4 diffuse = texture2D(u_DiffuseMap, var_TexCoords);

#if defined(USE_ALPHA_TESTING)
	if (u_AlphaTest == ATEST_GT_0 && diffuse.a <= 0.0)
	{
		discard;
		return;
	}
	else if (u_AlphaTest == ATEST_LT_128 && diffuse.a >= 0.5)
	{
		discard;
		return;
	}
	else if (u_AlphaTest == ATEST_GE_128 && diffuse.a < 0.5)
	{
		discard;
		return;
	}
#endif


	// compute the light term
	//with half lambert
	float NL = dot(N, L) * 0.5 + 0.5;
	NL = NL * NL;
 	vec3 light = (u_AmbientColor + u_LightColor) * NL;
 	

    // compute final color
    vec4 color = diffuse;
    color.rgb *= light;



	gl_FragColor = color;

#endif


}
