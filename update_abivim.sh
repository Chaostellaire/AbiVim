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

linenb=$(grep -Pn "Colors Settings: {{{" "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim" | grep -Po -m 1 '^(\d+)')

#destroy previous colors settings
sed -i "${linenb},\$d" "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

# add new colors
echo "\" Colors Settings: {{{" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
echo "\" ! PUSH AT THE END OF FILE !" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

echo "" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

echo "\" >>Customs" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

echo "if g:abivim_color_custom" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
while IFS= read -r sets; do
    echo "    if !exists(\"g:abivim_color_${sets}\")" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
    echo "        let g:abivim_color_${sets} = \"#94E2D5\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
    echo "    endif" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim" 
done < "temp"

echo "" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
echo "else" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
echo "\" >>Linkers" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
while IFS= read -r sets; do
    echo "    if !exists(\"g:abivim_link_${sets}\")" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
    echo "    let g:abivim_link_${sets} = \"Type\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
    echo "    endif" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
done < "temp"
rm temp
echo "endif" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

echo "" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"
echo "\" }}}"  >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim" 

./abisyntax.sh "$DOC" "$SCRIPT_DIR/dict" false "$SCRIPT_DIR" 
