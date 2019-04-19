/* lightMapping_fp.glsl */
#include "lib/reliefMapping"

uniform bool SHOW_LIGHTMAP;
uniform bool SHOW_DELUXEMAP;

uniform sampler2D u_DiffuseMap;
uniform sampler2D u_NormalMap;
uniform sampler2D u_SpecularMap;
uniform sampler2D u_LightMap;
uniform sampler2D u_DeluxeMap;
uniform int       u_AlphaTest;
uniform vec3      u_ViewOrigin;
uniform float     u_DepthScale;
uniform vec4      u_PortalPlane;

varying vec3 var_FragPos;
varying vec2 var_TexCoords;
varying vec2 var_TexSpecular;
varying vec2 var_TexLight;

varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;

varying vec4 var_Color;
varying mat3 var_TBN;
varying vec3 var_TangentFragPos;
varying vec3 var_TangentViewPos;
void main()
{
//#if defined(USE_PORTAL_CLIPPING)
//	float dist = dot(var_FragPos.xyz, u_PortalPlane.xyz) - u_PortalPlane.w;
//	if (dist < 0.0)
//	{
//		discard;
//		return;
//	}
//#endif

	// compute view direction in tangent space
	vec3 V =  normalize(var_TangentViewPos - var_TangentFragPos);

	vec4 lightmapColor  = texture2D(u_LightMap, var_TexLight);
	vec4 deluxemapColor = texture2D(u_DeluxeMap, var_TexLight);

	
#if defined(USE_NORMAL_MAPPING)

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
   
	
	// obtain normal from normal map in range [0,1]
	vec3 N =  texture2D(u_NormalMap, var_TexCoords).rgb;

	N = normalize(N * 2.0 - 1.0); // this normal is in tangent space


	// compute light direction in tangent space
	
#if defined (USE_DELUXEMAP)
     //if there is a deluxemap present we use that ofcourse
	vec3 L = texture2D(u_DeluxeMap, var_TexLight).xyz;

	L = normalize(L * 2.0 - 1.0); // this lightdirection is in tangent space
#else
     //this is highly experimental, using values from the lightmap itself,
	 //it works because it gives different values depending on the intensity in the lightmap range from 0 to 1
    vec3 L = texture2D(u_LightMap, var_TexLight).xyz;
	L = normalize(L * 2.0 - 1.0); // this lightdirection is in tangent space
#endif
	// compute half angle in world space
	vec3 H = normalize(L + V);

	vec3 R = reflect(-L, N);
	
	// compute the light term
	//with half lambert
	float NL = dot(N, L) * 0.5 + 0.5;
	NL = NL * NL;

	// compute light color from world space lightmap
	vec3 lightColor = lightmapColor.rgb * NL;

	// compute the specular term
	//vec3 specular = texture2D(u_SpecularMap, texSpecular).rgb * lightColor * pow(clamp(dot(N, H), 0.0, 1.0), r_SpecularExponent) * r_SpecularScale;
	vec3 specular = texture2D(u_SpecularMap, var_TexCoords).rgb * lightColor * pow(max(dot(V, R), 0.0), r_SpecularExponent) * r_SpecularScale;

	// compute final color
	vec4 color = diffuse;
	color.rgb *= lightColor;
	color.rgb += specular;
	// for smooth terrain blending else there is no blending of lightmapped
	color.a   *= var_Color.a; 

#else // DO_NOT_NORMAL_MAPPING

	// compute the diffuse term
	vec4 diffuse = texture2D(u_DiffuseMap, var_TexCoords.st);

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

	vec3 N;

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

	vec3 specular = vec3(0.0, 0.0, 0.0);

	// compute light color from object space lightmap
	vec3 lightColor = lightmapColor.rgb;

	vec4 color = diffuse;
	color.rgb *= lightColor;
	// for smooth terrain blending else there is no blending of lightmapped
	color.a   *= var_Color.a; 
#endif // DO_NOT_NORMAL_MAPPING

	if (SHOW_DELUXEMAP)
	{
		color = deluxemapColor;
	}
	else if (SHOW_LIGHTMAP)
	{
		color = lightmapColor;
	}

	gl_FragColor = color;
}
