<p align="center">
  <img src="./assets/abivim_4.png" />
</p>

# AbiVim

This repository is in relation with the [Abinit Project](https://www.abinit.org/) 
that you can also find on GithuB [here](https://github.com/abinit/abinit).**This repository is not part of the official toolchain**
**of Abinit Project.**

__AbiVim__ is a vim plugin helping users of Abinit with its input files. It colors Abinit variables
for typo recognition, and runs a very simple syntax checker on save. 


# TODO 
- [ ] rewrite the README with up-to-date info
  * [X] Requirement
  * [X] Installation
  * [X] Quick Start
  * [ ] Usage
  * [ ] Custom Colors (bare-bones)
  * [ ] \(to add\) set variables and shortcuts 
- [ ] Write vimdoc
- [ ] complete installer.sh

# Table of Contents
1. [Requirement](#requirement)
2. [Installation](#installation)
3. [Quick start](#quick-start)
4. [Usage](#usage)
5. [Custom Colors](#custom-colors)
    1. [Modifying the color groups of abivars](#modifying-the-color-groups-of-abivars)
    2. [Modifying the custom color called by -c](#modifying-the-custom-color-called-by--c)
    3. [Modifying the colorscheme linked colors](#modifying-the-colorscheme-linked-colors)
    4. [Deactivating BrightComments](#deactivating-brightComments)
6. [Special Thanks](#special-thanks)

# Requirement 

You need at least vim version 8.2 for the autocomplete function to work. Any vim version should work for syntax coloring but vim >= 7.0 
is recommended. 

You need to have access to Abinit mkdocs locally to excute the script, you can download one at this
[adress](https://github.com/abinit/abinit/blob/master/abimkdocs/variables_abinit.py).

To activate Abivim features you need to write the following lines in you vimrc file

```vimscript
filetype plugin on
syntax on 
```

# Installation

To install the script just clone this repository somewhere 
```
git clone https://github.com/Chaostellaire/AbiVim.git abivim
```
or in ssh
```
git clone git@github.com:abinit/AbiVim.git abivim
```

To make the main script work you will also need an **Abinit documentation file**. 
You can find one in [Abinit's Github repo](https://github.com/abinit/abinit) in the `abimkdocs` directory. 

# Quick start

Use this command to quickly set up abivim features. 

```bash
./installer 
```

It will install the repository version of AbiVim that uses the documentation of Abinit 10.3.5


# Usage

This section is about how to use the AbiVim script. AbiVim is for the moment only able to extract "varnames" and "mnemonics" which is used as a description of every entry. In practice it also extracts "varsets" and "vartypes" for syntax coloring.

# Custom Colors

## Modifying the color groups of abivars

Abinit's variables are colored according to their variable sets by default. 
Each set is linked to a highlight group define by default by vim and linked to your colorscheme.
To see the availables groups define by your colorscheme you can enter the following vim command :
```vim
:so $VIMRUNTIME/syntax/hitest.vim
```
You can also see the Abinit sets names if you currently have loaded a .abi file in your buffer (they should be at the end).
By default all Abinit sets are linked to the `Keyword` group. You can modify this link in your
.vimrc with the following line : 
```vim
let g:abivim_link_basic = "Statement"
```

Here we modify the linked group of the variable set `basic` to `Statement`. You can exchange `basic`
with any varaible set name that you can find by typing in your terminal :

```bash
~/.vim/dict/abiset.txt | uniq
```

You can also define custom colors for each group set by enabling custom colors :

```vim
let g:abivim_color_custom = 1
let g:abivim_color_basic = "#dada00"
```

You can see every defined variables in the `abivim_var.vim` file in the `ftplugin/abi` directory

##### Quick Note :

If you want to modify the linked group or color for all variables, change directly in
`update_abivim.sh` (temporary solution) : 
```
#line 36
    echo "        let g:abivim_color_${sets} = \"NEWCOLOR\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

#line 45
    echo "    let g:abivim_link_${sets} = \"Keyword\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim" 

```
and in `abisyntax.sh` (temporary solution) for the color of numbers and units (line 58-59 and
70-74).

# Special thanks

Ioanna for the AbiVim logo and beta testing.
