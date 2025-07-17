### ectract_var.sh : main file for extraction and installation of vim 
                  #  component for autocompletion of abinit's input
# Chaostellaire
# version 1.2
#

usage(){
echo -e ""
echo -e "\033[34m====================== \033[2mUSAGE $0\033[22m ======================\033[0m"
echo -e "desc : $0 extracts variables names and mnemonics from abinit       "
echo -e "       mkdocs.py file \033[36m like \033[2mvariabes_abinit.py\033[0m   "
echo -e "       and can set up vim files for autocomplete of abinit's input "
echo -e "                                                                   "
echo -e "                                                                   "
echo -e "ex : $0 -v --make-vimconfig variabes_abinit.py                     "
echo -e "    \033[36mwill extracts from variabes_abinit.py and write results\033[0m "
echo -e "    \033[36mto extract directory, then will construct vim config\033[0m"
echo -e "    \033[36mby appending 2 lines at the end of vimrc at            "
echo -e "    \033[34m\$HOME/.vim\033[36m, copying abi.vim to\033[34m \$HOME/.vim\033[36m"
echo -e "    \033[36mand copying on prompt results to \033[34m\$HOME/.vim/asset"
echo -e "                                                                   "
echo -e "    \033[0m                                                               "
echo -e "$0                                                                   "
echo -e " [-h | --help] [-v | --verbose] [-vv | --very-verbose]"
echo -e " [-vc | --vimconfig] [--vimdir-path <path/to/.vim>] [--vimrc-path  "
echo -e " <path/to/vimrc>] [--only-vim] [--only-extract] [-sv | --syntax] INPUTFILE"
echo -e ""
echo -e " \033[31mREQUIRED\033[0m \033[32mFLAG\033[0m \033[34mOPTION with ARGUMENT\033[0m"
echo -e "\033[2m\033[4mPOSITIONNAL ARGUMENT (COMPULSORY):\033[0m                       "
echo -e "                                                                   "
echo -e "\033[31mINPUT_FILE\033[0m                 File to be parsed for variable name and "
echo -e "                           description                             "
echo -e "                                                                   "
echo -e "\033[2m\033[4mOPTIONS (GLOBAL) :\033[0m                                                 "
echo -e "                                                                   "
echo -e "\033[32m-h   --help\033[0m                Will print this help message            "
echo -e "\033[32m-v   --verbose\033[0m             Be verbose with \033[32m >>> \033[0m prefix"
echo -e "\033[32m-vv  --very-verbose\033[0m        Be verbose and print all commands       "
echo -e "                                                                   "
echo -e "\033[2m\033[4mOPTIONS (VIM SETUP):\033[0m                                               "
echo -e "                                                                   "
echo -e "\033[32m-vc  --vimconfig\033[0m           Make files for vim and update dictionary"
echo -e "                           asset with prompt                       "
echo -e "\033[34m--vimdir-path\033[0m              Enter your .vim directory path.     "
echo -e "                           By default it is \033[34m\$HOME/.vim\033[0m            "
echo -e "\033[34m--vimrc-path\033[0m               Enter your vimrc file path. By default  "
echo -e "                           it is \033[34m\$vimdir_path/vimrc\033[0m        "
echo -e "\033[32m--only-vim\033[0m                 Flag for skipping the extraction of     "
echo -e "                           variable names in INPUT_FILE            "
echo -e "\033[32m--only-extract\033[0m             Flag for skipping vim set-up, needs     "
echo -e "                           the make-vimconfig flag to work. Will   "
echo -e "                           still propose to move extraction to     "
echo -e "                           \033[34m\$vimdir_path/assets/\033[0m     "
echo -e "                                                                   "
echo -e "\033[2m\033[4mOPTIONS (SYNTAX):\033[0m                          "
echo -e "                                                                   "
echo -e "\033[32m-sv   --syntax\033[0m             Add syntax highlight for .abi (BETA)    "
echo -e "\033[32m-c    --custom\033[0m             Use custom color definition, you can    "
echo -e "                           modify it in abisyntax.sh               "
echo -e "                                                                   "
echo -e "                                                                   "
}
msg(){
echo -e " --- $1 \033[0m"
}
verbmsg(){
if [ "$verb" = true ]; then echo -e "\033[32m >>> \033[0m $1"; fi
}

file_test(){
if [ ! -f "$1" ]; then 
    echo -e "\033[31m ERROR ---- \033[2m $1 \033[22m is not a file \033[0m"
    if [ "$2" = true ]; then exit 1 ; fi
    return 1
fi
return 0
}

dir_test(){
if [ ! -d "$1" ]; then 
    echo -e "\033[31m ERROR ---- \033[2m $1 \033[22m is not a dir \033[0m"
    if [ "$2" = true ]; then exit 1 ; fi
    return 1
fi
return 0
}

vimconfigparser(){
    if [ "$#" -eq 0 ]; then echo -e "\033[31m ERROR ---- not enough arguments please provide INPUT file"; exit 1; fi
    while [ "$#" -gt 0 ];do
        case $1 in
        esac
    done
}

parser(){
    if [ "$#" -eq 0 ]; then echo -e "\033[31m ERROR ---- not enough arguments please provide INPUT file"; exit 1; fi
    while [ "$#" -gt 0 ];do
        case $1 in
            -h | --help)
                usage
                exit 0
                ;;
            -v | --verbose)
                verb=true
                verbmsg "Verbose set on true"
                shift
                ;;
            -vv | --very-verbose)
                verb=true
                set -x
                verbmsg "Verbose set on true and set -x"
                shift
                ;;
            -vc | --vimconfig)
                vimconfig=true
                shift
                ;;
            --vimrc-path)
                file_test $2 true
                vimrc_path=$2
                shift
                shift
                ;;
            --vimdir-path)
                dir_test $2 true
                vimdir_path=$2
                shift
                shift
                ;;
            --only-extract)
                only_extract=true
                shift
                ;;
            --only-vim)
                only_vim=true
                shift
                ;;
            -sv | --syntax)
                syntax=true
                shift
                ;;
            -c | --custom)
                custom=true
                shift
                ;;
            -* | --*)
                echo -e "\033[31m ERROR ---- Unknown option \033[2m $1 \033[22m see usage :"
                usage
                exit 1
                ;;
            *)
                if [ "$#" -eq 1 ]; then
                    file_test $1 true
                    INPUT_FILE=$1
                    OUTPUT_LOC="extract"
                    mkdir -p "$OUTPUT_LOC"
                    shift
                    shift
                elif [ "$#" -gt 1 ]; then echo -e "\033[31m ERROR ---- please push INPUT\033[2m END \033[22mof the command line"; exit 1 ;
                else
                    echo "\033[31m ERROR ---- not enough arguments please provide INPUT file"
                fi
        esac
    done
}
custom=false
verb=false
parser "$@"


if [ "$only_vim" = true ];then msg "Skipping extraction of data"
else
    msg "Extracting varnames..."
    grep 'abivarname=' "$INPUT_FILE" | sed -E "s/.*abivarname=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abivar.txt"
    msg "Extracting mnemonics..."
    grep 'mnemonics=' "$INPUT_FILE" | sed -E "s/.*mnemonics=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abimnemo.txt"
    msg "done with extraction..."
fi

if [ "$vimconfig" = true ] ; then
    if [ "$only_extract" = true ]; then verbmsg "Skipping vim setting up"
    else
        msg "looking for vim directory and vimrc"
        if [[ -z "$vimdir_path" ]]; then 
            verbmsg "vimdir_path was not given, assuming .vim is in \$HOME"
            vimdir_path=$HOME/.vim
            dir_test $vimdir_path true
        fi
        if [[ -z "$vimrc_path" ]]; then
            verbmsg "vimrc_path was not given, assuming vimrc is in $vimdir_path"
            vimrc_path=$vimdir_path/vimrc
            file_test $vimrc_path true
        fi
        msg "checking if vimrc contains \033[36m abi filetype \033[0m declaration and \033[36mfiletype plugin on\033[0m !"
        if [ "$(grep "au! BufRead,BufNewFile \*.abi setfiletype abi" $vimrc_path | wc -l) " -eq 0 ]; then
            echo "au! BufRead,BufNewFile *.abi setfiletype abi" >> $vimrc_path
        fi
    
        if [ "$(grep "filetype plugin indent on" $vimrc_path | wc -l) " -eq 0 ]; then
            echo "filetype plugin indent on" >> $vimrc_path
        fi
    
        msg "sending filetype file..."
        mkdir -p "$vimdir_path/ftplugin"
        cp -i abi.vim "$vimdir_path/ftplugin/abi.vim"
        sed -i "1,$ s+PLACEHOLDER+${vimdir_path}+" $vimdir_path/ftplugin/abi.vim
    fi
    
    verbmsg "looking for assets vim dir"
    read -p "Would you like to copy extracted variables to $vimdir_path/assets (used by default abi.vim) ? [y/n] " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 0
    mkdir -p "$vimdir_path/assets"
    cp -f $OUTPUT_LOC/abi*.txt "$vimdir_path/assets"
msg "done"
fi


if [ "$syntax" = true ]; then
    msg "make syntax"
    ./abisyntax.sh $INPUT_FILE $OUTPUT_LOC $verb $vimdir_path $custom 
fi

        







