# NERDTreePreview
Extends [NERDTree](https://github.com/preservim/nerdtree) with a live preview of files as you navigate the tree. 

## Dependencies
* [NERDTree](https://github.com/preservim/nerdtree)
* A shell with `file -ib`, used for excluding binary files from previews.

## Installation
Use a vim plugin manager or add NERDTreePreview.vim to ~/.vim/plugin

## Usage
NERDTreePreview displays a preview of non-binary files in the last active window. Upon quitting (hotkey q) or refocusing to a different window, the preview window is restored to the original buffer.

## Known Limitations
* Currently behaves as if NERDTreeQuitOnOpen=1 is set
* Opening vim on a directory (e.g. `vim .`) does not load NERDTreePreview correctly
