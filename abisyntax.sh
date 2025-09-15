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

mkdir -p "$vimdir/syntax"
if [ -f "$vimdir/syntax/abi.vim" ]; then rm -f "$vimdir/syntax/abi.vim";fi


echo "\" abinit input syntax file for vim" > "$vimdir/syntax/abi.vim"
echo " " >> "$vimdir/syntax/abi.vim"

#Configuration 

echo "if g:abivim_color_custom" >> "$vimdir/syntax/abi.vim"

# First define default groups
while IFS= read -r sets; do
    echo "    exec 'highlight $sets guifg= ' . g:abivim_color_${sets}" >> "$vimdir/syntax/abi.vim"
done < "temp"
echo "    exec 'highlight Repeat guifg= ' . g:abivim_color_repeatfg . ' guibg=' . g:abivim_color_repeatbg" >> "$vimdir/syntax/abi.vim"

echo "else" >> "$vimdir/syntax/abi.vim"
# if we have not selected custom, link to vim theme
while IFS= read -r newsets; do
    echo "    exec 'highlight! link $newsets ' . g:abivim_link_${newsets}" >> "$vimdir/syntax/abi.vim"
done < "temp"
echo "    exec 'highlight! link Repeat ' . g:abivim_link_repeat" >> "$vimdir/syntax/abi.vim"
echo "endif" >> "$vimdir/syntax/abi.vim"
#done with unique list
rm -f temp

echo "" >> "$vimdir/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/syntax/abi.vim"
echo "" >> "$vimdir/syntax/abi.vim"

while IFS= read -r var && IFS= read -r sets <&3; do
  echo "syntax match $sets \"\<$var[0-9:?+]*\\c\>\"" >> "$vimdir/syntax/abi.vim"
done < "$OUTPUT_LOC/abivar.txt" 3< "$OUTPUT_LOC/abiset.txt"

# add comment detection :
echo "" >> "$vimdir/syntax/abi.vim"
echo "\" ============================" >> "$vimdir/syntax/abi.vim"
echo "" >> "$vimdir/syntax/abi.vim"

echo "syntax match Comment \"#.*\"" >> "$vimdir/syntax/abi.vim"
echo "if g:abivim_supercomment" >> "$vimdir/syntax/abi.vim"
echo "    exec 'highlight BrightComment guifg= ' . g:abivim_color_supercomment" >> "$vimdir/syntax/abi.vim"
echo "    syntax match BrightComment \"##.*\"" >> "$vimdir/syntax/abi.vim"
echo "endif" >> "$vimdir/syntax/abi.vim"
