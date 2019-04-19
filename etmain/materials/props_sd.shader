// props_sd.shader

textures/props_sd/board_cl01m
{
    qer_editorimage textures/props_sd/board_cl01m.tga
	diffusemap textures/props_sd/board_cl01m.tga
	bumpmap textures/props_sd/board_cl01m_NORM.tga
	specularmap textures/props_sd/board_cl01m_SPEC.tga
	surfaceparm woodsteps
	implicitMap -
}

textures/props_sd/board_cl02m
{
    qer_editorimage textures/props_sd/board_cl02m.tga
	diffusemap textures/props_sd/board_cl02m.tga
	bumpmap textures/props_sd/board_cl02m_NORM.tga
	specularmap textures/props_sd/board_cl02m_SPEC.tga
	surfaceparm woodsteps
	implicitMap -
}

textures/props_sd/s_ammo01
{
    qer_editorimage textures/props_sd/s_ammo01.tga
	diffusemap textures/props_sd/s_ammo01.tga
	bumpmap textures/props_sd/s_ammo01_NORM.tga
	specularmap textures/props_sd/s_ammo01_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/s_casemate01
{
    qer_editorimage textures/props_sd/s_casemate01.tga
	diffusemap textures/props_sd/s_casemate01.tga
	bumpmap textures/props_sd/s_casemate01_NORM.tga
	specularmap textures/props_sd/s_casemate01_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/s_casemate02
{
    qer_editorimage textures/props_sd/s_casemate02.tga
	diffusemap textures/props_sd/s_casemate02.tga
	bumpmap textures/props_sd/s_casemate02_NORM.tga
	specularmap textures/props_sd/s_casemate02_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/s_generator01
{
    qer_editorimage textures/props_sd/s_generator01.tga
	diffusemap textures/props_sd/s_generator01.tga
	bumpmap textures/props_sd/s_generator01_NORM.tga
	specularmap textures/props_sd/s_generator01_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/s_gun01
{
    qer_editorimage textures/props_sd/s_gun01.tga
	diffusemap textures/props_sd/s_gun01.tga
	bumpmap textures/props_sd/s_gun01_NORM.tga
	specularmap textures/props_sd/s_gun01_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/barrel_m01_rednwhite
{
    qer_editorimage textures/props_sd/barrel_m01_rednwhite.tga
	diffusemap textures/props_sd/barrel_m01_rednwhite.tga
	bumpmap textures/props_sd/barrel_m01_rednwhite_NORM.tga
	specularmap textures/props_sd/barrel_m01_rednwhite_SPEC.tga
	surfaceparm metalsteps
	implicitMap -
}

// norm and spec doesnt seem to work here
textures/props_sd/wires
{
    qer_editorimage textures/props_sd/wires
	//diffusemap textures/props_sd/wires.tga
	//bumpmap textures/props_sd/wires_NORM.tga
	//specularmap textures/props_sd/wires_SPEC.tga
	cull disable
	nomipmaps
	nopicmip
	surfaceparm alphashadow
	surfaceparm metalsteps
	surfaceparm pointlight
	surfaceparm trans
	surfaceparm nonsolid
	{
		map textures/props_sd/wires.tga
		alphaFunc GE128
		depthWrite
		rgbGen vertex
	}
}

textures/props_sd/wires01
{
    qer_editorimage textures/props_sd/wires01.tga
	//diffusemap textures/props_sd/wires01.tga
	//bumpmap textures/props_sd/wires01_NORM.tga
	//specularmap textures/props_sd/wires01_SPEC.tga
	cull disable
	nomipmaps
	nopicmip
	surfaceparm alphashadow
	surfaceparm metalsteps
	surfaceparm pointlight
	surfaceparm trans
	surfaceparm nonsolid
	{
		map textures/props_sd/wires01.tga
		alphaFunc GE128
		depthWrite
		rgbGen vertex
	}
}

//New shaders!
textures/props_sd/sign_radar
{
    qer_editorimage textures/props_sd/sign_radar.tga
	diffusemap textures/props_sd/sign_radar.tga
	bumpmap textures/props_sd/sign_radar_NORM.tga
	specularmap textures/props_sd/sign_radar.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/props_sd/trim_c01w
{
    qer_editorimage textures/props_sd/trim_c01w.tga
	diffusemap textures/props_sd/trim_c01w.tga
	bumpmap textures/props_sd/trim_c01w_NORM.tga
	specularmap textures/props_sd/trim_c01w_SPEC.tga
    implicitMap -
}
	
textures/props_sd/trim_c03w
{
    qer_editorimage textures/props_sd/trim_c03w.tga
	diffusemap textures/props_sd/trim_c03w.tga
	bumpmap textures/props_sd/trim_c03w_NORM.tga
	specularmap textures/props_sd/trim_c03w_SPEC.tga
    implicitMap -
}

textures/props_sd/trim_c10w
{
    qer_editorimage textures/props_sd/trim_c10w.tga
	diffusemap textures/props_sd/trim_c10w.tga
	bumpmap textures/props_sd/trim_c10w_NORM.tga
	specularmap textures/props_sd/trim_c10w_SPEC.tga
    implicitMap -
}

textures/props_sd/basketsand
{
    qer_editorimage textures/props_sd/basketsand.tga
	diffusemap textures/props_sd/basketsand.tga
	bumpmap textures/props_sd/basketsand_NORM.tga
	specularmap textures/props_sd/basketsand_SPEC.tga
	surfaceparm gravelsteps
    implicitMap -
}