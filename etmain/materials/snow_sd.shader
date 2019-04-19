// snow_sd.shader

textures/snow_sd/alphatree_snow
{
    qer_editorimage textures/snow_sd/alphatree_snow.tga
	diffusemap textures/snow_sd/alphatree_snow.tga
	specularmap textures/snow_sd/alphatree_snow_SPEC.tga
	bumpmap textures/snow_sd/alphatree_snow_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/alphatree_snow2
{
    qer_editorimage textures/snow_sd/alphatree_snow2.tga
	diffusemap textures/snow_sd/alphatree_snow2.tga
	specularmap textures/snow_sd/alphatree_snow2_SPEC.tga
	bumpmap textures/snow_sd/alphatree_snow2_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/alphatree_snow3
{
    qer_editorimage textures/snow_sd/alphatree_snow3.tga
	diffusemap textures/snow_sd/alphatree_snow3.tga
	specularmap textures/snow_sd/alphatree_snow3_SPEC.tga
	bumpmap textures/snow_sd/alphatree_snow3_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/alphatree_snow4
{
    qer_editorimage textures/snow_sd/alphatree_snow4.tga
	diffusemap textures/snow_sd/alphatree_snow4.tga
	specularmap textures/snow_sd/alphatree_snow4_SPEC.tga
	bumpmap textures/snow_sd/alphatree_snow4_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/alphatreeline_snow
{
    qer_editorimage textures/snow_sd/alphatreeline_snow.tga
	diffusemap textures/snow_sd/alphatreeline_snow.tga
	specularmap textures/snow_sd/alphatreeline_snow_SPEC.tga
	bumpmap textures/snow_sd/alphatreeline_snow_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/ametal_m03_snow
{
    qer_editorimage textures/snow_sd/ametal_m03_snow.tga
	diffusemap textures/snow_sd/ametal_m03_snow.tga
	specularmap textures/snow_sd/ametal_m03_snow_SPEC.tga
	bumpmap textures/snow_sd/ametal_m03_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/ametal_m04a_snow
{
    qer_editorimage textures/snow_sd/ametal_m04a_snow.tga
	diffusemap textures/snow_sd/ametal_m04a_snow.tga
	specularmap textures/snow_sd/ametal_m04a_snow_SPEC.tga
	bumpmap textures/snow_sd/ametal_m04a_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/ametal_m04a_snowfade
{
    qer_editorimage textures/snow_sd/ametal_m04a_snowfade.tga
	diffusemap textures/snow_sd/ametal_m04a_snowfade.tga
	specularmap textures/snow_sd/ametal_m04a_snowfade_SPEC.tga
	bumpmap textures/snow_sd/ametal_m04a_snowfade_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/bunkertrim_snow
{
    diffusemap textures/snow_sd/bunkertrim_snow.tga
	bumpmap textures/snow_sd/bunkertrim_snow_NORM.tga
	specularmap textures/snow_sd/bunkertrim_snow_SPEC.tga
	qer_editorimage textures/snow_sd/bunkertrim_snow.tga
	q3map_nonplanar
	q3map_shadeangle 160
	implicitMap -
}

//==========================================================================
// Corner/edges of axis fueldump bunker buildings, needs phong goodness.
//==========================================================================
textures/snow_sd/bunkertrim3_snow
{
	q3map_nonplanar
	q3map_shadeangle 179
	qer_editorimage textures/snow_sd/bunkertrim3_snow.tga
	diffusemap textures/snow_sd/bunkertrim3_snow.tga
	specularmap textures/snow_sd/bunkertrim3_snow_SPEC.tga
	bumpmap textures/snow_sd/bunkertrim3_snow_NORM.tga
	{
		map $lightmap
		rgbGen identity
	}
	{
		map textures/snow_sd/bunkertrim3_snow.tga
		blendFunc filter
	}
}

textures/snow_sd/bunkerwall_lrg02
{
	qer_editorimage textures/snow_sd/bunkerwall_lrg02.tga
	diffusemap textures/snow_sd/bunkerwall_lrg02.tga
	specularmap textures/snow_sd/bunkerwall_lrg02_SPEC.tga
	bumpmap textures/snow_sd/bunkerwall_lrg02_NORM.tga
	q3map_nonplanar
	q3map_shadeangle 80
	implicitMap -
}

textures/snow_sd/icey_lake
{
    diffusemap textures/snow_sd/icelake.tga
	specularmap textures/snow_sd/icelake_SPEC.tga
	bumpmap textures/snow_sd/icelake_NORM.tga
	qer_trans 0.80
	qer_editorimage textures/snow_sd/icelake.tga
	surfaceparm slick
	{
		map textures/effects/envmap_ice.tga
		tcgen environment
	}
	{
		map textures/snow_sd/icelake.tga
		blendfunc blend
		tcmod scale 0.35 0.35
	}
	{
		map $lightmap
		blendfunc filter
		rgbGen identity
	}
}

// Used in fueldump on the icy river.
// Note: Apply this at a scale of 2.0x2.0 so it aligns correctly
// ydnar: added depthwrite and sort key so it dlights correctly
textures/snow_sd/icelake2
{
	qer_trans 0.80
	qer_editorimage textures/snow_sd/icelake2.tga
	sort seethrough
	surfaceparm slick
	surfaceparm trans
	tesssize 256
	diffusemap textures/snow_sd/icelake2.tga
	bumpmap textures/snow_sd/icelake2_NORM.tga
	specularmap textures/snow_sd/icelake2_SPEC.tga

	{
		map textures/effects/envmap_ice2.tga
		tcgen environment
		blendfunc blend
	}
	{
		map textures/snow_sd/icelake2.tga
		blendfunc blend
	}
	{
		map $lightmap
		blendfunc filter
		rgbGen identity
		depthWrite
	}
	
}

// Note: Apply this at a scale of 2.0x2.0 so it aligns correctly
textures/snow_sd/icelake2_opaque
{
	qer_editorimage textures/snow_sd/icelake2.tga
	diffusemap textures/snow_sd/icelake2.tga
	bumpmap textures/snow_sd/icelake2_NORM.tga
	specularmap textures/snow_sd/icelake2_SPEC.tga
	surfaceparm slick
	tesssize 256

	{
		map textures/effects/envmap_ice2.tga
		tcgen environment
		rgbGen identity
	}
	{
		map textures/snow_sd/icelake2.tga
		blendfunc blend
	}
	{
		map $lightmap
		blendfunc filter
		rgbGen identity
	}
	
}

textures/snow_sd/mesh_c03_snow
{
    qer_editorimage textures/snow_sd/mesh_c03_snow.tga
	diffusemap textures/snow_sd/mesh_c03_snow.tga
	specularmap textures/snow_sd/mesh_c03_snow_SPEC.tga
	bumpmap textures/snow_sd/mesh_c03_snow_NORM.tga
	qer_alphafunc gequal 0.5
	cull none
	nomipmaps
	nopicmip
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/metal_m04g2_snow
{
    qer_editorimage textures/snow_sd/metal_m04g2_snow.tga
	diffusemap textures/snow_sd/metal_m04g2_snow.tga
	specularmap textures/snow_sd/metal_m04g2_snow_SPEC.tga
	bumpmap textures/snow_sd/metal_m04g2_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/mroof_snow
{
    qer_editorimage textures/snow_sd/mroof_snow.tga
	diffusemap textures/snow_sd/mroof_snow.tga
	bumpmap textures/snow_sd/mroof_snow_NORM.tga
	specularmap textures/snow_sd/mroof_snow_SPEC.tga
	surfaceparm roofsteps
	implicitMap -
}

textures/snow_sd/sub1_snow
{
    qer_Editorimage textures/snow_sd/sub1_snow.tga
	diffusemap textures/snow_sd/sub1_snow.tga
	specularmap textures/snow_sd/sub1_snow_SPEC.tga
	bumpmap textures/snow_sd/sub1_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/sub1_snow2
{
    qer_editorimage textures/snow_sd/sub1_snow2.tga
	diffusemap textures/snow_sd/sub1_snow2.tga
	specularmap textures/snow_sd/sub1_snow2_SPEC.tga
	bumpmap textures/snow_sd/sub1_snow2_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/wirefence01_snow
{
    qer_editorimage textures/snow_sd/wirefence01_snow.tga
	diffusemap textures/snow_sd/wirefence01_snow.tga
	specularmap textures/snow_sd/wirefence01_snow_SPEC.tga
	bumpmap textures/snow_sd/wirefence01_snow_NORM.tga
	cull none
	surfaceparm alphashadow
	surfaceparm nomarks
	surfaceparm nonsolid
	surfaceparm trans
	implicitMask -
}

textures/snow_sd/wood_m05a_snow
{
    qer_editorimage textures/snow_sd/wood_m05a_snow.tga
	diffusemap textures/snow_sd/wood_m05a_snow.tga
	specularmap textures/snow_sd/wood_m05a_snow_SPEC.tga
	bumpmap textures/snow_sd/wood_m05a_snow_NORM.tga
	surfaceparm woodsteps
	implicitMap -
}

textures/snow_sd/wood_m06b_snow
{
    qer_editorimage textures/snow_sd/wood_m06b_snow.tga
	diffusemap textures/snow_sd/wood_m06b_snow.tga
	specularmap textures/snow_sd/wood_m06b_snow_SPEC.tga
	bumpmap textures/snow_sd/wood_m06b_snow_NORM.tga
	surfaceparm woodsteps
	implicitMap -
}

textures/snow_sd/fuse_box_snow
{
    qer_editorimage textures/snow_sd/fuse_box_snow.tga
	diffusemap textures/snow_sd/fuse_box_snow.tga
	specularmap textures/snow_sd/fuse_box_snow_SPEC.tga
	bumpmap textures/snow_sd/fuse_box_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/xmetal_m02_snow
{
    qer_editorimage textures/snow_sd/xmetal_m02_snow.tga
	diffusemap textures/snow_sd/xmetal_m02_snow.tga
	specularmap textures/snow_sd/xmetal_m02_snow_SPEC.tga
	bumpmap textures/snow_sd/xmetal_m02_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

textures/snow_sd/xmetal_m02t_snow
{
    qer_editorimage textures/snow_sd/xmetal_m02t_snow.tga
	diffusemap textures/snow_sd/xmetal_m02t_snow.tga
	specularmap textures/snow_sd/xmetal_m02t_snow_SPEC.tga
	bumpmap textures/snow_sd/xmetal_m02t_snow_NORM.tga
	surfaceparm metalsteps
	implicitMap -
}

//==========================================================================
// Various terrain decals textures
//==========================================================================

// ydnar: added "sort banner" and changed blendFunc so they fog correctly
// note: the textures were inverted and Brightness/Contrast applied so they
// will work properly with the new blendFunc (this is REQUIRED!)

textures/snow_sd/snow_track03 
{ 
	qer_editorimage textures/snow_sd/snow_track03.tga
	//diffusemap textures/snow_sd/snow_track03.tga
	//specularmap textures/snow_sd/snow_track03_SPEC.tga
	//bumpmap textures/snow_sd/snow_track03_NORM.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	
	sort decal
	
	{
		map textures/snow_sd/snow_track03.tga
       	blendFunc GL_ZERO GL_ONE_MINUS_SRC_COLOR
		rgbGen identity
	}
}

textures/snow_sd/snow_track03_faint
{ 
	qer_editorimage textures/snow_sd/snow_track03.tga
	//diffusemap textures/snow_sd/snow_track03.tga
	//specularmap textures/snow_sd/snow_track03_SPEC.tga
	//bumpmap textures/snow_sd/snow_track03_NORM.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	
	sort decal
	
	{
		map textures/snow_sd/snow_track03.tga
       		blendFunc GL_ZERO GL_ONE_MINUS_SRC_COLOR
		rgbGen const ( 0.5 0.5 0.5 )
	}
}

textures/snow_sd/snow_track03_end 
{ 
	qer_editorimage textures/snow_sd/snow_track03_end.tga
	//diffusemap textures/snow_sd/snow_track03_end.tga
	//specularmap textures/snow_sd/snow_track03_end_SPEC.tga
	//bumpmap textures/snow_sd/snow_track03_end_NORM.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	
	sort decal
	
	{
		map textures/snow_sd/snow_track03_end.tga
        blendFunc GL_ZERO GL_ONE_MINUS_SRC_COLOR
		rgbGen identity
	}
}

textures/snow_sd/snow_track03_end_faint 
{ 
	qer_editorimage textures/snow_sd/snow_track03_end.tga
	//diffusemap textures/snow_sd/snow_track03_end.tga
	//specularmap textures/snow_sd/snow_track03_end_SPEC.tga
	//bumpmap textures/snow_sd/snow_track03_end_NORM.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	
	sort decal
	
	{
		map textures/snow_sd/snow_track03_end.tga
        blendFunc GL_ZERO GL_ONE_MINUS_SRC_COLOR
		rgbGen const ( 0.5 0.5 0.5 )
	}
}

textures/snow_sd/river_edge_snowy 
{ 
	qer_editorimage textures/snow_sd/river_edge_snowy.tga
	//diffusemap textures/snow_sd/river_edge_snowy.tga
	//specularmap textures/snow_sd/river_edge_snowy_SPEC.tga
	//bumpmap textures/snow_sd/river_edge_snowy_NORM.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	{
		map textures/snow_sd/river_edge_snowy.tga
        blendFunc GL_ZERO GL_ONE_MINUS_SRC_COLOR
		rgbGen identity
	}
}
