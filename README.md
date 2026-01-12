<p align="center">
  <img src="./assets/abivim_4.png" />
</p>

# AbiVim

This repository is related to the [Abinit Project](https://www.abinit.org/) 
that you can also find on Github [here](https://github.com/abinit/abinit).
**This repository is not part of the official toolchain**
**of the Abinit Project.**

**AbiVim** is a vim plugin helping users of Abinit with its input files.
It colors Abinit variables for typo recognition, provides a rolling menu
suggesting completion, and fetches variable documentation if needed. 


# Table of Contents
(BROKEN)
1. [Requirement](#requirement)
2. [Installation](#installation)
   1. [Cloning](#cloning)
   2. [Plugin Manager](#vim-plugin-manager)
3. [Quick start](#quick-start)
4. [Usage](#usage)
   1. [Syntax Coloring](#syntax-coloring)
   2. [Custom Colors](#custom-colors)
   3. [Autocomplete](#autocomplete-mode)
   4. [Checker](#simple-checker)
   5. [Abinit variables documentation](#variable-documentation)
5. [Global parameters](#global-parameters)
6. [Special Thanks](#special-thanks)

# Requirement 

You need at least vim version 8.2 for the autocomplete function to work
_(not sure about that...)_.
Any vim version should work for syntax coloring but vim >= 7.0 
is recommended ( oldest version tested ). 

You need to have access to Abinit mkdocs locally to excute the scripts,
 you can download one at this
[adress](https://github.com/abinit/abinit/blob/master/abimkdocs/variables_abinit.py).
It is recommended to use the python-script associated with your version of
Abinit so to not have ghost keywords.

Finally, to enable Abivim features, you need to write the following lines in you vimrc file

```vimscript
filetype plugin on
syntax on 
```

# Installation

## Cloning (recommanded)

Choose a location where you can re-access AbiVim directory, to use the
`update_abivim.sh` in the future if you ever need to update the keywords
dictionnaries.

```
mkdir -p ~/app/abivim 
git clone --depth 1 https://github.com/Chaostellaire/AbiVim.git ~/app/abivim
```

To make the main script work you will also need an **Abinit documentation file**. 
You can find one in [Abinit's Github repo](https://github.com/abinit/abinit) 
in the `abimkdocs` directory. However the current repo is intialized with
Abinit v10.4.7, downloaded 2025-11-24.

## Vim plugin manager

You can clone this repo using a vimplugin manager. 

Ex for VimPlug:
```vimscript
Plug 'Chaostellaire/AbiVim.git'
```

## Mixing 

If your Plugin manager provide this feature you can clone the repo in a
easy to access location and call your plugin function with the absolute
path to that directory. In that case you can simply update keywords with
`update_abivim.sh` without calling `installer.sh`.

Ex for VimPlug:
```vimscript
Plug '~/app/abivim'
```

# Quick start

Use this command to quickly set up abivim features. In your 

```bash
./installer --vimdir $HOME/.vim
```

It will install the repository version of AbiVim that uses the documentation
of Abinit 10.4.7.

# Usage

This section is about how to use the AbiVim features and update scripts. 


## Syntax coloring

The main feature of AbiVim is to provide syntax coloring for Abinit basic
input variables. It doesn't supports yet keywords from multibinit, anaddb,
or atdep.

Highlighted keywords are case insensive and follow Abinit's dataset
numbering convention, namely adding '+,?,:' doesn't break highlighting.
This feature is meant to be used as a way to prevent typos before launching
abinit.

AbiVim also highlights valid units, strings, floating numbers and int. It
also provide simple comments marked by '!', or '#' and highlighted comments
marked by a double hashtag '##'.

### Updating dictionnaries

AbiVim provides scripts to update the syntax files and autocomplete
function depending on the documentation that you provide to them.

To update local files you can either use `update_abivim.sh
<path/to/variables_abinit.py>` to update the current working directories
dictionnaries, or use `installer.sh -u --varfile
<path/to/variables_abinit.py> --vimdir <your/.vim>` to update and copy the
files to the .vim location.

## Custom Colors

### Modifying the color groups of abivars

Abinit's variables are colored according to their variable sets by default. 
Each set is linked to a highlight group define by default by vim and linked
to your colorscheme. To see the availables groups define by your 
colorscheme you can enter the following vim command :
```vim
:so $VIMRUNTIME/syntax/hitest.vim
```
You can also see the Abinit sets names if you currently have loaded a .abi
file in your buffer (they should be at the end). By default all Abinit sets
are linked to the `Keyword` group. You can modify this link in your
.vimrc with the following line : 
```vim
let g:abivim_link_basic = "Statement"
```

Here we modify the linked group of the variable set `basic` to `Statement`.
You can exchange `basic` with any varaible set name that you can find by 
typing in your terminal :
```bash
~/.vim/dict/abiset.txt | uniq
```

You can also define custom colors for each group set by enabling custom 
colors :
```vim
let g:abivim_color_custom = 1
let g:abivim_color_basic = "#dada00"
```

You can see every defined variables in the `abivim_var.vim` file in the 
`ftplugin/abi` directory

##### Quick Note :

If you want to modify the linked group or color for all variables, change directly in
`update_abivim.sh` (temporary solution) : 
```bash
#line 36
    echo "        let g:abivim_color_${sets} = \"NEWCOLOR\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim"

#line 45
    echo "    let g:abivim_link_${sets} = \"Keyword\"" >> "$SCRIPT_DIR/ftplugin/abi/abivim_var.vim" 

```
and in `abisyntax.sh` (temporary solution) for the color of numbers and units (line 58-59 and
70-74).

## Autocomplete mode

The autocomplete feature replaces vim's built-in completion function with
abinits keywords and their mnemonics. To enable it type a word and press
Crtl-X + Crtl-U in insert mode to show suggestions. Crtl-N goes to the next
suggestion and Ctrl-P to the previous. You can confirm with Enter.

## Simple checker

Abivim has a build-in command `:HighlightRepeats`. No keys is binded by
default. This command will check if a keyword is duplicated somewhere in
the input file. AbiVim will then highlight lines countaining duplicates
keywords. You can set `g:abivim_error_on_save` to 1 in your vimrc file, to
execute this command every time the file is saved.
However, be aware that the command will reset your cursor at the top of the
file (known bug). 

## Variable documentation

if you provide in your vimrc, or in ftplugin/abi.vim the location of the
variable\_abinit.py that you are using AbiVim can either open the web-page
corresponding to the variable under the cursor with `:GoToDef` or open the
documentation in vim with `:ShowDef` or Ctrl-]. 

variable to set : `let g:abinit_documentation_path='some/path/to/variable\_abinit.py'`
##### Note :

Vim is able to understand environement variable. You can for exemple set
`$ABINIT_DOC` to point to the location of your abinit documentation.

# Global parameters

| Parameter name | Usage | Default | Possible |
| :------------ | :---- | :-----: | :------: |
| `g:abivim_color_custom` | Enable custom colors | 0 | 0,1 |
| `g:abivim_supercomment` | Enable supercomment highlight | 1 | 0,1 |
| `g:abivim_color_repeatfg` | Color hexcode for repeat error foreground | '#b5bfe2' | '#rrggbb' |
| `g:abivim_color_repeatbg` | Color hexcode for repeat error background | 'e78284' | '#rrggbb' |
| `g:abivim_link_repeat` | Link group highlight of repeat | 'Error' |'Link\_group' |
| `g:abivim_color_supercomment` | Supercomment Color | '#a6d189' | '#rrggbb' |
| `g:abivim_color_varset` | \<varset\> custom color | '#ef9f76' | '#rrggbb' |
| `g:abivim_link_varset` | \<varset\> link group highlight | 'Keyword' | 'Link\_group' |
| `g:abivim_error_on_save` | Parse the file with the `HighlightRepeats` command after write command | 0 | 0,1 |
| `g:abivim_help_win` | Display mode of the help window | 'split' | 'split', 'vsplit', 'tabnew', 'popup'|
| `g:abinit_documentation_path` | Absolute path to `varirable_abinit.py` | not set | "path" |

# Special thanks

Ioanna for the AbiVim logo and beta testing.
