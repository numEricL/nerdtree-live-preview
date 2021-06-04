# NERDTreePreview
Extends [NERDTree](https://github.com/preservim/nerdtree) with a live preview of
files as you navigate the tree.

## Dependencies
* [NERDTree](https://github.com/preservim/nerdtree)
* A shell with `file -ib`, used for excluding binary files from previews.

## Installation
Use a vim plugin manager or add NERDTreePreview.vim to ~/.vim/plugin

## Usage
NERDTreePreview displays a preview of non-binary files in the last active
window. Upon quitting (hotkey q) or refocusing to a different window, the
preview window is restored to the original buffer. Preview windows are
non-modifiable, to edit you must open the file with the NERDTree default
mappings.

## Known Limitations
* Currently requires NERDTreeQuitOnOpen=1 to be set
* Default NERDTree mappings must be used
* Using :q to exit the NERDTree window does not clear the preview, use q instead
* Opening vim on a directory (e.g. `vim .`) does not load NERDTreePreview correctly
