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
echo -e "ex : $0 -v --make-vimconfig variabes_abinit.py .                   "
echo -e "    \033[36mwill extracts from variabes_abinit.py and write results\033[0m "
echo -e "    \033[36mto current directory, then will construct vim config\033[0m"
echo -e "    \033[36mby appending 2 lines at the end of vimrc at            "
echo -e "    \033[34m\$HOME/.vim\033[36m, copying abi.vim to \$HOME/.vim\033[36m"
echo -e "    \033[36mand copying on prompt results to \033[34m\$HOME/.vim/asset"
echo -e "                                                                   "
echo -e "    \033[0m                                                               "
echo -e "                                                                   "
echo -e "$0 [-o | --options] INPUT_FILE OUTPUT_LOC                          "
echo -e "                                                                   "
echo -e "\033[2m\033[4mPOSITIONNAL ARGUMENTS :\033[0m                                            "
echo -e "                                                                   "
echo -e "INPUT_FILE                 File to be parsed for variable name and "
echo -e "                           description                             "
echo -e "OUTPUT_LOC                 Directory where the extracted variables "
echo -e "                           will be saved                           "
echo -e "                                                                   "
echo -e "\033[2m\033[4mOPTIONS (GLOBAL) :\033[0m                                                 "
echo -e "                                                                   "
echo -e "-h   --help                Will print this help message            "
echo -e "-v   --verbose             Be verbose with \033[32m >>> \033[0m prefix"
echo -e "-vv  --very-verbose        Be verbose and print all commands       "
echo -e "                                                                   "
echo -e "\033[2m\033[4mOPTIONS (VIM SETUP):\033[0m                                               "
echo -e "                                                                   "
echo -e "--make-vimconfig           Make files for vim and update dictionary"
echo -e "                           asset with prompt                       "
echo -e "--vimdir-location          Enter your .vim directory location.     "
echo -e "                           By default it is \033[34m\$HOME/.vim\033[0m            "
echo -e "--vimrc-location           Enter your vimrc file location. By      "
echo -e "                           default it is \033[34m\$vimdir_loc/vimrc\033[0m        "
echo -e "--only-vim                 Flag for skipping the extraction of     "
echo -e "                           variable names in INPUT_FILE            "
echo -e "--only-extract             Flag for skipping vim set-up, needs     "
echo -e "                           the make-vimconfig flag to work. Will   "
echo -e "                           still propose to move extraction to     "
echo -e "                           \033[34m\$vimdir_loc/assets/\033[0m     "
echo -e "-syn                       Add syntax highlight for .abi (BETA)    "
echo -e "                                                                   "
echo -e "                                                                   "
echo -e "                                                                   "
echo -e "                                                                   "
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

parser(){
    if [ "$#" -eq 0 ]; then echo -e "\033[31m ERROR ---- not enough arguments please provide INPUT file and OUTPUT dir"; exit 1; fi
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
            --make-vimconfig)
                vimconfig=true
                shift
                ;;
            --vimrc-location)
                file_test $2 true
                vimrc_loc=$2
                shift
                shift
                ;;
            --vimdir-location)
                dir_test $2 true
                vimdir_loc=$2
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
            -syn)
                syntax=true
                shift
                ;;
            -* | --*)
                echo -e "\033[31m ERROR ---- Unknown option \033[2m $1 \033[22m see usage :"
                usage
                exit 1
                ;;
            *)
                if [ "$#" -eq 2 ]; then
                    file_test $1 true
                    if [[ "$(dir_test $2 false)" == "1" ]] ; then 
                        echo -e "\033[33m MAKING DIR $2 \033[0m"
                        mkdir -p $2
                    fi
                    INPUT_FILE=$1
                    OUTPUT_LOC=$2
                    shift
                    shift
                elif [ "$#" -lt 2 ]; then echo -e "\033[31m ERROR ---- please push INPUT ant OUTPUT at the  \033[2m END \033[22m of the command line"; exit 1 ;
                else
                    echo "\033[31m ERROR ---- not enough arguments please provide INPUT file and OUTPUT dir"
                fi
        esac
    done
}


parser "$@"


if [ "$only_vim" = true ];then verbmsg "Skipping extraction of data"
else
    verbmsg "Extracting varnames..."
    grep 'abivarname=' "$INPUT_FILE" | sed -E "s/.*abivarname=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abivar.txt"
    verbmsg "Extracting mnemonics..."
    grep 'mnemonics=' "$INPUT_FILE" | sed -E "s/.*mnemonics=[\"']([^\"']+)[\"'].*/\1/" > "$OUTPUT_LOC/abimnemo.txt"
    verbmsg "done with extraction..."
fi

if [ "$vimconfig" = true ] ; then
    if [ "$only_extract" = true ]; then verbmsg "Skipping vim setting up"
    else
        verbmsg "looking for vim variable declaration"
        if [[ -z "$vimdir_loc" ]]; then 
            verbmsg "vimdir_loc was not given, assuming .vim is in \$HOME"
            vimdir_loc=$HOME/.vim
        fi
        if [[ -z "$vimrc_loc" ]]; then
            verbmsg "vimrc_loc was not given, assuming vimrc is in $vimdir_loc"
            vimrc_loc=$vimdir_loc/vimrc
        fi
        verbmsg "checking if vimrc contains abi filetype declaration and filetype plugin on !"
        if [ "$(grep "au! BufRead,BufNewFile \*.abi setfiletype abi" $vimrc_loc | wc -l) " -eq 0 ]; then
            echo "au! BufRead,BufNewFile *.abi setfiletype abi" >> $vimrc_loc
        fi
    
        if [ "$(grep "filetype plugin indent on" $vimrc_loc | wc -l) " -eq 0 ]; then
            echo "filetype plugin indent on" >> $vimrc_loc
        fi
    
        verbmsg "sending filetype file..."
        mkdir -p "$vimdir_loc/ftplugin"
        echo "here"
        cp -i abi.vim "$vimdir_loc/ftplugin/abi.vim"
    fi
    
    verbmsg "looking for assets vim dir"
    read -p "Would you like to copy extracted variables to $vimdir_loc/assets ? [y/n] " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 0
    mkdir -p "$vimdir_loc/assets"
    cp -f $OUTPUT_LOC/abi*.txt "$vimdir_loc/assets"
verbmsg "done"
fi


if [ "$syntax" = true ]; then
    verbmsg "make syntax"
    ./abisyntax.sh $INPUT_FILE $OUTPUT_LOC $verb $vimdir_loc 
fi

        







