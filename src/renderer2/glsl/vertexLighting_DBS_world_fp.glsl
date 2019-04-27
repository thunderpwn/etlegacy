/* vertexLighting_DBS_world_fp.glsl */
#include "lib/reliefMapping"

uniform sampler2D u_DiffuseMap;
uniform sampler2D u_NormalMap;
uniform sampler2D u_SpecularMap;
//we use this for fake light normals
uniform sampler2D u_DeluxeMap;
uniform int       u_AlphaTest;
uniform vec3      u_ViewOrigin;
uniform float     u_DepthScale;
uniform vec4      u_PortalPlane;
uniform float     u_LightWrapAround;
varying vec3 var_Position;
varying vec3 var_FragPos;
varying vec2 var_TexCoords;
varying vec2 var_TexLight;
varying vec4 var_LightColor;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
varying mat3 var_TBN;
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
	N = normalize(N * 2.0 - 1.0); // this normal is in tangent space


	// compute light direction in tangentspace
	//using flatimage, wich needs some tweak
    vec3 L = texture2D(u_DeluxeMap, var_TexLight).xyz;
	L.z *=1.0;
	L.x *=1.0;
	L.y *=0.5;
	L = normalize(L * 2.0 - 1.0); // this lightdirection is in tangent space

	
	// compute half angle in world space
	vec3 H = normalize(L + V);

	vec3 R = reflect(-L, N);

    // compute the light term
	//with half lambert
	float NL =dot(N, L);

	vec3 light = var_LightColor.rgb * NL;

	// compute the specular term
	//vec3 specular = texture2D(u_SpecularMap, var_TexCoords).rgb * var_LightColor.rgb * pow(clamp(dot(N, H), 0.0, 1.0), r_SpecularExponent) * r_SpecularScale;
	vec3 specular = texture2D(u_SpecularMap, var_TexCoords).rgb * var_LightColor.rgb * pow(max(dot(V, R), 0.0), r_SpecularExponent) * r_SpecularScale;
	
	// compute final color
	vec4 color = vec4(diffuse.rgb, var_LightColor.a);
	color.rgb *= light;
	color.rgb += specular;

	

#else // no normal mapping

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

	

	vec4 color = vec4(diffuse.rgb * var_LightColor.rgb, var_LightColor.a);
#endif // no normal mapping
	gl_FragColor = color;


}
