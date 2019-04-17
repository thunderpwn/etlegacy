/* vertexLighting_DBS_world_fp.glsl */
#include "lib/reliefMapping"

uniform sampler2D u_DiffuseMap;
uniform sampler2D u_NormalMap;
uniform sampler2D u_SpecularMap;
uniform int       u_AlphaTest;
uniform vec3      u_ViewOrigin;
uniform float     u_DepthScale;
uniform vec4      u_PortalPlane;
uniform float     u_LightWrapAround;

varying vec3 var_Position;
varying vec4 var_TexDiffuseNormal;
varying vec2 var_TexSpecular;
varying vec4 var_LightColor;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
//varying vec3 var_LightDirection;

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
	//vec3 V = normalize(u_ViewOrigin - var_Position);

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
	vec3 V = normalize(tangentToWorldMatrix * (u_ViewOrigin - var_Position));

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

	vec3 N = normalize(tangentToWorldMatrix *(texture2D(u_NormalMap, texNormal).rgb *2.0 - 1.0));


#if defined(r_NormalScale)
	N.z *= r_NormalScale;
	normalize(N);
#endif
	// compute light direction in world space
	//NB! This doesnt have an matrix, so we wont do the *2.0 - 1.0 stuff here

	vec3 L = N;

	
	// compute half angle in world space
	vec3 H = normalize(L + V);

	vec3 R = reflect(-L, N);

     // compute the light term
	//with half lambert
	float NL = dot(N, L) * 0.5 + 0.5;
	NL = NL * NL;

	vec3 light = var_LightColor.rgb * NL;

	// compute the specular term
	//vec3 specular = texture2D(u_SpecularMap, texSpecular).rgb * var_LightColor.rgb * pow(clamp(dot(N, H), 0.0, 1.0), r_SpecularExponent) * r_SpecularScale;
	vec3 specular = texture2D(u_SpecularMap, texSpecular).rgb * var_LightColor.rgb * pow(max(dot(V, R), 0.0), r_SpecularExponent) * r_SpecularScale;
	
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

	

	vec4 color = vec4(diffuse.rgb * var_LightColor.rgb, var_LightColor.a);
#endif // no normal mapping
	gl_FragColor = color;


}
