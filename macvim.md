# Vim Commands

## Basic Mappings

The leader is mapped to `\`

`\n` NERDTree

`command-t` Command-T a la TextMate

`command-e` ConqueTerm

`^Wt^WK` To change two vertically split windows to horizonally split

`^Wt^WH` Horizontally to vertically

where `^W` means "hit Ctrl-W". Explanations:

    ^Wt     makes the first (topleft) window current
    ^WK     moves the current window to full-width at the very top
    ^WH     moves the current window to full-height at far left

# Config

Add to `~/.vimrc`:

    " auto remove whitespace on buffer save
    autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

...and increase the font size

    " custom
    set guifont=Monaco:h16

## Pathogen

Add the following to `~/.vimrc`

    call pathogen#infect()
    call pathogen#helptags()
    syntax on
    filetype plugin indent on

## [Snipmate](https://github.com/garbas/vim-snipmate)
Instructions: [https://github.com/garbas/vim-snipmate](https://github.com/garbas/vim-snipmate)
snipMate.vim aims to be a concise vim script that implements some of TextMate's snippets features in Vim.

Using Pathogen

    % cd ~/.vim
    % mkdir bundle
    % cd bundle
    % git clone git://github.com/garbas/vim-snipmate.git

    # Install dependencies:
    % git clone https://github.com/tomtom/tlib_vim.git
    % git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
    % git clone https://github.com/honza/snipmate-snippets.git

