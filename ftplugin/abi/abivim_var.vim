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
    let g:abivim_color_repeatfg = '#b5bfe2'
endif

if !exists("g:abivim_color_repeatbg")
    let g:abivim_color_repeatbg = "#e78284"
endif

if !exists("g:abivim_color_supercomment")
    let g:abivim_color_supercomment = "#a6d189"
endif

if !exists("g:abivim_link_repeat")
    let g:abivim_link_repeat = "Error"
endif
" }}}

" Colors Settings: {{{
" ! PUSH AT THE END OF FILE !

" >>Customs
if g:abivim_color_custom
    if !exists("g:abivim_color_basic")
        let g:abivim_color_basic = "#ef9f76"
    endif
    if !exists("g:abivim_color_bse")
        let g:abivim_color_bse = "#ef9f76"
    endif
    if !exists("g:abivim_color_dev")
        let g:abivim_color_dev = "#ef9f76"
    endif
    if !exists("g:abivim_color_dfpt")
        let g:abivim_color_dfpt = "#ef9f76"
    endif
    if !exists("g:abivim_color_dmft")
        let g:abivim_color_dmft = "#ef9f76"
    endif
    if !exists("g:abivim_color_eph")
        let g:abivim_color_eph = "#ef9f76"
    endif
    if !exists("g:abivim_color_ffield")
        let g:abivim_color_ffield = "#ef9f76"
    endif
    if !exists("g:abivim_color_files")
        let g:abivim_color_files = "#ef9f76"
    endif
    if !exists("g:abivim_color_geo")
        let g:abivim_color_geo = "#ef9f76"
    endif
    if !exists("g:abivim_color_gstate")
        let g:abivim_color_gstate = "#ef9f76"
    endif
    if !exists("g:abivim_color_gw")
        let g:abivim_color_gw = "#ef9f76"
    endif
    if !exists("g:abivim_color_gwr")
        let g:abivim_color_gwr = "#ef9f76"
    endif
    if !exists("g:abivim_color_internal")
        let g:abivim_color_internal = "#ef9f76"
    endif
    if !exists("g:abivim_color_paral")
        let g:abivim_color_paral = "#ef9f76"
    endif
    if !exists("g:abivim_color_paw")
        let g:abivim_color_paw = "#ef9f76"
    endif
    if !exists("g:abivim_color_rlx")
        let g:abivim_color_rlx = "#ef9f76"
    endif
    if !exists("g:abivim_color_rttddft")
        let g:abivim_color_rttddft = "#ef9f76"
    endif
    if !exists("g:abivim_color_vdw")
        let g:abivim_color_vdw = "#ef9f76"
    endif
    if !exists("g:abivim_color_w90")
        let g:abivim_color_w90 = "#ef9f76"
    endif

else
" >>Linkers
    if !exists("g:abivim_link_basic")
    let g:abivim_link_basic = "Keyword"
    endif
    if !exists("g:abivim_link_bse")
    let g:abivim_link_bse = "Keyword"
    endif
    if !exists("g:abivim_link_dev")
    let g:abivim_link_dev = "Keyword"
    endif
    if !exists("g:abivim_link_dfpt")
    let g:abivim_link_dfpt = "Keyword"
    endif
    if !exists("g:abivim_link_dmft")
    let g:abivim_link_dmft = "Keyword"
    endif
    if !exists("g:abivim_link_eph")
    let g:abivim_link_eph = "Keyword"
    endif
    if !exists("g:abivim_link_ffield")
    let g:abivim_link_ffield = "Keyword"
    endif
    if !exists("g:abivim_link_files")
    let g:abivim_link_files = "Keyword"
    endif
    if !exists("g:abivim_link_geo")
    let g:abivim_link_geo = "Keyword"
    endif
    if !exists("g:abivim_link_gstate")
    let g:abivim_link_gstate = "Keyword"
    endif
    if !exists("g:abivim_link_gw")
    let g:abivim_link_gw = "Keyword"
    endif
    if !exists("g:abivim_link_gwr")
    let g:abivim_link_gwr = "Keyword"
    endif
    if !exists("g:abivim_link_internal")
    let g:abivim_link_internal = "Keyword"
    endif
    if !exists("g:abivim_link_paral")
    let g:abivim_link_paral = "Keyword"
    endif
    if !exists("g:abivim_link_paw")
    let g:abivim_link_paw = "Keyword"
    endif
    if !exists("g:abivim_link_rlx")
    let g:abivim_link_rlx = "Keyword"
    endif
    if !exists("g:abivim_link_rttddft")
    let g:abivim_link_rttddft = "Keyword"
    endif
    if !exists("g:abivim_link_vdw")
    let g:abivim_link_vdw = "Keyword"
    endif
    if !exists("g:abivim_link_w90")
    let g:abivim_link_w90 = "Keyword"
    endif
endif

" }}}
