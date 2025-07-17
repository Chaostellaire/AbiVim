<p align="center">
  <img src="./abivim.png" />
</p>
# AbiVim

This repository is in relation with the [Abinit Project](https://www.abinit.org/) 
that you can also find on GithuB [here](https://github.com/abinit/abinit).**This repository is not part of the official toolchain**
**of Abinit Project.**

AbiVim can set up an autocompleter for Abinit's input files inside vim. It can parse mkdocs.py files from
Abinit's source code to generate lists of relevent data relating to Abinit's input variables.

# Requirement 

You need at least vim version 8.2 for the autocomplete function to work. Any vim version should work for syntax coloring but vim >= 7.0 
is recommended. 

You need to have access to Abinit mkdocs locally to excute the script.


# Installation

To install the script just clone this repository somewhere 
```
git clone https://github.com/Chaostellaire/vim-autocomplete4abi.git AbiVim
```
or in ssh
```
git clone git@github.com:abinit/abinit.git AbiVim
```

To make the main script work you will also need an **Abinit documentation file**. 
You can find one in [Abinit's Github repo](https://github.com/abinit/abinit) in the `abimkdocs` directory. 

# Usage

This section is about how to use the AbiVim script. AbiVim is for the moment only able to extract "varnames" and "mnemonics" which is used as a description of every entry. In practice it also extracts "varsets" and "vartypes" for syntax coloring.

## Simple data extraction

To only extract varnames and mnemonics you can run, with your input as  
```
./abivim.sh INPUT_FILE
```
extracted variables will be stored in a new directory `$pwd/extract/` as text files. You can check there if the extracted content is correct



## Vim configuration

AbiVim is able to configure your vim environment to enable vim autocomplete and syntax features.

### With AbiVim

To update your vimrc file and vim folder you can use `-vc` option flag. It will assume that your .vim directory is inside your HOME directory, and that your vimrc file is inside it.

```
./abivim.sh -vc variables_abinit.py #will use $HOME/.vim and $HOME/.vim/vimrc as vim directory and file
```

You can change the vim pathes with options `--vimdir-path` and `--vimrc-path`

```
./abivim.sh -vc --vimrc-path ~/.vimrc variables_abinit.py #will use $HOME/.vim and $HOME/.vimrc
```

AbiVim will check if your vimrc has the required options to make autocomplete work. If they are not present it will append these options at the end of your vimrc file.

Next step is to create the abi.vim file that will be used to define abi filetype specific commands. Because abi.vim file will be copied, you
can modify it as you please. Note that "PLACEHOLDER" will be changed by the vimdir path you gave to AbiVim

To enable syntax highlight use the `-sv` flag. Syntax routines are independent from the vim autocomplete configuration.
However, if you which to only enable syntax highlight, you still need to declare 
.abi files as a custom filetype in your vimrc, activate syntax and extract variables.

### By hand

You can set up your vim by hand to have complete control over the directory tree sitting in `.vim`.

First you need to declare .abi files as a custom file type. Add to your vimrc the following :

```
au! BufRead,BufNewFile *.abi setfiletype abi
filetype plugin indent on
```

This will enable Abinit's inputs file detection and call the scripts located at `.vim/ftplugin/abi.vim` and `.vim/syntax/abi.vim`

Next you need to add a 'ftplugin' directory to the '.vim' directory-tree. When vim detects that your file satisfies a filetype requirement, it will load the corresponding vimscript in `.vim/ftplugin/<filetype>.vim` in our case we declared all `*.abi` files to be an "abi" filetype





## Updating the input database
