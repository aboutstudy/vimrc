set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"关闭菜单栏
set guioptions-=m
set guioptions-=T
au GUIEnter * simalt ~x "启动GVim时自动窗口最大化
"F2开启关闭GVim菜单和工具栏
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

"中文乱码问题
"set encoding=utf-8
"set fileencodings=utf-8,chinese,latin-1
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"解决菜单乱码
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
"解决consle输出乱码
"language messages zh_CN.utf-8

"根据图形界面和字符界面设置不同背景
if(has("gui_running"))
	colo koehler  
else
	colo darkblue
endif

set number
set nowrap
set cursorline		"光标所在行高亮
set backupdir=$vim/temp/
set directory=$vim/temp/
set shiftwidth=4
set tabstop=4
set softtabstop=4
set extandtab
set guifont=Courier_New:h11:cANSI

"自动重新加载_vimrc文件
autocmd! BufWritePost _vimrc source %

"Ctags&Taglist配置
"F4快捷键打开关闭TlistToggle功能,打开后折叠类定义、变量定义
map <F4> :TlistToggle<CR> j-jj-	
set tags=tags;
set autochdir
filetype plugin on
let Tlist_Ctags_Cmd = "ctags\.exe"
let Tlist_Show_One_File = 1 "不同时显示多个文件的Tag，只显示当前文件
let Tlist_Exit_OnlyWindow = 1 "如果Taglist窗口是最后一个窗口时退出VIM
let Tlist_Use_Right_Window = 1 "让Taglist窗口在右侧显示
let Tlist_GainFocus_On_ToggleOpen = 1	"设置当执行TlistToggle时，定位当前光标到Tlist窗口

"PHP编辑定义规则
"================================================================================
"代码自动提示，C+x C+o
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"================================================================================

"Normal模式下代码缩进
"nmap <tab> V>
"nmap <s-tab> V<

"代码跳转，ctl + \ 分切当前标签页显示函数定义
map <C-\> :exec("stag ".expand("<cword>"))<CR>  

"InsertOnly模式下键盘映射
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
"inoremap { {<CR><CR>}<Esc>ki<tab>
inoremap { {}<Esc>i
inoremap ' ''<Esc>i
"编辑模式句尾插入分号结束语句
inoremap <C-e> <Esc>$a;<Esc>hi
"编辑模式数组键入数组健后自动补上"=>"符号和该键结尾的","符号，最后定位到键值输入光标位置，默认录入一个变量标识符"$"
inoremap <C-o> <Esc>la<Space>=><Space>,<Esc>i$
"语句块大括号插入
inoremap <C-b> <Esc>o{<CR>}<Esc>O<Backspace>	

"NERDTree插件功能配置
"F2快捷键打开关闭NERDTree功能
map <F3> :NERDTreeToggle JX<CR>	
map <C-Tab> :tabnext<CR>
map <S-Tab> :tabp<CR>
map <S-Esc> :tabc<CR>
map <S-T> :tabnew<CR><F3>
map <S-D> :tabnew<CR>:NERDTreeToggle Desktop<CR> 

"NERDTree Settings{
		let NERDTreeWinPos ="left"						"将NERDTree的窗口设置在gvim窗口的左边
		let NERDTreeShowBookmarks=1						"当打开NERDTree窗口时，自动显示Bookmarks
		let NERDTreeBookmarksFile=$vim."\\.NERDTreeBookmarks"	"设置书签文件为VIM根目录
"}

"打开VIM无参数时，直接打开NERDTree BookMark 进入工作目录
"autocmd vimenter * if !argc() | NERDTree JX | endif


