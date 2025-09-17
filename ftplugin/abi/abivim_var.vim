" -----------------------------------------------------------------------
"  File: abivim_var.vim
"  Description: Holds the variables for the whole plugin
"  Author: H.Lebrun <harmonie.lebrun@cea.fr>
"  Source: https://github.com/chaostellaire/abivim
"  Last Modified: 15 Sep 2025
" ----------------------------------------------------------------------


" Global Settings: {{{

" > Colors options

if !exists("g:abivim_color_custom")
    let g:abivim_color_custom = 0
endif

if !exists("g:abivim_supercomment")
    let g:abivim_supercomment = 1
endif



" > Variable-type-free colors

if !exists("g:abivim_color_repeatfg")
    let g:abivim_color_repeatfg = '#000000'
endif

if !exists("g:abivim_color_repeatbg")
    let g:abivim_color_repeatbg = "#b22222"
endif

if !exists("g:abivim_color_supercomment")
    let g:abivim_color_supercomment = "#006400"
endif

if !exists("g:abivim_link_repeat")
    let g:abivim_link_repeat = "Error"
endif
" }}}

" Colors Settings: {{{
" ! PUSH AT THE END OF FILE !
if g:abivim_color_custom
    if !exists("g:abivim_color_basic")
        let g:abivim_color_basic = "#94E2D5"
    endif
    if !exists("g:abivim_color_bse")
        let g:abivim_color_bse = "#94E2D5"
    endif
    if !exists("g:abivim_color_dev")
        let g:abivim_color_dev = "#94E2D5"
    endif
    if !exists("g:abivim_color_dfpt")
        let g:abivim_color_dfpt = "#94E2D5"
    endif
    if !exists("g:abivim_color_dmft")
        let g:abivim_color_dmft = "#94E2D5"
    endif
    if !exists("g:abivim_color_eph")
        let g:abivim_color_eph = "#94E2D5"
    endif
    if !exists("g:abivim_color_ffield")
        let g:abivim_color_ffield = "#94E2D5"
    endif
    if !exists("g:abivim_color_files")
        let g:abivim_color_files = "#94E2D5"
    endif
    if !exists("g:abivim_color_geo")
        let g:abivim_color_geo = "#94E2D5"
    endif
    if !exists("g:abivim_color_gstate")
        let g:abivim_color_gstate = "#94E2D5"
    endif
    if !exists("g:abivim_color_gw")
        let g:abivim_color_gw = "#94E2D5"
    endif
    if !exists("g:abivim_color_gwr")
        let g:abivim_color_gwr = "#94E2D5"
    endif
    if !exists("g:abivim_color_internal")
        let g:abivim_color_internal = "#94E2D5"
    endif
    if !exists("g:abivim_color_paral")
        let g:abivim_color_paral = "#94E2D5"
    endif
    if !exists("g:abivim_color_paw")
        let g:abivim_color_paw = "#94E2D5"
    endif
    if !exists("g:abivim_color_rlx")
        let g:abivim_color_rlx = "#94E2D5"
    endif
    if !exists("g:abivim_color_rttddft")
        let g:abivim_color_rttddft = "#94E2D5"
    endif
    if !exists("g:abivim_color_vdw")
        let g:abivim_color_vdw = "#94E2D5"
    endif
    if !exists("g:abivim_color_w90")
        let g:abivim_color_w90 = "#94E2D5"
    endif

else
" >>Linkers
    if !exists("g:abivim_link_basic")
    let g:abivim_link_basic = "Type"
    endif
    if !exists("g:abivim_link_bse")
    let g:abivim_link_bse = "Type"
    endif
    if !exists("g:abivim_link_dev")
    let g:abivim_link_dev = "Type"
    endif
    if !exists("g:abivim_link_dfpt")
    let g:abivim_link_dfpt = "Type"
    endif
    if !exists("g:abivim_link_dmft")
    let g:abivim_link_dmft = "Type"
    endif
    if !exists("g:abivim_link_eph")
    let g:abivim_link_eph = "Type"
    endif
    if !exists("g:abivim_link_ffield")
    let g:abivim_link_ffield = "Type"
    endif
    if !exists("g:abivim_link_files")
    let g:abivim_link_files = "Type"
    endif
    if !exists("g:abivim_link_geo")
    let g:abivim_link_geo = "Type"
    endif
    if !exists("g:abivim_link_gstate")
    let g:abivim_link_gstate = "Type"
    endif
    if !exists("g:abivim_link_gw")
    let g:abivim_link_gw = "Type"
    endif
    if !exists("g:abivim_link_gwr")
    let g:abivim_link_gwr = "Type"
    endif
    if !exists("g:abivim_link_internal")
    let g:abivim_link_internal = "Type"
    endif
    if !exists("g:abivim_link_paral")
    let g:abivim_link_paral = "Type"
    endif
    if !exists("g:abivim_link_paw")
    let g:abivim_link_paw = "Type"
    endif
    if !exists("g:abivim_link_rlx")
    let g:abivim_link_rlx = "Type"
    endif
    if !exists("g:abivim_link_rttddft")
    let g:abivim_link_rttddft = "Type"
    endif
    if !exists("g:abivim_link_vdw")
    let g:abivim_link_vdw = "Type"
    endif
    if !exists("g:abivim_link_w90")
    let g:abivim_link_w90 = "Type"
    endif
endif

" }}}
