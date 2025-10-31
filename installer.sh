#!/bin/bash

usage() {

echo "========================   AbiVim    ============================"
echo ""
echo "A simple vim plugin for Abinit variables highlight and input help"
echo ""
echo "./installer.sh [-h|--help|--usage] [-u|--update] [--varfile VARFILE|-dl|--download]"
echo "               [--vimdir VIMDIRECTORY] [--check-vim] [-f|--force]"
echo ""
echo "USAGE : "
echo "---------"
echo ""
echo "    If no option is provided the installer will be launched in interactive mode  "
echo ""
echo "  -h  --help               Prints this help message and terminates the program"
echo "      --usage                                                                 "
echo "  -u  --update             Updates the content of ./ftplugin/abi and ./syntax/abi.vim"
echo "                           with the abinit variable documentation provided by the"
echo "                           --download option or --varfile option"
echo "      --varfile VARFILE    Use the provided Abinit documentation"
echo "                           (abinit/abimkdocs/variables_abinit.py)"
echo "  -dl --download [LINK]    Download the documentation from source or the "
echo "                           provided link" 
echo "      --vimdir VIMDIR      Use the provided vimdir location by default it is "
echo "                           \$HOME/.vim"
echo "  -f  --force              Don't ask when copying files"
}

parser() {
    while [ $# -gt 0 ] ; do
        case $1 in 
            -h | --help | --usage )
                usage
                exit 0
                ;;
            --vimdir )
                VIMDIR=$2
                shift
                shift
                ;;
            -dl | --download )
                DOWNLOAD=1
                if [ ${2:0:1} -ne "-" ] || ! [ -z  $2 ] ; then
                    DOWNLOAD_SITE=$2
                    shift
                fi
                shift
                ;;
            -u | --update )
                UPDATE=1
                shift
                ;;
            --varfile )
                VARFILE=$2
                shift
                shift
                ;;
            -f | --force )
                FORCE_PUSH=1
                shift
                ;;
            * )
                echo -e "\e[31m ERROR \e[0m --- Unknown option $1"
                exit 1
                ;;
        esac
    done

}

download_from() {
    local site=$1
    curl --proxy-anyauth $site
}

update() {
    ./update_abivim.sh $1
}

clean_install() {
    local vimdir=$1
    local isforce=$2
    
    if [ $isforce -eq 1 ]; then force="-f" ; else force="-i" ; fi
    mkdir -p "$vimdir/ftdetect" "$vimdir/ftplugin" "$vimdir/syntax" "$vimdir/autoload" "$vimdir/dict" "$vimdir/ftplugin/abi"
    cp $force ./autoload/* "$vimdir/autoload/"
    cp $force ./dict/* "$vimdir/dict/"
    cp $force ./syntax/* "$vimdir/syntax/"
    cp -r $force ./ftplugin/* "$vimdir/ftplugin/"
    cp $force ./ftdetect/* "$vimdir/ftdetect/"
}

DOWNLOAD=0
VIMDIR="$HOME/.vim"
DOWNLOAD_SITE="https://github.com/abinit/abinit/blob/master/abimkdocs/variables_abinit.py"
UPDATE=0
VARFILE=""
FORCE_PUSH=0

if [ $# -eq 0 ]; then
    echo "interactive not implemented yet"
    echo "1 - get a version of the variables file of abinit for exemple at "
    echo "$DOWNLOAD_SITE"
    echo "2 - try : ./installer.sh --vimdir <your/vim/dir> -u --varfile ./variables_abinit.py"
    echo "3 - add to your vimrc : filetype plugin on "
    echo "4 - you can modify abivim_* variables in your vimrc"
    exit 1
fi

parser "$@"
if [ -z $VARFILE ]; then echo "please provide a variable file" ; exit 1 ; fi
if [ $UPDATE -eq 1 ] ; then update $VARFILE ; fi

clean_install $VIMDIR $FORCE_PUSH

exit 0

