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

#assume we go with sets coloring

declare -A ctermcolors
declare -A guicolors
guicolors=( ["basic"]="#f0c6c6" ["bse"]="#e6194B" ["dev"]="#7dc4e4" ["dfpt"]="#ed8796" ["dmft"]="#f58231" ["eph"]="#f58231" ["ffield"]="#f58231" ["files"]="#f0c6c6" ["geo"]="#f58231" ["gstate"]="#f0c6c6" ["gw"]="#f58231", ["gwr"]="#f58231", ["internal"]="#f0c6c6", ["paral"]="#f0c6c6", ["paw"]="#f58231" ["rlx"]="#ed8796" ["rttddft"]="#f58231" ["vdw"]="#f58231" ["w90"]="#f58231" )
ctermcolors=( ["basic"]="1" ["bse"]="3" ["dev"]="4" ["dfpt"]="2" ["dmft"]="9" ["eph"]="9" ["ffield"]="9" ["files"]="11" ["geo"]="9" ["gstate"]="1" ["gw"]="129", ["gwr"]="129", ["internal"]="8", ["paral"]="11", ["paw"]="14" ["rlx"]="9" ["rttddft"]="5" ["vdw"]="5" ["w90"]="5" )





sort "$OUTPUT_LOC/abiset.txt" | uniq > temp

mkdir -p "$vimdir/syntax"
if [ -f "$vimdir/syntax/abi.vim" ]; then rm -f "$vimdir/syntax/abi.vim";fi

while IFS= read -r sets; do
    echo "highlight $sets ctermfg=${ctermcolors[$sets]} guifg=${guicolors[$sets]}" >> "$vimdir/syntax/abi.vim"
done < "temp"

rm -f temp

echo "\" ============================" >> "$vimdir/syntax/abi.vim"


n=$(wc -l "$OUTPUT_LOC/abiset.txt")

while IFS= read -r var && IFS= read -r sets <&3; do
  echo "syntax keyword $sets $var" >> "$vimdir/syntax/abi.vim"
done < "$OUTPUT_LOC/abivar.txt" 3< "$OUTPUT_LOC/abiset.txt"


echo "syntax def Repeat guifg=#ed8796 guibg=#e6194b"
