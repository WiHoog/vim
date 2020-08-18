" Create by wihoog
" ------------------------------------------------------------------------------
" For bufexplorer
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_bufexplorer()
	" <leader>b opens the buffer list
	noremap		<leader>b			:BufExplorer<cr>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For NREDTree
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_nredtree()
	noremap		<F8>				:NERDTreeToggle<cr>
	" Putting NERDTree window right
	let g:NERDTreeWinPos                        ='right'
	let g:nerdtree_tabs_open_on_console_startup =1
	" Ignore these files
	let g:NERDTreeIgnore                        =['\.o', '\.pyc','\~$','\.swp']
	" Show the bookmarks
	let g:NERDTreeShowBookmarks                 =1
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For ultiSnips
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_ultisnips()
	" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
	let g:UltiSnipsExpandTrigger       ="<c-tab>"
	let g:UltiSnipsJumpForwardTrigger  ="<c-Right>"
	let g:UltiSnipsJumpBackwardTrigger ="<c-Left>"

	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit           ="vertical"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Airline
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_airline()
	" set it after fonts has been installed.
	let g:airline_powerline_fonts		=1

	if !exists('g:airline_symbols')
		let g:airline_symbols			={}
	endif
	" unicode symbols
	let g:airline_left_sep				='▶'
	let g:airline_left_alt_sep			='❯'
	let g:airline_right_sep				='◀'
	let g:airline_right_alt_sep			='❮'
	let g:airline_symbols.linenr		='¶'
	let g:airline_symbols.branch		='⎇'

	" Setting the theme
	let g:airline_theme					='badwolf'

	" Enable the list of buffers
	let g:airline#extensions#tabline#enabled		=1
	" Show just the filename
	let g:airline#extensions#tabline#fnamemod		=':t'
	"let g:airline#extensions#tabline#left_sep		=' '
	"let g:airline#extensions#tabline#left_alt_sep	='|'

	let g:airline#extensions#whitespace#enabled		=0
	autocmd FileType python  let g:airline#extensions#whitespace#enabled=1
	autocmd BufReadPre  *.c  let g:airline#extensions#whitespace#enabled=0
	autocmd BufReadPre  *.h  let g:airline#extensions#whitespace#enabled=0
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For gitgutter
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_gitgutter()
	" To disable all key mappings:
	let g:gitgutter_map_keys		=0

	" Use a custom grep command
	let g:gitgutter_grep			='grep'
	" To turn off vim-gitgutter by default
	let g:gitgutter_enabled		=1

	" To turn off signs by default
	 let g:gitgutter_signs =1

	" To turn on line highlighting by default
	let g:gitgutter_highlight_lines	=0
"	let g:gitgutter_highlight_linenrs=1
"	let g:gitgutter_preview_win_floating = 1
"	let g:gitgutter_use_location_list = 1 
	" To turn off asynchronous updates
"	let g:gitgutter_async			=0
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" For CtrlP
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_ctrlp()
	let g:ctrlp_map				='<c-p>'
	let g:ctrlp_cmd				='CtrlP'
	" 1: search file by file name
	" 0: search file by full pmth
	let g:ctrlp_by_filename		=0
	" Set no file limit, we are building a big project
	let g:ctrlp_max_files		=0

	" If ag is available use it as filename list generator instead of 'find'
	" if executable("ag")
	"     set grepprg=ag\ --nogroup\ --nocolor
	"     let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
	" endif
	let g:ctrlp_user_command	={
				\ 'types': {
				\ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
				\ 2: ['.hg', 'hg --cwd %s locate -I .'],
				\ },
				\ 'fallback': 'ag %s -l --nocolor -g ""'
				\ }
	let g:ctrlp_match_window	='bottom,order:btt,min:1,max:100,results:1000'

	" PyMatcher for CtrlP
	let g:ctrlp_match_func		={ 'match': 'pymatcher#PyMatch'}

	" Set delay to prevent extra search
	let g:ctrlp_lazy_update		=350

	" Do not clear filenames cache, to improve CtrlP startup
	" You can manualy clear it by <F5>
	let g:ctrlp_clear_cache_on_exit	=0

	" For CtrlPFunky
	nnoremap	<c-\>			:CtrlPFunky<Cr>
	" narrow the list down with a word under cursor
	nnoremap	<c-?>			:execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For YouCompleteMe
" ------------------------------------------------------------------------------
"
function! BuildYouCompleteMe(info)
	" info is a dictionary with 3 fields
	" - name:   name of the plugin
	" - status: 'installed', 'updated', or 'unchanged'
	" - force:  set on PlugIGGnstall! or PlugUpdate!
	if a:info.status == 'installed' || a:info.force
		!./install.py --clang-completer --java-completer
	endif
endfunction

" YouCompleteMe Settings
function! s:configure_plugins_ycm()
	let g:ycm_use_clangd = 0
	let ycm_conf = getcwd() . "/.ycm_extra_conf.py"
	"	if filereadable(ycm_conf)
	"		let g:ycm_global_ycm_extra_conf = ycm_conf
	"	else
	let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_conf/ycm_extra_conf.py"
	"	endif
	"let g:ycm_server_python_interpreter='/usr/bin/python'
	"let g:ycm_show_diagnostics_ui = 0                  "关闭语法提示
	let g:ycm_complete_in_comments=1                   " 补全功能在注释中同样有效
	let g:ycm_confirm_extra_conf=0                     " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
	let g:ycm_collect_identifiers_from_tags_files=1    " 开启 YCM 标签补全引擎
	let g:ycm_min_num_of_chars_for_completion=1        " 从第一个键入字符就开始罗列匹配项
	let g:ycm_cache_omnifunc=1                         " 禁止缓存匹配项，每次都重新生成匹配项
	let g:ycm_seed_identifiers_with_syntax=1           " 语法关键字补全
	"let g:ycm_goto_buffer_command = 'horizontal-split' " 跳转打开上下分屏
	let g:ycm_enable_diagnostic_signs = 0
	let g:ycm_enable_diagnostic_highlighting = 0	
	map <F10>		:YcmCompleter GoToDefinition<CR>
	map <F11>		:YcmCompleter GoToDeclaration<CR>
	"	map <F12>		:YcmCompleter GoToDefinitionElseDeclaration<CR>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Tagbar
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_tagbar()
	nnoremap	<silent><F6>		:TagbarToggle<CR>

	let g:tagbar_left	=1
	let g:tagbar_width	=30
	"let g:tagbar_expand	=1
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For Vim Signature
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_signature()
	noremap		<silent><F3>		]`
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For plantuml
" ------------------------------------------------------------------------------
"
function! Plantuml_pdf()
	execute "!plantuml -tsvg " . expand("%:p")
	execute "!rsvg-convert -f pdf -o " . expand("%:p:r") . ".pdf " . expand("%:p:r") . ".svg"
	execute "!rm " . expand("%:p:r") . ".svg"
endfunction

function! s:configure_plugins_plantuml()
	autocmd FileType	plantuml	noremap		<silent><F5>	:make<cr><cr>
	autocmd FileType	plantuml	noremap		<silent><F8>	:call Plantuml_pdf()<cr>
	"let g:plantuml_executable_script='plantuml -tpng'
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" For ogsearch
" ------------------------------------------------------------------------------
"
function! s:configure_plugins_ogsearch()
	"	let g:ogs_app_url = 'http://10.20.72.62:8080/source/'
	"	let g:ogs_browser_command = 'google-chrome-stable'
endfunction
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" For the vim scripts manager --- vim plug
" ------------------------------------------------------------------------------

function! s:configure_plugins_manager()
	" Plugins will be downloaded under the specified directory.
	call plug#begin('~/.vim/plugged')

	" Declare the list of plugins.
	Plug 'jlanzarotta/bufexplorer'

	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'

	Plug 'Lokaltog/vim-powerline'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'airblade/vim-gitgutter'

	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'FelikZ/ctrlp-py-matcher'
	Plug 'tacahiroy/ctrlp-funky'

	Plug 'jdevera/vim-opengrok-search'

	Plug 'Valloric/YouCompleteMe', {'for': ['c', 'h', 'cpp', 'python', 'java'], 'do': function('BuildYouCompleteMe') }

	"Plug 'davidhalter/jedi-vim'

	Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

	Plug 'andreyugolnik/manpageview', {'for': ['c', 'h', 'cpp']}

	Plug 'aperezdc/vim-template'

	Plug 'aklt/plantuml-syntax', {'for': ['pu', 'uml', 'plantuml']}

	Plug 'kshenoy/vim-signature'

	Plug 'lfv89/vim-interestingwords'

	Plug 'yianwillis/vimcdoc'

	"	Plug 'zxqfl/tabnine-vim'
	Plug 'Chiel92/vim-autoformat'
	Plug 'liuchengxu/space-vim-theme'
	Plug 'morhetz/gruvbox'
	" 2019 11 13 add markdown 
	Plug 'godlygeek/tabular'
	Plug 'plasticboy/vim-markdown'
	Plug 'chun-yang/auto-pairs' 
	"Plug 'dschwen/switch-header-source'
	Plug 'kien/rainbow_parentheses.vim'
	
	
	"
	"
	

	"Plug 'chxuan/cpp-mode'
	"Plug 'chxuan/vim-edit'
	"Plug 'chxuan/change-colorscheme'
	"Plug 'chxuan/prepare-code'
	"Plug 'chxuan/vim-buffer'
	"Plug 'chxuan/vimplus-startify'
	"Plug 'chxuan/tagbar'
	"Plug 'Valloric/YouCompleteMe'
	"Plug 'Yggdroot/LeaderF'
	"Plug 'mileszs/ack.vim'
	"Plug 'easymotion/vim-easymotion'
	"Plug 'haya14busa/incsearch.vim'
	"Plug 'jiangmiao/auto-pairs'
	"Plug 'scrooloose/nerdtree'
	"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	"Plug 'Xuyuanp/nerdtree-git-plugin'
	"Plug 'godlygeek/tabular'
	"Plug 'tpope/vim-fugitive'
	"Plug 'tpope/vim-surround'
	"Plug 'tpope/vim-commentary'
	"Plug 'tpope/vim-repeat'
	"Plug 'tpope/vim-endwise'
	Plug 'octol/vim-cpp-enhanced-highlight'   "api 高亮"
	"''Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	"Plug 'ryanoasis/vim-devicons'
	"Plug 'junegunn/vim-slash'
	"Plug 'junegunn/gv.vim'
	"Plug 'kana/vim-textobj-user'
	"Plug 'kana/vim-textobj-indent'
	"Plug 'kana/vim-textobj-syntax'
	"Plug 'kana/vim-textobj-function'
	"Plug 'sgur/vim-textobj-parameter'
	"Plug 'Shougo/echodoc.vim'
	"Plug 'terryma/vim-smooth-scroll'
	"Plug 'rhysd/clever-f.vim'
	"Plug 'vim-scripts/indentpython.vim'
	"Plug 'docunext/closetag.vim'
	" end
	" List ends here. Plugins become visible to Vim after this call.
	call plug#end()

	" Make a configure of some plugins.
	call s:configure_plugins_bufexplorer()
	call s:configure_plugins_nredtree()
	call s:configure_plugins_ultisnips()
	call s:configure_plugins_airline()
	call s:configure_plugins_gitgutter()
	call s:configure_plugins_ctrlp()
	call s:configure_plugins_ycm()
	call s:configure_plugins_tagbar()
	call s:configure_plugins_signature()
	call s:configure_plugins_plantuml()
	call s:configure_plugins_ogsearch()
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some global and basic settings
" ------------------------------------------------------------------------------
"
function! s:configure_base_settings()
	" It's not compatible with vi
	set nocompatible

	" Set the max number instructions recorded in last vim running.
	set viminfo='20,\"50
	set history=200

	" Make the Time is in English
	language time en_US.UTF8

	filetype plugin on
	filetype indent on

	set nobackup
	set nowb
	set noswapfile

	set showcmd

	colorscheme desert
	set laststatus=2
	set ruler

	if &t_Co > 2 || has("gui_running")
		syntax on
		set hlsearch
	endif

	if !has("gui_running")
		set mouse=i
		set cursorline
		hi cursorline    guibg=#000000
		hi CursorColumn  guibg=#333333
	endif

	set number

	let g:username="wihoog"
	let g:email="com"
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some  settings related with file, such as encoding.
" ------------------------------------------------------------------------------
"
function! s:configure_file_encoding()
	set fileformats=unix

	" Try the following encodings when open a file.
	set fileencodings=utf-8,gb2312,cp936,gbk,big5,ucs-bom,latin

	if has("win32")
		set fileencoding=cp936
	else
		set fileencoding=utf-8
	endif

	set encoding=utf-8

	" correspondence with Terminal
	let &termencoding=&encoding
	" set termencoding=cp936

	" Try to use chinese user manual if it exists.
	set helplang=cn
	" Fix the Chinese character issue at end of a line
	set formatoptions+=rmM
endfunction
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" Some global shortkey settings according to my own preferences
" ------------------------------------------------------------------------------
"
function! s:configure_global_shortkey()
	" make spece key as vim leader key
	let g:mapleader =" "

	" Change logic line to screen line
	noremap		<C-J>				gj
	noremap		<C-K>				gk
	noremap		<Down>				gj
	noremap		<Up>				gk
	inoremap	<Down>				<c-o>gj
	inoremap	<Up>				<c-o>gk

	" For switching windows
	noremap		<c-Up>				<c-w><up>
	noremap		<c-Left>			<c-w><left>
	noremap		<c-Right>			<c-w><right>
	noremap		<c-Down>			<c-w><down>

	inoremap	<c-Up>				<c-o><c-w><up>
	inoremap	<c-Left>			<c-o><c-w><left>
	inoremap	<c-Right>			<c-o><c-w><right>
	inoremap	<c-Down>			<c-o><c-w><down>

	" For saving file
	noremap		<c-s>				:w<cr>
	inoremap	<c-s>				<C-O>: w<cr>

	" In Normal mode:
	" ctrl + space:		insert a space without vim mode changing
	" ctrl + CR:		insert a line without vim mode changing
	noremap		<c-Space>			i <Esc>
	noremap		<c-CR>				o<Esc>k

	" Jump to next/previous error
	noremap		<c-.>				:cn<cr>
	noremap		<c-,>				:cp<cr>

	" <leader>t:	open a new tab
	noremap		<leader>t			:tabnew<cr>

	" Ctrl+A:		select all
	noremap		<leader>a			ggVG
	" Ctrl+F:		select code block in brackets, such as: (...) {...} [...]
	noremap		<leader>f			v%

	" <leader>p		Paste the content of external GUI clipboard to here
	" <leader>y		Copy the content selected to external GUI clipboard
	" <leader>k		Cut the content selected to external GUI clipboard
	noremap		<silent><leader>p	"+gP
	"下面的<esc> 空格必须要
	inoremap	<silent><leader>p	<Esc> "+gPa
	vnoremap	<silent><leader>y	"+y
	vnoremap	<silent><leader>k	"+x

	" <leader>q		Delete current buffer in normal mode
	noremap		<leader>d			:bdelete<cr>
	" <leader>o		close other windows
	noremap		<leader>o			<c-w>o
	" <leader>o		close current windows/tab
	noremap		<leader>c			:confirm close<cr>

	if has("unix")
		noremap	<leader>e			:e <C-R>=expand("%:h") . "/" <CR>
	else
		noremap	<leader>e			:e <C-R>=expand("%:p:h") . "\" <CR>
	endif

	" close the highlight temporarily
	nmap		<silent><F2>		:nohl<cr>

	" Disable the pasting function of middle mouse key
	noremap		<MiddleMouse>		<Nop>
	inoremap	<MiddleMouse>		<Nop>

	" Recovery the pasting function of middle mouse key
	" unmap		<MiddleMouse> iunmap	<MiddleMouse>

	" Format a paragraph of text
	noremap		Q					gq

	nmap mm :%s/<c-v><c-m>//g<Esc>
"	nmap ** i/*   */<Esc>3h<Esc>i
	
	noremap ** i/*   */<Esc>3h<Esc>i
	inoremap ** /*   */<Esc>3h<Esc>i
	""===== cscope ===nmap csco :!cscope -Rbq<CR>
	"	nmap && call s:cscope_fun()<CR><CR>
	"	" For saving file
	noremap		<c-s>				:w<cr>
	inoremap	<c-s>				<C-O>: w<cr>

endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on C file and H file
" ------------------------------------------------------------------------------
"
" This function is setting the path global variables for "gf" command
function! s:configure_linux_kernel_path()
	if !exists('g:linux_kernel_includes')
		let g:linux_kernel_includes=["arch/arm/include/", "arch/arm/mach-imx/include/", "include", "security/selinux/include/"]
	endif

	set path=.
	for item in g:linux_kernel_includes
		execute "set path+=" . item
	endfor
endfunction

function! s:configure_ft_c_h()
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 textwidth=80 noexpandtab

	setlocal cindent
	setlocal grepprg     =grep\ -nH\ $*

	setlocal completeopt =longest,menu

	" Some C formatting settings
	" setlocal comments& comments-=s1:/* comments^=s0:/*
	setlocal cino+=c4,C4,l1,:0,

	call s:configure_linux_kernel_path()

	" Review a function in a preview window.
	noremap		<silent>;			:ptag <C-R>=expand("<cword>")<CR><CR>
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on python file
" ------------------------------------------------------------------------------
"
function! s:configure_ft_py()
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 noexpandtab

	let g:pydoc_cmd      ='/usr/bin/pydoc2.7'
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on Java file
" ------------------------------------------------------------------------------
"
function! s:configure_ft_java()
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 expandtab
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Some settings on all files
" ------------------------------------------------------------------------------
"
function! s:configure_ft_all()
	" Putting the cursor at the same position before last exit.
	if line("'\"") > 0 && line ("'\"") <= line("$")
		exe "normal g'\""
	endif

	" Maybe the following instruction will be used in future.
	" autocmd Filetype * if &ft!="python"|put your code here|endif

	if &ft != "nerdtree" && &ft != "tagbar"  && &ft != "qf"
		" g[bB] in command mode switch to the next/prev. buffer
		noremap <buffer> gb				:bnext<cr>
		noremap <buffer> gB				:bprev<cr>
		noremap <buffer> <c-pagedown>	:bnext<cr>
		noremap <buffer> <c-pageup>		:bprev<cr>
	endif
endfunction
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Custom GUI
" ------------------------------------------------------------------------------
"
function! s:toggle_quickfix()
	for i in range(1, winnr('$'))
		let win = winbufnr(i)

		if getbufvar(win, '&buftype') == 'quickfix'
			cclose
			return
		endif
	endfor

	copen
endfunction

function! s:configure_gui()
	set mouse		=a
	set guitablabel	=%t

	command!	TQ			call s:toggle_quickfix()
	noremap		<F4>		:TQ<CR>

	set guifont=Inconsolata\ 11
	"set guifont=Liberation\ Mono\ 10
	"set guifont=DejaVu\ Sans\ Mono\ 10
	"set guifont=Monospace\ 10
	"set guifont=Droid\ Sans\ Mono\ 10
	"set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
	"set guifont=Courier\ New\ 11
	"set guifont=Andale\ Mono\ Normal\ 10
endfunction
" ------------------------------------------------------------------------------



" ------------------------------------------------------------------------------
" The main process of VIM initialization
" ------------------------------------------------------------------------------
"
call s:configure_plugins_manager()
call s:configure_base_settings()
call s:configure_file_encoding()
call s:configure_global_shortkey()

if has("autocmd")
	" set a default filetype if vim couldn't detect this file filetype.
	autocmd BufReadPost		*			if &filetype == "" | setlocal ft=text | endif

	autocmd FileType		c,h			call s:configure_ft_c_h()

	autocmd FileType		python		call s:configure_ft_py()
	autocmd FileType		java		call s:configure_ft_java()

	autocmd FileType		make		setlocal isk+=-
	autocmd FileType		dts			setlocal isk+=-

	autocmd FileType		*			call s:configure_ft_all()

	autocmd FileType		qf			set nowrap
	autocmd FileType		qf			wincmd J

	autocmd BufRead			*.txt		set tw=80

	" If you prefer the Omni-Completion tip window to close when a selection is
	" made, these lines close it on movement in insert mode or when leaving
	" insert mode
	autocmd CursorMovedI	*			if pumvisible() == 0|pclose|endif
	autocmd InsertLeave		*			if pumvisible() == 0|pclose|endif
endif
"注释，20190918wihoog"
" if has("gui_running")
call s:configure_gui()
"let g:formatdef_my_cpp = ''astyle --style=linux''
"let g:formatters_cpp = ['my_cpp']
"au BufWrite * :Autoformat
"noremap<F7> :Autoformat<CR>
map <F9> :call Cscope_fun()<CR><CR>
map <F7> :call FormartSrc()<CR><CR>
"map <F12> :vs
"cscope fun
func Cscope_fun()
	if has("cscope")
		"	set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
		" check cscope for definition of a symbol before checking ctags:
		" set to 1 if you want the reverse search order.
		"	csto’的值决定了|:cstag|执行查找的顺序。假如’csto’被设置为0，那么cscope数据将会被优先查找，
		"	假如cscope没有返回匹配项，然后才会查找tag文件。反之，则查找顺序相反。默认值是0，例如：
		set csto=1
		"	set cst
		"	set nocst
		set nocsverb
		"	set cspc=0
		"	set tags=tags;
		"	set autochdir	
		"	set tag=tag_file_path
		" add any cscope database in current directory
		if filereadable("cscope.out")
			cs reset
			cs add cscope.out
			" else add the database pointed to by environment variable
		else
			let cmd='find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.java" > cscope.files'
			let let=system(cmd)
			let cmd='cscope -Rbkq -i cscope.files '
			let let=system(cmd)
			"*.cpp,*.h,*.c
			cs reset
			cs add cscope.out
			"	let cmd='ctags -R'
			"	let let=system(cmd)
			"	set csverb
			"	cs reset
			"	let cmd='cscope  -Rbkq'
			"	let res=system(cmd)

		endif

		" show msg when any other cscope db added
		set cscopeverbose

	endif

	"ctags

		if filereadable("tags")
		"	let cmd='find ./  -type f -mmin -0.2 > ctsgs_newfile'
		"	let let=system(cmd)
		"	if(let)
				call AutoTags() 
		"	endif


		else
			call AutoTags() 


		endif

endfunc

"定义FormartSrc()
func FormartSrc()
	exec "w"
	if &filetype == 'c'
		exec "!astyle --style=linux -p -H -f -U -T -K -N -L -m0 -M80 -n %"
	elseif &filetype == 'cpp' || &filetype == 'hpp'
		exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
	elseif &filetype == 'perl'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'py'||&filetype == 'python'
		exec "r !autopep8 -i --aggressive %"
	elseif &filetype == 'java'
		exec "!astyle --style=java --suffix=none %"
	elseif &filetype == 'jsp'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'xml'
		exec "!astyle --style=gnu --suffix=none %"
	else
		exec "normal gg=G"
		return
	endif
	exec "e! %"
endfunc
"结束定义FormartSrc

"colorscheme space_vim_theme
"endif
"
" ------------------------------------------------------------------------------
"set background=dark
function! DelTagOfFile(file)
	let fullpath = a:file
	let cwd = getcwd()
	let tagfilename = cwd . "/tags"
	let f = substitute(fullpath, cwd . "/", "", "")
	let f = escape(f, './')
	let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
	let resp = system(cmd)
endfunction

function! AutoTags()
	let f = expand("%:p")
	let cwd = getcwd()
	let tagfilename = cwd . "/tags"
	let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+    iaS --extra=+q ' . '"' . f . '"'
	call DelTagOfFile(f)
	let resp = system(cmd)
endfunction
"autocmd BufWritePost *.cpp,*.h,*.c call AutoTags() 



set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存
set confirm             " 在处理未保存或只读文件的时候，弹出确认
set wildmenu             " vim自身命名行模式智能补全
"set completeopt-=preview " 补全时不显示窗口，只显示补全列表


set nocompatible         " 设置不兼容原始vi模式
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
set noeb                 " 关闭错误的提示
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set t_Co=256             " 开启256色支持
set cmdheight=1          " 设置命令行的高度
set showcmd              " select模式下显示选中的行数
set ruler                " 总是显示光标位置
set laststatus=2         " 总是显示状态栏
"set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set cscopequickfix=s-,c-,d-,i-,t-,e-   "否使用 quickfix 窗口来显示 cscope 结果 "
"filetype plugin indent on

"set completeopt=longest,menu
set showmatch

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],

let g:rbpt_max = 15
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"//end rbpt_colorpairs
"
"
"
"vim:set ts=4 sw=4 filetype=vim:
