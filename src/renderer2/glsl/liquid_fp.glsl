/* liquid_fp.glsl */

uniform sampler2D u_CurrentMap;
uniform samplerCube u_PortalMap;
uniform sampler2D u_DepthMap;
uniform sampler2D u_NormalMap;
uniform vec3      u_ViewOrigin;
uniform float     u_FogDensity;
uniform vec3      u_FogColor;
uniform float     u_RefractionIndex;
uniform float     u_FresnelPower;
uniform float     u_FresnelScale;
uniform float     u_FresnelBias;
uniform float     u_NormalScale;
uniform mat4      u_ModelMatrix;
uniform mat4      u_UnprojectMatrix;
uniform vec3      u_LightDir;
uniform vec4      u_PortalPlane;
uniform float     u_DepthScale;

varying vec3 var_Position;
varying vec2 var_TexNormal;
varying vec3 var_Tangent;
varying vec3 var_Binormal;
varying vec3 var_Normal;
varying vec4 var_LightColor;



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

	// compute view direction in world space/incident ray
	vec3 V = normalize(u_ViewOrigin - var_Position);

	// invert tangent space for twosided surfaces
	mat3 tangentToWorldMatrix;
#if defined(TWOSIDED)
	if(!gl_FrontFacing)
	{
		tangentToWorldMatrix = mat3(-var_Tangent.xyz, -var_Binormal.xyz, -var_Normal.xyz);
	}
	else
#endif
	{
		tangentToWorldMatrix = mat3(var_Tangent.xyz, var_Binormal.xyz, var_Normal.xyz);
	}

	// calculate the screen texcoord in the 0.0 to 1.0 range
	vec2 texScreen = gl_FragCoord.st * r_FBufScale * r_NPOTScale;
	vec2 texNormal = var_TexNormal.st;



	// compute normals
	vec3 N = var_Normal.xyz;

    // compute light direction in world space
	vec3 L = normalize(u_LightDir);

	N = normalize(N);

	vec3 N2 = normalize(texture2D(u_NormalMap, texNormal).xyz *2.0 - 1.0); 
	

	vec3 N3 = normalize(N + V);

	// compute fresnel term
	float fresnel = max(u_FresnelBias + pow(1.0 - dot(N2, L), u_FresnelPower) * u_FresnelScale, 0.0);

	texScreen += u_NormalScale * N2.xy;

	vec3 refractColor = texture2D(u_CurrentMap, texScreen).rgb;
	vec3 refract2 = reflect(refractColor,L);

	// compute reflection ray
	vec3 R = reflect(L, N2);
	vec3 reflectColor = textureCube(u_PortalMap, R).rgb;
	vec3 reflect2 = reflect(reflectColor,L);
	vec4 color;

	color.rgb = mix(refract2, reflect2, fresnel);
	color.a   = 1.0;

	if (u_FogDensity > 0.0)
	{
		// reconstruct vertex position in world space
		float depth = texture2D(u_DepthMap, texScreen).r;
		vec4  P     = u_UnprojectMatrix * vec4(gl_FragCoord.xy, depth, 1.0);
		P.xyz /= P.w;

		// calculate fog distance
		float fogDistance = distance(P.xyz, var_Position);

		// calculate fog exponent
		float fogExponent = fogDistance * u_FogDensity;

		// calculate fog factor
		float fogFactor = exp2(-abs(fogExponent));

		color.rgb = mix(u_FogColor, color.rgb, fogFactor);
	}

	

	// compute half angle in world space
	vec3 H = normalize(L + V);

	// compute the light term
	vec3 light = var_LightColor.rgb * clamp(dot(N2, L), 0.0, 1.0);

	// compute the specular term
	vec3 specular = reflectColor * light * pow(clamp(dot(N2, H), 0.0, 1.0), r_SpecularExponent) * r_SpecularScale;
	color.rgb += specular;

	gl_FragColor = color;
}
