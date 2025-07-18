#!/bin/bash
#syntax file maker for abivim

#COLLECT VARIABLES
#take where we have the dictionnary
INPUT_FILE=$1
OUTPUT_LOC=$2
verb=$3
vimdir=$4
custom=$5
#fetch every type of var :
#19 sets, 5 types....
grep 'varset=' "$INPUT_FILE" | sed -E "s/.*varset=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abiset.txt"

# color definition from catpuccin_mocha
rosewater="#F5E0DC"
flamingo="#F2CDCD"
pink="#F5C2E7"
mauve="#CBA6F7"
red="#F38BA8"
maroon="#EBA0AC"
peach="#FAB387"
yellow="#F9E2AF"
green="#A6E3A1"
teal="#94E2D5"
sky="#89DCEB"
sapphire="#74C7EC"
blue="#89B4FA"
lavender="#B4BEFE"


#assume we go with custom coloring
declare -A ctermcolors
declare -A guicolors
declare -A setlink
guicolors=( ["basic"]="$sapphire" ["bse"]="$sapphire" ["dev"]="$mauve" 
    ["dfpt"]="$red" ["dmft"]="$red" ["eph"]="$red" ["ffield"]="$red"
    ["files"]="$pink" ["geo"]="$teal" ["gstate"]="$sapphire" ["gw"]="$maroon"
    ["gwr"]="$maroon" ["internal"]="$flamingo" ["paral"]="$yellow" ["paw"]="$sapphire"
    ["rlx"]="$red" ["rttddft"]="$red" ["vdw"]="$maroon" ["w90"]="$maroon" )

#not up to date
ctermcolors=( ["basic"]="1" ["bse"]="3" ["dev"]="4" ["dfpt"]="2" ["dmft"]="9" ["eph"]="9"
    ["ffield"]="9" ["files"]="11" ["geo"]="9" ["gstate"]="1" ["gw"]="129" ["gwr"]="129"
    ["internal"]="8" ["paral"]="11" ["paw"]="14" ["rlx"]="9" ["rttddft"]="5" ["vdw"]="5" ["w90"]="5" )

setlink=( ["basic"]="Type" ["bse"]="Type" ["dev"]="Identifier" ["dfpt"]="Conditional" ["dmft"]="Conditional" ["eph"]="Conditional"
    ["ffield"]="Conditional" ["files"]="Boolean" ["geo"]="Operator" ["gstate"]="Type" ["gw"]="String" ["gwr"]="String"
    ["internal"]="Comment" ["paral"]="Boolean" ["paw"]="Type" ["rlx"]="Conditional"
    ["rttddft"]="Conditional" ["vdw"]="String" ["w90"]="String" )



sort "$OUTPUT_LOC/abiset.txt" | uniq > temp

mkdir -p "$vimdir/syntax"
if [ -f "$vimdir/syntax/abi.vim" ]; then rm -f "$vimdir/syntax/abi.vim";fi


echo "\" abi syntax file for vim" > "$vimdir/syntax/abi.vim"
echo " " >> "$vimdir/syntax/abi.vim"

# First define default groups
while IFS= read -r sets; do
    echo "highlight $sets ctermfg=${ctermcolors[$sets]} guifg=${guicolors[$sets]}" >> "$vimdir/syntax/abi.vim"
done < "temp"

# if we have not selected custom, link to vim theme
if [ "$custom" = false ]; then
    while IFS= read -r newsets; do
        echo "highlight! link $newsets ${setlink[$newsets]} ">> "$vimdir/syntax/abi.vim"
    done < "temp"
fi

#done with unique list
rm -f temp

echo "\" ============================" >> "$vimdir/syntax/abi.vim"


n=$(wc -l "$OUTPUT_LOC/abiset.txt")

while IFS= read -r var && IFS= read -r sets <&3; do
  echo "syntax match $sets \"\<$var[0-9]*[:?]*\>\"" >> "$vimdir/syntax/abi.vim"
done < "$OUTPUT_LOC/abivar.txt" 3< "$OUTPUT_LOC/abiset.txt"

# add comment detection :

echo "\" ============================" >> "$vimdir/syntax/abi.vim"

echo "syntax match Comment \"#.*\"" >> "$vimdir/syntax/abi.vim"
echo "highlight BrightComment ctermfg=4 guifg=$green" >> "$vimdir/syntax/abi.vim"
echo "syntax match BrightComment \"^##.*\"" >> "$vimdir/syntax/abi.vim"
echo "highlight Repeat guifg=#ed8796 guibg=#e6194b" >> "$vimdir/syntax/abi.vim"
if [ "$custom" = false ]; then echo "highlight! link Repeat SpellBad" >> "$vimdir/syntax/abi.vim"; fi
