### update_abivim.sh: Bash script updater of the .vim files, will update the dictionnaries and syntax
                  #  Will also add new global variables for naming and coloring
# Chaostellaire
# version 2.0


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ ! "$#" -eq 1 ]; then echo -e "\033[32m Please provide the mkdocs location of abinit_variables.py \033[0m"; exit 1 ;fi
DOC="$1"


# Updating dictionnaries
grep 'abivarname=' "$DOC" | sed -E "s/.*abivarname=[\"']([^\"']+)[\"'].*/\1/" > "$SCRIPT_DIR/dict/abivar.txt"
grep 'mnemonics=' "$DOC" | sed -E "s/.*mnemonics=[\"']([^\"']+)[\"'].*/\1/" > "$SCRIPT_DIR/dict/abimnemo.txt"
grep 'varset=' "$DOC" | sed -E "s/.*varset=[\"']([^\"']+)[\"'].*/\1/" > "$SCRIPT_DIR/dict/abiset.txt"

# make temporary unique set files
sort "$SCRIPT_DIR/dict/abiset.txt" | uniq > temp

#### Destroy the color settings
#linenb=$(grep -Pn "Colors Settings: {{{" "$SCRIPT_DIR/syntax/abi.vim" | grep -Po -m 1 '^(\d+)')
#destroy previous colors settings
#sed -i "${linenb},\$d" "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
####

mkdir -p "syntax"
if [ -f "syntax/abi.vim" ]; then rm -f "syntax/abi.vim";fi
touch "syntax/abi.vim"

echo '" Global Settings: {{{' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_color_custom")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_color_custom = 0' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_supercomment")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_supercomment = 1' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '" > Variable-type-free colors' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_color_repeatfg")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_color_repeatfg = "#b5bfe2"' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_color_repeatbg")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_color_repeatbg = "#e78284"' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_color_supercomment")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_color_supercomment = "#a6d189"' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'if !exists("g:abivim_link_repeat")' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '    let g:abivim_link_repeat = "Error"' >> "$SCRIPT_DIR/syntax/abi.vim"
echo 'endif' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '" }}}' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '" > Colors options' >> "$SCRIPT_DIR/syntax/abi.vim"
echo '' >> "$SCRIPT_DIR/syntax/abi.vim"

# add new colors
echo "\" Colors Settings: {{{" >> "$SCRIPT_DIR/syntax/abi.vim"
echo "\" ! PUSH AT THE END OF FILE !" >> "$SCRIPT_DIR/syntax/abi.vim"

echo "" >> "$SCRIPT_DIR/syntax/abi.vim"

echo "\" >>Customs" >> "$SCRIPT_DIR/syntax/abi.vim"

echo "if g:abivim_color_custom" >> "$SCRIPT_DIR/syntax/abi.vim"
while IFS= read -r sets; do
    echo "    if !exists(\"g:abivim_color_${sets}\")" >> "$SCRIPT_DIR/syntax/abi.vim"
    echo "        let g:abivim_color_${sets} = \"#ef9f76\"" >> "$SCRIPT_DIR/syntax/abi.vim"
    echo "    endif" >> "$SCRIPT_DIR/syntax/abi.vim" 
done < "temp"

echo "" >> "$SCRIPT_DIR/syntax/abi.vim"
echo "else" >> "$SCRIPT_DIR/syntax/abi.vim"
echo "\" >>Linkers" >> "$SCRIPT_DIR/syntax/abi.vim"
while IFS= read -r sets; do
    echo "    if !exists(\"g:abivim_link_${sets}\")" >> "$SCRIPT_DIR/syntax/abi.vim"
    echo "    let g:abivim_link_${sets} = \"Keyword\"" >> "$SCRIPT_DIR/syntax/abi.vim"
    echo "    endif" >> "$SCRIPT_DIR/syntax/abi.vim"
done < "temp"
echo "endif" >> "$SCRIPT_DIR/syntax/abi.vim"

echo "" >> "$SCRIPT_DIR/syntax/abi.vim"
echo "\" }}}"  >> "$SCRIPT_DIR/syntax/abi.vim" 


### ============= OLD ABISYNTAX FILE ==================

# color definition from catpuccin_mocha



echo "\" abinit input syntax file for vim" >> "syntax/abi.vim"
echo " " >> "syntax/abi.vim"

#Configuration 

echo "syntax region String start=/\\v\\\"/ skip=/\\v\\\\./ end=/\\v\\\"/" >> "syntax/abi.vim"
echo "syntax match Float \"-\?[0-9]*\.\?[d0-9]\+\.\?\"" >> "syntax/abi.vim"
echo "syntax match Number \"-\?[0-9]\+\"" >> "syntax/abi.vim"

echo "" >> "syntax/abi.vim"
echo "\" ============================" >> "syntax/abi.vim"
echo "" >> "syntax/abi.vim"

echo "\" https://docs.abinit.org/guide/abinit/#physical-information" >> "syntax/abi.vim"
echo "syntax keyword energy_unit Ha Hartree eV meV Rydbergs Rydberg Ry K Kelvin" >> "syntax/abi.vim"
echo "syntax keyword length_unit Bohr nm Ang Angstr Angstrom angstrom" >> "syntax/abi.vim"
echo "syntax keyword mag_unit T Tesla" >> "syntax/abi.vim"
echo "syntax keyword time_unit as asec asecond ps psec psecond" >> "syntax/abi.vim"
echo "highlight! link energy_unit Type" >> "syntax/abi.vim"
echo "highlight! link length_unit Type" >> "syntax/abi.vim"
echo "highlight! link time_unit Type" >> "syntax/abi.vim"
echo "highlight! link mag_unit Type" >> "syntax/abi.vim"

echo "" >> "syntax/abi.vim"
echo "\" ============================" >> "syntax/abi.vim"
echo "" >> "syntax/abi.vim"

echo "if g:abivim_color_custom" >> "syntax/abi.vim"

# First define default groups
while IFS= read -r sets; do
    echo "    exec 'highlight $sets guifg= ' . g:abivim_color_${sets}" >> "syntax/abi.vim"
done < "temp"
echo "    exec 'highlight Repeat guifg= ' . g:abivim_color_repeatfg . ' guibg=' . g:abivim_color_repeatbg" >> "syntax/abi.vim"

echo "else" >> "syntax/abi.vim"
# if we have not selected custom, link to vim theme
while IFS= read -r newsets; do
    echo "    exec 'highlight! link $newsets ' . g:abivim_link_${newsets}" >> "syntax/abi.vim"
done < "temp"
echo "    exec 'highlight! link Repeat ' . g:abivim_link_repeat" >> "syntax/abi.vim"
echo "endif" >> "syntax/abi.vim"
#done with unique list
rm -f temp

echo "" >> "syntax/abi.vim"
echo "\" ============================" >> "syntax/abi.vim"
echo "" >> "syntax/abi.vim"

while IFS= read -r var && IFS= read -r sets <&3; do
  echo "syntax match $sets \"\<$var[0-9:?+]*\\c\>\"" >> "syntax/abi.vim"
done < "dict/abivar.txt" 3< "dict/abiset.txt"

echo "" >> "syntax/abi.vim"
echo "\" ============================" >> "syntax/abi.vim"
echo "" >> "syntax/abi.vim"


echo "syntax match Comment \"[#!].*\"" >> "syntax/abi.vim"
echo "if g:abivim_supercomment" >> "syntax/abi.vim"
echo "    exec 'highlight BrightComment guifg= ' . g:abivim_color_supercomment" >> "syntax/abi.vim"
echo "    syntax match BrightComment \"##.*\"" >> "syntax/abi.vim"
echo "endif" >> "syntax/abi.vim"

