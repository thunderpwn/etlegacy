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

varying vec3 var_Position;
varying vec4 var_TexDiffuseNormal;
varying vec2 var_TexSpecular;
varying vec2 var_TexLight;

varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;

varying vec4 var_Color;


void main()
{
#if defined(USE_PORTAL_CLIPPING)
	float dist = dot(var_Position.xyz, u_PortalPlane.xyz) - u_PortalPlane.w;
	if (dist < 0.0)
	{
		discard;
		return;
	}
#endif

	// compute view direction in world space
	vec3 V = normalize(u_ViewOrigin - var_Position);

	vec4 lightmapColor  = texture2D(u_LightMap, var_TexLight);
	vec4 deluxemapColor = texture2D(u_DeluxeMap, var_TexLight);

	

#if defined(USE_NORMAL_MAPPING)

	vec2 texDiffuse  = var_TexDiffuseNormal.st;
	vec2 texNormal   = var_TexDiffuseNormal.pq;
	vec2 texSpecular = var_TexSpecular.st;

	// invert tangent space for two sided surfaces
	mat3 tangentToWorldMatrix;
#if defined(TWOSIDED)
	if (!gl_FrontFacing)
	{
		
		tangentToWorldMatrix = mat3(-var_Tangent.x,-var_Tangent.y, -var_Tangent.z,
                                    -var_Binormal.x, -var_Binormal.y, -var_Binormal.z,
                                    -var_Normal.x, -var_Normal.y, -var_Normal.z);
	}
	else
#endif
	{
		tangentToWorldMatrix = mat3(var_Tangent.x, var_Tangent.y, var_Tangent.z,
                                    var_Binormal.x, var_Binormal.y, var_Binormal.z,
                                    var_Normal.x, var_Normal.y, var_Normal.z);
	}

	mat3 worldToTangentMatrix = transpose(tangentToWorldMatrix);
	

#if defined(USE_PARALLAX_MAPPING)
	// ray intersect in view direction

	mat3 worldToTangentMatrix = transpose(tangentToWorldMatrix);

	// compute view direction in tangent space
	vec3 Vts = normalize(worldToTangentMatrix * V);

	// size and start position of search in texture space
	vec2 S = Vts.xy * -u_DepthScale / Vts.z;

	float depth = RayIntersectDisplaceMap(texNormal, S, u_NormalMap);

	// compute texcoords offset
	vec2 texOffset = S * depth;

	texDiffuse.st  += texOffset;
	texNormal.st   += texOffset;
	texSpecular.st += texOffset;
#endif // USE_PARALLAX_MAPPING

	// compute the diffuse term
	vec4 diffuse = texture2D(u_DiffuseMap, texDiffuse);

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
   
	// compute normal in tangent space from normalmap and multiply with tangenttoworldmatrix so it gets to world
	// each colour component is between 0 and 1, and each vector component is between -1 and 1,
	//so this simple mapping goes from the texel to the normal

	vec3 N = normalize(tangentToWorldMatrix *(texture2D(u_NormalMap, texNormal).xyz *2.0 - 1.0));



	// compute light direction in world space
	//NB! should be handled more or less like normalmap
	//should this be - as in light from??
	vec3 L = normalize(tangentToWorldMatrix * (texture2D(u_DeluxeMap, var_TexLight).xyz*2.0 - 1.0));

	
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
	vec3 specular = texture2D(u_SpecularMap, texSpecular).rgb * lightColor * pow(max(dot(V, R), 0.0), r_SpecularExponent) * r_SpecularScale;

	// compute final color
	vec4 color = diffuse;
	color.rgb *= lightColor;
	color.rgb += specular;
	// for smooth terrain blending else there is no blending of lightmapped
	color.a   *= var_Color.a; 

#else // DO_NOT_NORMAL_MAPPING

	// compute the diffuse term
	vec4 diffuse = texture2D(u_DiffuseMap, var_TexDiffuseNormal.st);

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
