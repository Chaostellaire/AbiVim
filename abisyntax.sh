#!/bin/bash
#syntax file maker for abivim

#COLLECT VARIABLES
#take where we have the dictionnary
INPUT_FILE=$1
OUTPUT_LOC=$2
verb=$3
vimdir=$4


#fetch every type of var :
#19 sets, 5 types....
grep 'varset=' "$INPUT_FILE" | sed -E "s/.*varset=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abiset.txt"

# color definition from catpuccin_mocha

sort "$OUTPUT_LOC/abiset.txt" | uniq > temp

mkdir -p "$vimdir/after/syntax"
if [ -f "$vimdir/after/syntax/abi.vim" ]; then rm -f "$vimdir/after/syntax/abi.vim";fi


echo "\" abinit input syntax file for vim" > "$vimdir/after/syntax/abi.vim"
echo " " >> "$vimdir/after/syntax/abi.vim"

#Configuration 

echo "if g:abivim_color_custom" >> "$vimdir/after/syntax/abi.vim"

# First define default groups
while IFS= read -r sets; do
    echo "    exec 'highlight $sets guifg= ' . g:abivim_color_${sets}" >> "$vimdir/after/syntax/abi.vim"
done < "temp"
echo "    exec 'highlight Repeat guifg= ' . g:abivim_color_repeatfg . ' guibg=' . g:abivim_color_repeatbg" >> "$vimdir/after/syntax/abi.vim"

echo "else" >> "$vimdir/after/syntax/abi.vim"
# if we have not selected custom, link to vim theme
while IFS= read -r newsets; do
    echo "    exec 'highlight! link $newsets ' . g:abivim_link_${newsets}" >> "$vimdir/after/syntax/abi.vim"
done < "temp"
echo "    exec 'highlight! link Repeat ' . g:abivim_link_repeat" >> "$vimdir/after/syntax/abi.vim"
echo "endif" >> "$vimdir/after/syntax/abi.vim"
#done with unique list
rm -f temp

echo "" >> "$vimdir/after/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/after/syntax/abi.vim"
echo "" >> "$vimdir/after/syntax/abi.vim"

while IFS= read -r var && IFS= read -r sets <&3; do
  echo "syntax match $sets \"\<$var[0-9:?+]*\\c\>\"" >> "$vimdir/after/syntax/abi.vim"
done < "$OUTPUT_LOC/abivar.txt" 3< "$OUTPUT_LOC/abiset.txt"

echo "" >> "$vimdir/after/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/after/syntax/abi.vim"
echo "" >> "$vimdir/after/syntax/abi.vim"

echo "syntax region String start=/\\v\\\"/ skip=/\\v\\\\./ end=/\\v\\\"/" >> "$vimdir/after/syntax/abi.vim"
echo "syntax match Float \"-\?[0-9]*\.\?[d0-9]\+\.\?\"" >> "$vimdir/after/syntax/abi.vim"
echo "syntax match Number \"-\?[0-9]\+\"" >> "$vimdir/after/syntax/abi.vim"

echo "" >> "$vimdir/after/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/after/syntax/abi.vim"
echo "" >> "$vimdir/after/syntax/abi.vim"

echo "\" https://docs.abinit.org/guide/abinit/#physical-information" >> "$vimdir/after/syntax/abi.vim"
echo "syntax keyword energy_unit Ha Hartree eV meV Rydbergs Rydberg Ry K Kelvin" >> "$vimdir/after/syntax/abi.vim"
echo "syntax keyword length_unit Bohr nm Ang Angstr Angstrom" >> "$vimdir/after/syntax/abi.vim"
echo "syntax keyword mag_unit T Tesla" >> "$vimdir/after/syntax/abi.vim"
echo "syntax keyword time_unit as asec asecond ps psec psecond" >> "$vimdir/after/syntax/abi.vim"
echo "highlight! link energy_unit Type" >> "$vimdir/after/syntax/abi.vim"
echo "highlight! link length_unit Type" >> "$vimdir/after/syntax/abi.vim"
echo "highlight! link time_unit Type" >> "$vimdir/after/syntax/abi.vim"
echo "highlight! link mag_unit Type" >> "$vimdir/after/syntax/abi.vim"

echo "" >> "$vimdir/after/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/after/syntax/abi.vim"
echo "" >> "$vimdir/after/syntax/abi.vim"

echo "syntax match Comment \"#.*\"" >> "$vimdir/after/syntax/abi.vim"
echo "if g:abivim_supercomment" >> "$vimdir/after/syntax/abi.vim"
echo "    exec 'highlight BrightComment guifg= ' . g:abivim_color_supercomment" >> "$vimdir/after/syntax/abi.vim"
echo "    syntax match BrightComment \"##.*\"" >> "$vimdir/after/syntax/abi.vim"
echo "endif" >> "$vimdir/after/syntax/abi.vim"
