//======================================================================
// Fueldump.shader
// Last edit: 04.03.2017 Thunder
//
//======================================================================
// q3map_sun <red> <green> <blue> <intensity> <degrees> <elevation>


textures/fueldump/fueldumpsky
{
	qer_editorimage textures/skies/fueldump_clouds.tga
	q3map_lightrgb 0.8 0.9 1.0
	q3map_skylight 85 3
	q3map_sun 1 .95 .9 200 210 28
	skyparms - 200 -
	surfaceparm nodlight
	surfaceparm noimpact
	surfaceparm nolightmap
	surfaceparm sky
	{
		map textures/skies/fueldump_clouds.tga
		rgbGen identity
	}
	{
		map textures/skies/fueldump_clouds.tga
		blendfunc blend
		rgbGen identity
		tcMod scroll 0.0005 0.00
		tcMod scale 2 1
	}
}



//======================================================================
// Base for metashaders
//======================================================================
textures/fueldump/terrain_base
{
	q3map_lightmapMergable
	q3map_lightmapaxis z
	q3map_lightmapsize 512 512
	q3map_normalimage textures/sd_bumpmaps/normalmap_terrain
	//q3map_tcGen ivector ( 512 0 0 ) ( 0 512 0 )
	q3map_tcMod rotate 37
	q3map_tcMod scale 1 1
	surfaceparm landmine
	surfaceparm snowsteps
}

//======================================================================
// Metashader for both sides of the map
// _0: Slighty dirty snow
// _1: Mud/dirt snow
// _2: Clean white snow
// _3: Snow crispy rock
//======================================================================
textures/fueldump/terrain1_0
{
	qer_editorimage textures/stone/mxsnow2.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
		stage diffusemap
		map textures/stone/mxsnow2.tga
		rgbGen identity
		alphaGen vertex
	}
	{
		stage bumpmap
		map textures/stone/mxsnow2_NORM.tga
		rgbGen identity
		alphaGen vertex
	}
   
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_1
{
    qer_editorimage textures/snow_sd/mxrock4b_snow.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
		stage diffusemap 
		map textures/snow_sd/mxrock4b_snow.tga
		rgbGen identity
		alphaGen vertex
	}
	{
		stage bumpmap
		map textures/snow_sd/mxrock4b_snow_NORM.tga
		rgbGen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_2
{
    qer_editorimage textures/stone/mxsnow3.tga
	q3map_baseshader textures/fueldump/terrain_base
    {
	   stage diffusemap
	   map textures/stone/mxsnow3.tga
	   rgbGen identity
	   alphaGen vertex
    }
	{
		stage bumpmap
		map textures/stone/mxsnow3_NORM.tga
		rgbGen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_3
{
    qer_editorimage textures/stone/mxrock3h_snow.tga
	q3map_baseshader textures/fueldump/terrain_base
	
	{
		stage diffusemap
		map textures/stone/mxrock3h_snow.tga
		rgbGen identity
		alphaGen vertex
	}
	{
		stage bumpmap
		map textures/stone/mxrock3h_snow_NORM.tga
		rgbGen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_0to1
{
	qer_editorimage textures/stone/mxsnow2.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/stone/mxsnow2.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	   stage bumpmap
	   map textures/stone/mxsnow2_NORM.tga
	   rgbgen identity
	   alphaGen vertex
	}
	
	{
		stage diffusemap
		map textures/snow_sd/mxrock4b_snow.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/snow_sd/mxrock4b_snow_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_0to2
{
    qer_editorimage textures/stone/mxsnow2.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/stone/mxsnow2.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxsnow2_NORM.tga
		rgbgen identity
		alphaGen vertex
	}
	
	{
		stage diffusemap
		map textures/stone/mxsnow3.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxsnow3_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_0to3
{
	qer_editorimage textures/stone/mxsnow2.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/stone/mxsnow2.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxsnow2_NORM.tga
		rgbgen identity
		alphaGen vertex
	}
	
	{
	    stage diffusemap
		map textures/stone/mxrock3h_snow.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxrock3h_snow_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_1to2
{
    qer_editorimage textures/snow_sd/mxrock4b_snow.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/snow_sd/mxrock4b_snow.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/snow_sd/mxrock4b_snow_NORM.tga
		rgbgen identity
		alphaGen vertex
    }
	
	{
	    stage diffusemap
		map textures/stone/mxsnow3.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxsnow3_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_1to3
{
	qer_editorimage textures/snow_sd/mxrock4b_snow.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/snow_sd/mxrock4b_snow.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/snow_sd/mxrock4b_snow_NORM.tga
		rgbgen identity
		alphaGen vertex
	}
	
	{
	    stage diffusemap
		map textures/stone/mxrock3h_snow.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxrock3h_snow_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

textures/fueldump/terrain1_2to3
{
	qer_editorimage textures/stone/mxsnow3.tga
	q3map_baseshader textures/fueldump/terrain_base
	{
	    stage diffusemap
		map textures/stone/mxsnow3.tga
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxsnow3_NORM.tga
		rgbgen identity
		alphaGen vertex
	}
	
	{
	    stage diffusemap
		map textures/stone/mxrock3h_snow.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	{
	    stage bumpmap
		map textures/stone/mxrock3h_snow_NORM.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen identity
		alphaGen vertex
	}
	
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
}

//===========================================================================
// Floor and wall textures for the cave system + hong phong goodness
//===========================================================================
textures/fueldump/cave_dark
{
	q3map_nonplanar
	q3map_shadeangle 60
	qer_editorimage textures/stone/mxrock3_a.tga
	
	{
		map $lightmap
		rgbGen identity
	}
	{
		stage diffusemap
		map textures/stone/mxrock3_a.tga
		rgbGen identity
	}
	{
		stage bumpmap
        map textures/stone/mxrock3_a_NORM.tga
		rgbGen identity
	}
	
}

textures/fueldump/cave_floor
{
	surfaceparm gravelsteps
	q3map_nonplanar
	q3map_shadeangle 60
	qer_editorimage textures/stone/mxrock1aa.tga
	{
		map $lightmap
		rgbGen identity
	}
	{
		stage diffusemap
		map textures/stone/mxrock1aa.tga
		rgbGen identity
	}
	{
		stage bumpmap
		map textures/stone/mxrock1aa_NORM.tga
		rgbGen identity
	}
	
}

textures/fueldump/snow_floor
{
	surfaceparm gravelsteps
	q3map_nonplanar
	q3map_shadeangle 179
	qer_editorimage textures/snow/s_dirt_m03i_2_phong.tga
	{
		map $lightmap
		rgbGen identity
	}
	{
		stage diffusemap
		map textures/snow/s_dirt_m03i_2.tga
		rgbgen identity
	}
	{
		stage bumpmap
		map textures/snow/s_dirt_m03i_2_NORM.tga
		rgbgen identity
	}
	
}

textures/terrain/dirt_m03i
{
	{
       stage diffusemap 
	   map textures/terrain/dirt_m03i.tga
	   rgbgen identity
	}
	{
		stage bumpmap
		map textures/terrain/dirt_m03i_NORM.tga
	    rgbgen identity
	}
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}

}

//==========================================================================
// Terrain/tunnel blend textures
//==========================================================================
textures/snow_sd/snow_road01
{
	q3map_nonplanar
	q3map_shadeangle 179
	surfaceparm snowsteps
	{
		stage diffusemap
		map textures/snow_sd/snow_road01.tga
		rgbgen identity
	}
	{
		stage bumpmap
		map textures/snow_sd/snow_road01_NORM.tga
		rgbgen identity
	}
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
	
}

textures/snow_sd/snow_path01
{
	q3map_nonplanar
	q3map_shadeangle 179
	surfaceparm snowsteps
	{
		stage diffusemap
		map textures/snow_sd/snow_path01.tga
		rgbgen identity
	}
	{
		stage bumpmap
		map textures/snow_sd/snow_path01_NORM.tga
		rgbgen identity
	}
	{
		lightmap $lightmap
		blendFunc GL_DST_COLOR GL_ZERO
		rgbgen identity
	}
	
}

//==========================================================================
// Misc stuff for the central building in the axis base
//==========================================================================
// Comms tower
textures/fueldump/atruss_m06a
{
	qer_alphafunc gequal 0.5
	qer_editorimage textures/assault/atruss_m06a.tga
	diffusemap textures/assault/atruss_m06a.tga
	bumpmap textures/assault/atruss_m06a_NORM.tga
	cull disable
	nomipmaps
	nopicmip
	surfaceparm alphashadow
	surfaceparm roofsteps
	surfaceparm trans
	implicitMask textures/assault/atruss_m06a.tga
}

textures/awf/awf_w_m11
{
	qer_editorimage textures/awf/awf_w_m11.tga
	diffusemap textures/awf/awf_w_m11.tga
	bumpmap textures/awf/awf_w_m11_NORM.tga
	q3map_lightimage textures/awf/awf_w_m11_g.tga
	q3map_surfacelight 200
	surfaceparm nomarks
	implicitMask textures/awf/awf_w_m11.tga
}

textures/awf/awf_w_m11_nlm
{
	qer_editorimage textures/awf/awf_w_m11_nlm.tga
	diffusemap textures/awf/awf_w_m11_nlm.tga
	bumpmap textures/awf/awf_w_m11_nlm_NORM.tga
	surfaceparm nomarks
	implicitMask textures/awf/awf_w_m11.tga
}

// This is more or less similiar to clipmissile
textures/alpha/fence_c11fd
{
	qer_trans 0.85
	qer_editorimage textures/alpha/fence_c11.tga
	diffusemap textures/alpha/fence_c11.tga
	bumpmap textures/alpha/fence_c11_NORM.tga
	cull disable
	nomipmaps
	nopicmip

	surfaceparm clipmissile
	surfaceparm nomarks
	surfaceparm alphashadow
	surfaceparm playerclip
	surfaceparm metalsteps
	surfaceparm pointlight
	surfaceparm trans

	implicitMask textures/alpha/fence_c11.tga
}

//==========================================================================
// Various terrain decals textures
//==========================================================================

// ydnar: nuked unnecessary alphaGen vertex part & added surfaceparm trans & pointlight
textures/fueldump/cave_floorblend
{
	qer_editorimage textures/snow/s_dirt_m03i_alphadir.tga
	q3map_nonplanar
	q3map_shadeangle 60
	surfaceparm trans
	surfaceparm nomarks
	surfaceparm gravelsteps
	surfaceparm pointlight
	polygonOffset

	{
		map textures/snow/s_dirt_m03i_alpha.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbGen vertex
	}
}

textures/fueldump/alphatree
{
	qer_editorimage textures/snow/s_dirt_m03i_alphatree.tga
	q3map_nonplanar 
	q3map_shadeangle 120 
	surfaceparm trans 
	surfaceparm nonsolid 
	surfaceparm pointlight
	surfaceparm nomarks
	polygonOffset
	{
		map textures/snow/s_dirt_m03i_alphatree.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbGen vertex
	}
}

//==========================================================================
// Various metal surfaceparm textures
//==========================================================================
textures/fueldump/door_m01asml
{
	qer_editorimage textures/fueldump_sd/door_m01asml.tga
	surfaceparm metalsteps
	{
		map $lightmap
		rgbGen identity
	}
	{
		stage diffusemap
		map textures/fueldump_sd/door_m01asml.tga
		rgbGen identity
	}
	{
		stage bumpmap
		map textures/fueldump_sd/door_m01asml_NORM.tga
		rgbGen identity
	}
}

textures/fueldump/door_m01asml_axis
{
	qer_editorimage textures/fueldump_sd/door_m01asml_axis.tga
	surfaceparm metalsteps
	{
		map $lightmap
		rgbGen identity
	}
	{
		stage diffusemap
		map textures/fueldump_sd/door_m01asml_axis.tga
		rgbGen identity
	}
	{
		stage bumpmap
		map textures/fueldump_sd/door_m01asml_axis_NORM.tga
		rgbGen identity
	}
}

//==========================================================================
// Ice Lake
//==========================================================================
textures/fueldump/icelake_top
{
	qer_trans 0.80
	qer_editorimage textures/snow_sd/icelake3.tga
	diffusemap textures/snow_sd/icelake3.tga
	bumpmap textures/snow_sd/icelake3_NORM.tga
	sort seethrough
	surfaceparm slick
	surfaceparm trans
	surfaceparm glass
	
	tesssize 256

	{
		map textures/effects/envmap_ice2
		tcgen environment
		blendfunc blend
	}
	{  
		map textures/snow_sd/icelake3.tga
		blendfunc blend
	}
	{
		map $lightmap
		blendfunc filter
		rgbGen identity
		depthWrite
	}
	
}

textures/fueldump/icelake_bottom
{
	qer_trans 0.80
	qer_editorimage textures/snow_sd/icelake3.tga
	diffusemap textures/snow_sd/icelake3.tga
	bumpmap textures/snow_sd/icelake3_NORM.tga
	sort seethrough
	surfaceparm trans
	cull disable
	
	{
		map textures/snow_sd/icelake3.tga
		blendfunc filter
	}
}

textures/fueldump/riverbed
{
	qer_editorimage textures/stone/mxdebri0_riverbed.tga
	{
		stage diffusemap
		map textures/stone/mxdebri0_riverbed.tga
		rgbGen vertex
	}	
	{
		stage bumpmap
		map textures/stone/mxdebri0_riverbed_NORM.tga
		rgbGen vertex
	}	
	
}