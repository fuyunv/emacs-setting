;; Emacs快捷键
;;; 文件操作
C-x C-f ;打开文件,出现提示时输入/username@host:filepath可编辑FTP文件
C-x C-v ;打开一个文件,取代当前缓冲区
C-x C-s ;保存文件
C-x C-w ;存为新文件
C-x i ;插入文件
C-x C-q ;切换为只读或者读写模式
C-x C-c ;退出Emacs

;;;; 编辑操作
C-l ;当前行居中
C-f ;前进一个字符
C-b ;后退一个字符
M-f ;前进一个字
M-b ;后退一个字
C-a ;移到行首
C-e ;移到行尾
M-a ;移到句首
M-e ;移到句尾
C-p ;后退一行
C-n ;前进一行
M-x ;goto-line 跳到指定行
C-v ;向下翻页
M-v ;向上翻页
M-< ;缓冲区头部
M-> ;缓冲区尾部
C-M-f ;向前匹配括号
C-M-b ;向后匹配括号
M-n or C-u n ;重复操作随后的命令n次
C-u ;重复操作随后的命令4次
C-u C-u ;重复操作随后的命令8次
C-x ESC ESC ;执行历史命令记录
M-p ;选择上一条命令
M-n ;选择下一条命令
C-d ;删除一个字符
M-d ;删除一个字
C-k ;删除一行
M-k ;删除一句
C-w ;删除标记区域
C-y ;粘贴删除的内容,先按C-y,然后按M-y可以选择粘贴被删除的内容
C-@ ;标记开始区域
C-x h ;标记所有文字
C-x C-x ;交换光标位置和区域标记区开头
M-w ;复制标记区域
C-_ or C-x u ;撤消操作

;;;; 执行SHELL命令
M-x ;shell 打开SHELL
M-! ;执行SHELL命令 (shell-command)
M-1 ;M-! 执行SHELL命令,命令输出插入光标位置,不打开新输出窗口
M-| ;针对某一特定区域执行命令(shell-command-on-region), 比如 C-x h M-|uuencode

;;;; 窗口操作
C-x 0 ;关闭本窗口
C-x 1 ;只留下一个窗口
C-x 2 ;垂直均分窗口
C-x 3 ;水平均分窗口
C-x o ;切换到别的窗口
C-x s ;保存所有窗口的缓冲
C-x b ;选择当前窗口的缓冲区
C-x ^ ;纵向扩大窗口
C-x } ;横向扩大窗口

;;;; 缓冲区列表操作
C-x C-b ;打开缓冲区列表
d or k ;标记为删除
~ ;标记为未修改状态
% ;标记为只读
s ;保存缓冲
u ;取消标记
f ;在当前窗口打开该缓冲区
o ;在其他窗口打开该缓冲区
x ;执行标记的操作

;;;; 目录操作
C-x d ;打开目录模式
s ;按日期/文件名排序显示
v ;阅读光标所在的文件
q ;退出阅读的文件
d ;标记为删除
x ;执行标记
D ;马上删除当前文件
C ;拷贝当前文件
R ;重名名当前文件
+ ;新建文件夹
Z ;压缩文件
! ;对光标所在的文件执行SHELL命令
g ;刷新显示
i ;在当前缓冲区的末尾插入子目录的内容
[n]m ;标记光标所在的文件,如果指定n,则从光标所在的文件起后n个文件被标记
[n]u ;取消当前光标标记的文件,n的含义同上
t ;反向标记文件
%-m ;正则标记
q ;退出目录模式
;;说明:
;;	在目录模式中,如果输入!,在命令行中包含*或者?,有特殊的含义.*匹配当前光标所在的;;文件和所有标记的文件,?分别在每一个标记的文件上执行该命令.

;;;; 程序编译
M-x compile ;执行编译操作
M-x gdb ;GDB排错
M-x dbx ;DBX排错
M-x xdb ;XDB排错
M-x sdb ;SDB排错

;;;; 搜索模式
C-s ;key 向前搜索
C-s ;查找下一个
ENTER ;停止搜索
C-r key ;反向搜索
C-s C-w ;以光标所在位置的字为关键字搜索
C-s C-s ;重复上次搜索
C-r C-r ;重复上次反向搜索
C-s ENTER C-w ;进入单词搜索模式
C-r ENTER C-w ;进入反向单词搜索模式
M-x replace-string ENTER search-string ENTER ;替换
M-% search-string ENTER replace-string ENTER ;交互替换
C-r ;在进入查找/替换模式后,该命令进入迭代编辑模式
C-M-x ;退出迭代编辑模式,返回到查找/替换模式
C-M-s ;向前正则搜索
C-M-r ;向后正则搜索
C-M-% ;正则交互替换

;;;; SHELL模式
C-c C-c ;相当于Bash下的C-c
C-c C-z ;相当于Bash下的C-z
C-c C-d ;相当于Bash下的C-d
M-p ;执行前一条命令
C-n ;执行下一条命令
C-c C-o ;删除最后一条命令产生的输出
C-c C-r ;屏幕滚动到最后一条命令输出的开头
C-c C-e ;屏幕滚动到最后一套命令输出的结尾
C-c C-p ;查看前一条命令的输出
C-c C-n ;查看后一条命令的输出

;;;; format command
C-M-q ;格式化这一对括号中的代码,注意,光标一定要置于左括号上.
C-c C-q ;格式化一个函数.
C-M-a ;跳到函数的开始.
C-M-e ;跳到函数的结尾.
M-a ;跳到上一个语句.
M-e ;跳到下一个语句.
C-M-b ;当光标置于｝的后面时,跳转到与之匹配的｛.
C-M-f ;当光标置于｛的后面时,跳转到与之匹配的｝.
C-c C-u ;跳转到上一个条件编译的条件处.
c-down-conditional ;跳转到下一个条件编译的条件处,可根据自己情况绑定快捷键.

;;;; 注释代码块
C-c C-c ;标记你要注释的代码,注释代码块
M-x uncomment-region ;恢复注释前状态

C-x k ;关闭缓存中某一个文件
C-x c-b ;在要关闭的buffer的那行 d, 在x就ok了
C-x h ;选中所有内容,然后C-M \ auto indent
C-u C-@ ;快速回到刚才光标所在的位置
M-k kill ;current point to buffer end
M - C-k ;删除从光标位置到行首方法1
C-u 0 Ctrl-k ;删除从光标位置到行首方法2

;;;;代码块收缩
M-x hs-minor-mode
C-c @ ESC C-s ;show all
C-c @ ESC C-h ;hide all
C-c @ C-s ;show block
C-c @ C-h ;hide block
C-c @ C-c ;toggle hide/show
C-c bh ;show block
C-c bs ;hide block

;;;; 矩形编辑
C-x space ;rectangle mode
Ctrl+Space ;然后把光标移到下几行
ctrl+x r k ;kill
ctrl+x r y ;yake

;;;; 调整窗口高度,宽度,适合高度,均分高度
;;;;C-x ^ | M+x shrink-window
C-x { 
C-x }
C-x -
C-x +

;;;; 打印资料
M-x print-buffer ;先使用pr,然后使用lpr
M-x lpr-buffer ;直接使用lpr
M-x print-region
M-x lpr-region

;;;; 收发邮件
M-x mail ;发送邮件, C-c C-s 发送,C-c C-c 发送并退出
M-x rmail ;接受邮件

;;;; code注释
M-;

;;;; misc
C-x C-m c chinese-euc-dos RETURN ; 指定编码方式为chinese-euc-dos
C-x C-l ; 将一段选定的文字转换为小写文字
C-x C-u ; 将一段选定的文字转换为大写文字
c-x i ;  拷贝一个文件到一个buffer
c-x c-i ; 拷贝一个buffer到另外一个buffer
C-q C-m ; \r 字符的输入形式
C-q TAB ;tab键被用来做格式化功能了,真正键入一个tab

;; binding
(global-set-key "\C-h" 'backward-delete-char-untabify)
(global-set-key [DEL] 'delete-char)

;; command
revert-buffer ; 从磁盘里load当前编辑的文件
window ; other-window,windmove-down,windmove-up,windmove-left,windmove-right
buffer ; buffer-menu,next-buffer,previous-buffer
find-file ; default bind[C-x C-f], 
beginning-of-buffer ; the start of buffer, M-< or C-home
end-of-buffer ; the end of buffer, M-> or C-end
beginning-of-line ; line start, C-a
end-of-line ; line end, C-e
next-line ; move point next line, C-n
previous-line ; up line, C-p
forward-char ; forward a char, C-f
forward-line ; forward a line, M-f
backward-char ; backward a char, C-b
backward-line ; backward a line, M-b
search-forward ; search forward a match string, C-s
search-backward ; C-r
untabify ; replace tab use space
hs-hide-block ;  隐藏光标所在代码块,C-c @ C-h
hs-show-block ;显示光标所在代码块
hs-hide-all ; 隐藏所有代码块 C-c @ C-M-h
hs-show-all ; 显示所有代码块 C-c @ C-M-s
hide-ifdefs ; 隐藏所有ifdef块
hide-ifdef-block ; 隐藏光标所在的ifdef块 C-c @ C-d
show-ifdefs ; 显示所有ifdef块 C-c @ s
show-ifdef-block ; 显示光标所在的ifdef块 C-c @ C-d

;; setting
(tool-bar-mode nil) ; 关掉 toolbar
(setq display-time-day-and-date t) ; 显示日期
(display-time)
(setq c-basic-offset 8) ; 缩进设定
(global-font-lock-mode t) ; 语法高亮显示
(setq make-backup-files nil) ; 不产生备份文件

(defun my-c-comment ()
	   (interactive)
	   (insert "/* */"
	   (backward-char 3))
(global-unset-key "\M-;")
(global-set-key "\M-;" 'my-c-comment)

;;;; emacs最大化启动
(setq
 initial-frame-alist
 '((top . 0) (left . 0) (width . 97) (height . 49)))

;;;; S-F9 调用 compile 并设置编译命令
;;;; F9 则保存所有文件并编译(无提示)
(defun onekey-compile ()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window
   "*compilation*"
   (compile compile-command)
   (other-window 1)))
(global-set-key [S-f9]
                '(lambda ()
                   (interactive)
                   (switch-to-buffer-other-window
                    "*compilation*"
                    (compile)
                    (other-window 1))))
(global-set-key [f9] 'onekey-compile)

;; cedet
cedet is a toolkit
EDE - 项目管理
Semantic - 自动补全和代码间跳转
SRecode - 模板,通过定义一些模板,可以快速的插入一段代码
Cogre - C++类生成UML 图
Speedbar - 显示目录树,函数列表等

;; cedet提供了几个不同的功能组合,
semantic-load-enable-minimun-features
semantic-load-enable-code-helpers
semantic-load-enable-guady-code-helpers 
semantic-load-enable-excessive-code-helpers 
semantic-load-enable-semantic-debugging-helpers 
一般使用semantic-load-enable-code-helpers.
(require 'cedet)
(semantic-load-enable-code-helpers)

;; semantic在补全时找到函数和结构体,添加一些头文件的位置
(require 'semantic-ia)
(require 'semantic-gcc)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(require 'semanticdb)
(defconst cedet-user-include-dirs
  (list "./include" "/usr/include"))
(setq cedet-sys-include-dirs
      (list "/usr/include"))
(let (include-dirs cedet-user-include-dirs)
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

;; 代码补全命令
semantic提供了下面几个补全命令
senator-complete-symbol
senator-completion-menu-popup
semantic-ia-complete-symbol
semantic-ia-complete-symbol-menu 
semantic-complete-self-insert
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(defun my-c-mode-cedet-hook ()
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)
前提是配置好include路径.代码跳转semantic-ia-fast-jump,跳回来semantic-mrub-switch-tags,
用semantic-mrub-switch-tags跳回时,它默认的不是原来的位置
semantic-complete-jump-local 跳转到当前文件
semantic-complete-jump 可以在其它的文件中搜索匹配的定义
semantic-analyze-proto-impl-toggle可以在函数的声明和实现之间跳转查找引用
semantic-symref可以查看某个函数在什么地方被调用,它会打开一个buffer,然后列出相关调用的地方,将光标移动到某个函数上,回车就能跳到相应位置
M-x semantic-symref-rename-local-variable把光标放在变量上,这时那个变量会出现下划线,删掉原来的变量,重新输入.这样所有这个函数里的变量都会改变.

;; 代码折叠
用hs-minor-mode可以实现代码折叠,cedet也提供了这样的功能,一个是semantic提供的，另一个是senator提供的,第一个比较适合习惯鼠标操作的人
(require 'semantic-tag-folding nil 'noerror )
(global-semantic-tag-folding-mode 1 )
senator-fold-tag  折叠代码
senator-fold-tag-toggle  展开代码

;; cscope
;;;; find -type f | grep -E '\.[chS]$' > cscope.files'
;;;; cscope -b -k

;; urls
http://emacser.com/cedet.htm
http://cedet.sourceforge.net/
http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
