==========FROM:http://blog.163.com/madahah@126/blog/static/1704992252010920930392/
==========base mode
window：other-window，windmove-down，windmove-up，windmove-left，windmove-right。
buffer：buffer-menu，next-buffer，previous-buffer

find-file，默认为C-x C-f，如果文件不存在则创建。

beginning-of-buffer：buffer的开始，M-<或C-home
end-of-buffer：buffer的最后，M->或C-end
beginning-of-line：line的开始，C-a
end-of-line ：line的最后，C-e
next-line：将point向下移动一行，C-n
previous-line ：将point向上移动一行，C-p
forward-char：将point向前移动一个字符 ，C-f
forward-line：将point向前移动一个单词 ，M-f
backward-char：将point向后移动一个字符， C-b
backward-line：将point向后移动一个单词， M-b
search-forward：将point移动到前一个匹配的内容上， C-s
search-backward：将point移动到后一个匹配的内容上， C-r

==========cc-mode
(setq c-default-style 
	  '((java-mode . "java") 
		(awk-mode . "awk") 
		(other . "linux")))
这里C code styles为linux。如果你不喜欢这些styles，也可以通过修改一些变量来更改某些设置。
例如默认的tab键是两个空格，但是似乎很多人用4个空格，所以可以用下面设置来更改
(setq-default indent-tabs-mode  nil)
(setq tab-width 4
      c-basic-offset 4)

有人说，别的编辑器都不用按TAB就能定位到下一个块的位置，emacs 当然也会，只不过不是enter而已，
而是C-j。还有几个格式化代码的命令经常用到

C-M-q 格式化这一对括号中的代码，注意，光标一定要置于左括号上。
C-c C-q 格式化一个函数。
untabify将tab替换成空格。这个不知是不是cc-mode的命令。

第二个要说的就是移动功能，前面已经说过一些通用的移动命令，这里说的是 C 里面用到的特殊的命令。
C-M-a 跳到函数的开始。
C-M-e 跳到函数的结尾。
M-a 跳到上一个语句。
M-e 跳到下一个语句。
C-M-b 当光标置于｝的后面时，跳转到与之匹配的｛。
C-M-f  当光标置于｛的后面时，跳转到与之匹配的｝。
C-c C-u 跳转到上一个条件编译的条件处。
c-down-conditional跳转到下一个条件编译的条件处，可根据自己情况绑定快捷键。

现在要说的是注释代码块，标记你要注释的代码，C-c C-c，这样就把这段代码注掉了，
想恢复怎么办，M-x uncomment-region，如果经常用的话可以把它绑定到相应快捷键。

CC-mode还有很一些功能，现在工作用不到，也就没有去研究。但是就这样结束好像有点短了，

有时候大堆代码在那，看着很不方便，把它暂时隐藏，等到要看它时再显示，代码折叠很好用，
其实不止一个mode能有这样的功能，这里说的是hs-minor-mode和hide-ifdef-mode，
在.emacs文件中加入,
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-hook 'hide-ifdef-mode)

这样在菜单栏就能看到两个菜单，主要命令有
hs-hide-block 隐藏光标所在代码块，C-c @ C-h
hs-show-block 显示光标所在代码块
hs-hide-all  隐藏所有代码块 C-c @ C-M-h
hs-show-all 显示所有代码块 C-c @ C-M-s
hide-ifdefs 隐藏所有ifdef块
hide-ifdef-block  隐藏光标所在的ifdef块 C-c @ C-d
show-ifdefs 显示所有ifdef块 C-c @ s
show-ifdef-block 显示光标所在的ifdef块 C-c @ C-d

还有很多其它的功能来帮助我们高效的编写、浏览代码，当然还需要借助其它mode，比如etages，cscope.

==========cedet
cedet是一个工具集合，为我们提供了一些更使用的功能，它包括下面几个工具。
EDE－项目管理
Semantic－自动补全和代码间跳转
SRecode － 模板，通过定义一些模板，可以快速的插入一段代码
Cogre － C++类生成UML 图
Speedbar － 显示目录树，函数列表等

虽然这里有很多工具，但是我用的最多的就一个Semantic，另外Speedbar也可以快速的查看一些内容，
其它的很少用到，所以也不是很清楚。

cedet提供了几个不同的功能组合,
semantic-load-enable-minimun-features
semantic-load-enable-code-helpers
semantic-load-enable-guady-code-helpers 
semantic-load-enable-excessive-code-helpers 
semantic-load-enable-semantic-debugging-helpers 
用户可以根据自己的需求来使用。我一般使用semantic-load-enable-code-helpers。
在.emacs中加入
(load-file "/cedet-*/common/cedet.el")
(require 'cedet)
(semantic-load-enable-code-helpers)

设置include位置
为了能使semantic在补全时找到函数和结构体，要添加一些头文件的位置，包括系统的和用户自定义的
(require 'semantic-ia)
(require 'semantic-gcc)
(setq-mode-local c-mode semanticdb-find-default-throttle
         '(project unloaded system recursive))
(require 'semanticdb)
(defconst cedet-user-include-dirs
  (list ".." "../include" "../.." "../../.." "../../include" "../../../inlcude" "../inc" 
        "../.." "../../include" "../../inc" ".
        "/usr/include/sys" "/usr/include/bits"   ))
(setq cedet-sys-include-dirs (list
                              "/usr/include"))
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

代码补全命令
semantic提供了下面几个补全命令
senator-complete-symbol
senator-completion-menu-popup
semantic-ia-complete-symbol
semantic-ia-complete-symbol-menu 
semantic-complete-self-insert
在.emacs中添加下面代码
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
; (defun my-c-mode-cedet-hook ()
; (local-set-key "." 'semantic-complete-self-insert)
; (local-set-key ">" 'semantic-complete-self-insert))
;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

这样你就可以用C-enter来补全了。注意，我这里后面的my-c-mode-cedet-hook这些我已经注释掉的，不喜欢用它，
当我想补全结构体成员是，无非是多按个C-enter，另外这个补全还是比较智能的，比如你输入int n = p->时，
它会只补全p中int类型的成员。这样在一个很大的结构体中是很实用的。还有就是函数补全，输入一个函数命的几个字母，
然后C-enter，这时就会列出相关的函数。
虽然semantic是比较智能的，但是有时也会很傻，比如有时结构体成员补全不正确，有的系统函数找不到等，
如果出现这种情况，我一般是先打开相对应的头文件，输入前面几个字符，然后用M-/来补全，暂时没有什么其它好办法

再说说其它功能，当然前提是配置好include路径。

代码跳转，最常用的是semantic-ia-fast-jump，主要用来跳转到定义，可以是变量，也可以是函数。
那么要想跳回来呢？当然有办法了，那就是semantic-mrub-switch-tags,这里要注意，当在一个函数中跳转到变量的定义的时候，
用semantic-mrub-switch-tags跳回时，它默认的不是原来的位置，要自己指定跳回的函数。
另外还有semantic-complete-jump-local和semantic-complete-jump，
两个的区别是前一个跳转到在当前文件，而后者可以在其它的文件中搜索匹配的定义。
大多是工程都是把H文件和C文件分开，H文件只定义，C文件里写实现，semantic-analyze-proto-impl-toggle可以在函数的声明和
实现之间跳转

查找引用，semantic-symref，这个命令可以让你查看某个函数在什么地方被调用了，它会打开一个buffer，然后列出相关调用的地方，
将光标移动到某个函数上，回车就能跳到相应位置。关于引用，后面会介绍一个更好用的工具cscope。

重命名本地变量，这是刚刚发现的，呵呵，semantic-symref-rename-local-variable，把光标放在变量上，
M-x semantic-symref-rename-local-variable，这时那个变量会出现下划线，删掉原来的变量，重新输入。
这样所有这个函数里的变量都会改变。

代码折叠，前面已经说过用hs-minor-mode来实现代码折叠，cedet也提供了这样的功能，一个是semantic提供的，
另一个是senator提供的，第一个比较适合习惯鼠标操作的人，
在.emacs添加下面代码
(require 'semantic-tag-folding nil 'noerror )
(global-semantic-tag-folding-mode 1 )
这样当再打开C文件时，就会在每个函数的前面出现一个小三角，可以通过点击它来折叠代码。
senator-fold-tag  折叠代码
senator-fold-tag-toggle  展开代码
这两个似乎都只能折叠函数，对于{}这样的块不支持，所以要想折叠任意代码块，还是用hs-minor-mode比较好。

下面是一些关于cedet的相关资料。
http://emacser.com/cedet.htm
http://cedet.sourceforge.net/
http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html



-------------------------------------------------------------------------------------------
本文转自：http://www.devfront.com:8080/?q=node/115

Emacs快捷键的总结

文件操作

C-x C-f 打开文件,出现提示时输入/username@host:filepath可编辑FTP文件
C-x C-v 打开一个文件，取代当前缓冲区
C-x C-s 保存文件
C-x C-w 存为新文件
C-x i 插入文件
C-x C-q 切换为只读或者读写模式
C-x C-c 退出Emacs

编辑操作

C-f 前进一个字符
C-b 后退一个字符
M-f 前进一个字
M-b 后退一个字
C-a 移到行首
C-e 移到行尾
M-a 移到句首
M-e 移到句尾
C-p 后退一行
C-n 前进一行
M-x goto-line 跳到指定行
C-v 向下翻页
M-v 向上翻页
M-< 缓冲区头部
M-> 缓冲区尾部

C-M-f 向前匹配括号
C-M-b 向后匹配括号

C-l 当前行居中

M-n or C-u n 重复操作随后的命令n次
C-u 重复操作随后的命令4次
C-u C-u 重复操作随后的命令8次
C-x ESC ESC 执行历史命令记录，M-p选择上一条命令，M-n选择下一条命令

C-d 删除一个字符
M-d 删除一个字
C-k 删除一行
M-k 删除一句
C-w 删除标记区域

C-y 粘贴删除的内容

注意：C-y可以粘贴连续C-k删除的内容；先按C-y，然后按M-y可以选择粘贴被删除的内容

C-@ 标记开始区域
C-x h 标记所有文字
C-x C-x 交换光标位置和区域标记区开头
M-w 复制标记区域

C-_ or C-x u 撤消操作

执行SHELL命令

M-x shell 打开SHELL
M-! 执行SHELL命令 (shell-command)
M-1 M-! 执行SHELL命令,命令输出插入光标位置,不打开新输出窗口
M-| 针对某一特定区域执行命令(shell-command-on-region), 比如 C-x h M-|uuencode

窗口操作

C-x 0 关闭本窗口
C-x 1 只留下一个窗口
C-x 2 垂直均分窗口
C-x 3 水平均分窗口
C-x o 切换到别的窗口
C-x s 保存所有窗口的缓冲
C-x b 选择当前窗口的缓冲区
C-x ^ 纵向扩大窗口
C-x } 横向扩大窗口

缓冲区列表操作

C-x C-b 打开缓冲区列表
d or k 标记为删除
~ 标记为未修改状态
% 标记为只读
s 保存缓冲
u 取消标记
x 执行标记的操作

f 在当前窗口打开该缓冲区
o 在其他窗口打开该缓冲区

目录操作

C-x d 打开目录模式
s 按日期/文件名排序显示
v 阅读光标所在的文件
q 退出阅读的文件
d 标记为删除
x 执行标记
D 马上删除当前文件
C 拷贝当前文件
R 重名名当前文件
+ 新建文件夹
Z 压缩文件
! 对光标所在的文件执行SHELL命令
g 刷新显示
i 在当前缓冲区的末尾插入子目录的内容

[n]m 标记光标所在的文件，如果指定n，则从光标所在的文件起后n个文件被标记
[n]u 取消当前光标标记的文件，n的含义同上
t 反向标记文件
%-m 正则标记

q 退出目录模式

说明：在目录模式中，如果输入!，在命令行中包含*或者?，有特殊的含义。*匹配当前光标所在的文件和所有标记的文件，?分别在每一个标记的文件上执行该命令。

程序编译

M-x compile 执行编译操作
M-x gdb GDB排错
M-x dbx DBX排错
M-x xdb XDB排错
M-x sdb SDB排错

搜索模式

C-s key 向前搜索
C-s 查找下一个
ENTER 停止搜索
C-r key 反向搜索
C-s C-w 以光标所在位置的字为关键字搜索
C-s C-s 重复上次搜索
C-r C-r 重复上次反向搜索
C-s ENTER C-w 进入单词搜索模式
C-r ENTER C-w 进入反向单词搜索模式
M-x replace-string ENTER search-string ENTER 替换
M-% search-string ENTER replace-string ENTER 交互替换
C-r 在进入查找/替换模式后，该命令进入迭代编辑模式
C-M-x 退出迭代编辑模式，返回到查找/替换模式
C-M-s 向前正则搜索
C-M-r 向后正则搜索
C-M-% 正则交互替换

SHELL模式

C-c C-c 相当于Bash下的C-c
C-c C-z 相当于Bash下的C-z
C-c C-d 相当于Bash下的C-d
M-p 执行前一条命令
C-n 执行下一条命令
C-c C-o 删除最后一条命令产生的输出
C-c C-r 屏幕滚动到最后一条命令输出的开头
C-c C-e 屏幕滚动到最后一套命令输出的结尾
C-c C-p 查看前一条命令的输出
C-c C-n 查看后一条命令的输出

打印资料

M-x print-buffer 先使用pr,然后使用lpr
M-x lpr-buffer 直接使用lpr
M-x print-region
M-x lpr-region

收发邮件

M-x mail 发送邮件, C-c C-s 发送,C-c C-c 发送并退出
M-x rmail 接受邮件

参考资料：

O'Reilly, Emacs 3rd Edition

Linux/BSD
Marchday's blog
Add new comment
Comments

Tue, 2007-01-23 02:41 — Marchday
一些FAQ
Q:如何使用gdb设置断点的时侯让emacs高亮源代码那一行？

A:设断点是 C-x space
-------------------------------
ecb可以到这里下载：http://ecb.sourceforge.net/
-------------------------------
Q:编辑c++文件时，现在M-;用的是//形式的注释
我想用/**/的
怎么办 ?

A:[1]M-x c-mode
[2](defun my-c-comment ()
(interactive)
(insert "/* */"
(backward-char 3))
(global-unset-key "\M-;"
(global-set-key "\M-;" 'my-c-comment)
-------------------------------
Q:Emacs 和 XEmacs 的区别?

A:http://www.xemacs.org/About/XEmacsVsGNUemacs.html
-------------------------------
最新emacs for windows的下载地址
http://ftp.gnu.org/gnu/windows/emacs/
-------------------------------
Q:想在打开文件的时候就 auto indent ，不要老按 TAB 键，.emacs 怎样写?

A:
(global-set-key "\C-m" 'reindent-then-newline-and-indent)
或者这样：
(add-hook 'c-mode-common-hook
(lambda ()
(define-key c-mode-map
"\C-m" 'reindent-then-newline-and-indent)))
-------------------------------
Q:我的是21.3.1，ecb2.27。我的ecb不支持鼠标双击阿，不知道大家的ecb是什么版本的，能不能支持鼠标双击，或者用快捷键切换到ecb窗口?

A:快捷键有啊。好些是C-c , g m 就调到methods窗口。g d 就goto directorey 窗口，
说实话，我觉得ecb窗口跳转很不方便。不如speedbar，只要设置一下speedbar-get-focus的快捷键，这个是可以 toggle的。而且speedbar上该有的都有，成员函数列表都在上面。按 f 就跳到 file mode，基本ecb有的它都有了。
-------------------------------
Q:ecb有没有windows版本的?

这些东西没有什么平台一说，都是elisp语言，用emacs byte-compile一下就可以了。但是我认为ecb的跳转很麻烦。
-------------------------------
Q:我在emscs中打开了几个文件进行编辑，我要关闭缓存中某一个文件应当怎样操作？

A:1C-x k
A2:c-x c-b 在要关闭的buffer的那行 d, 在x就ok了
-------------------------------
Q:我想在打开文件的时候就 auto indent

A:你可以C-x h 选中所有内容，然后C-M \ 就可以了。
-------------------------------
Q:不想要emacs de工具栏,怎样让它不显示?

A1:options 里面 show/hide ，关掉 toolbar，然后 options 再选择 一下 save options ，下次就再也不出来了。
A2:也可把(tool-bar-mode nil)加到.emacs中
-------------------------------
Q:emacs的正确发音?

A:一马克思?一卖壳丝？
-------------------------------
Q:在打开文件时如果文件名中有空格,请问我怎么输入这个空格
发表：

A:在空格前加"\"
-------------------------------
Q:果我不小心按错了键，跑到文件头或者文件尾了，怎么能快速回到刚才光标所在的位置？

A:C-u C-@
-------------------------------
Q:编译某行出错时，我想快速把光标定位到此行，我应该如何做？

A:可以使用C-x ' 。注意是 `，也就是F1 下面的那个，不是单引号。
实在不行，M-x next-error 也可以。
-------------------------------
Q:怎样让emacs中复制的 东西可以在系统中使用?好象emacs不和系统使用相同的粘贴板

A1:C-y 不行吗？要不就直接在emacs中干吧。M-x shell
A2：
M-x gdb
file xxx.c
run
-------------------------------
Q：emacs中怎样才能运行.c的程序？我只会编译.c的程序，不会运行。每次只能退出emacs，在shell下运行

A：不用退出啊、直接按C-x C-z 就会进入shell，你然后shell下运行，然后fg回来就可以了。或者你M-x shell，直接在emacs中运行也可以的。
-------------------------------
Q：我的emacs缩进是2两个空格。怎样设置为8个呢？

A：(setq c-basic-offset 8）
-------------------------------
Q：终端下使用Ctrl+x 2/3可以上下左右分屏，默认的是一半对一半。请问可以调整两个窗口的大小吗？

A：M-x enlarge-window （c-x ^)
M-x shrink-window
你可以把他们绑定到你喜欢得键上。
-------------------------------
Q：请问在emacs里怎么显示日期？

A：(setq display-time-day-and-date t)
(display-time)
-------------------------------
Q：请问C-s时候如何粘贴要搜的内容?

A1：移动光标到你要查找的东西上（不用粘贴）， C-s C-w
A2：M-y
-------------------------------
Q：不产生备份文件

A：(setq make-backup-files nil)
-------------------------------
Q：请问在emacs中怎么删除从光标位置到行首？

A1：Meta - C-k
A2：Ctrl-u 0 Ctrl-k
-------------------------------
Q：我在xp中用GNU Emacs 21.3.1...
当按pagedown多次后...emacs就会失去响应...请问怎么回事?

A：因为你设置了scroll-margin
-------------------------------
Q：写程序时经常会遇到一个很长的代码块（用'{}'包起来的）
有什么办法能把一个代码块缩起来，需要的时候再展开

A：
M-x hs-minor-mode
* C-c @ ESC C-s show all
* C-c @ ESC C-h hide all
* C-c @ C-s show block
* C-c @ C-h hide block
* C-c @ C-c toggle hide/show

我重新定义了show block和hide block的键
(add-hook 'c-mode-hook 'hs-minor-mode)
C-c bh show block
C-c bs hide block
-------------------------------
Q：每次都语法高亮显示：(global-font-lock-mode t) 加入你的.emacs文件。

-------------------------------
Q：装上ecb，有个color-themes可以调整配色方案，ecb-change-layout可以改变ecb窗口布局
-------------------------------
Q：emacs中，想复制一段文字，或复制一行，应该怎样做
我现在是先cut，（C-SPACE ..... C-w），然后在paste（C-y）一下,有没有更好的操作

A:M-w
-------------------------------
Q:请问谁知道在编译程序的时候,怎样让光标从当前buffer自动跳到正在编译程序的buffer,然后光标一直保持在这个buffer的底部?我现在每一次编译程序后,都是C-x o,然后再C-Shift >;到最底看结果,挺麻烦的,不知道这样一个..........

A:
;; S-F9 调用 compile 并设置编译命令
;; F9 则保存所有文件并编译(无提示)
(defun du/onekey-compile ()
"Save buffers and start compile"
(interactive)
(save-some-buffers t)
(switch-to-buffer-other-window "*compilation*"
(compile compile-command)
; (other-window 1)
)
(global-set-key [S-f9] '(lambda ()
(interactive)
(switch-to-buffer-other-window "*compilation*"
(compile)
; (other-window 1)
))
(global-set-key [f9] 'du/onekey-compile)
-------------------------------
Q:如何显示ASCII表?

A:http://www.cpqd.com.br/~vinicius/emacs/ascii.el
-------------------------------
Q:怎样使得 emacs 里面， 选取的区域为矩形，而不是一行行全选上了？

A:Ctrl+空格建，然后把光标移到下几行
ctrl+x r k
ctrl+x r y
-------------------------------
Q：我的tab键被用来做格式化功能了，那我怎样才能键入一个真正的tab呢？

A：C-q TAB
-------------------------------
Q：如何重新从磁盘里load当前编辑的文件？因为有时候文件可能被别人改了，所以才有这个需求

A：M-x revert-buffer
-------------------------------
Q：一般我的emacs启动后都是去/usr/share/emacs/site-lisp下面找扩展程序
请问这个目录是否可以指定？
因为我现在要把我的emacs搬家到另一个没有root权限的机器
所以我不能去改他们的/usr/share/emacs/site-lisp，只能在自己的目录干活

A：
在.emacs最前头加一条(setq load-path (cons "/home/bleem1998/.emacs-site-lisp/" load-path))
然后把所有的扩展包都丢在"/home/bleem1998/.emacs-site-lisp/"就可以了
-------------------------------
Q：请问在emacs中如何设置字体和背景的颜色？

A：设置背景颜色 M-x set-background-color
可以写到 .emacs里打开emacs就设置：
(set-face-background 'default "azure") ; azure或者别的颜色
如果只想在window模式下设置背景，终端下不需要，就加上判断：
(if window-system
(set-face-background 'default "azure"))
-------------------------------
Q：文本方式下，emacs的有些热键被终端的热键代替了。比如：ctrl-h在终端中是退格键，而emacs中是在线帮助，结果在emacs中按ctrl-h就变成了删除光标前面的字符。这种情况还很多。要怎样设置才能用emacs的热键替代终端的..........

A：
(global-set-key "\C-h" 'backward-delete-char-untabify)
(global-set-key [DEL] 'delete-char)
-------------------------------
Q：我用emacs，屏幕显示大约是80行，25列，开多个窗格时，每个窗格显示不了多少字符。
能不能让屏幕显示更多的行和列？

A：不是很清楚你的意思。是emacs窗口不够大？还是emacs编辑时自动换行的列太小？
如果是后者 (setq default-fill-column 85)
如果是前者，可以在开emacs时选择大点的尺寸，或者动动鼠标拉大点 -_-
(if window-system
(setq default-frame-alist
(append
'((top . 0) (left . 0) (width . 120) (height . 60))
default-frame-alist)))
-------------------------------
Q：fcitx的热建 Ctrol－Space 和 emacs 的 mark-set 重了， 我每次在 emacs里面输入中文，就不能mark-set了，怎么办啊？

A：Mark可以用 C-@
-------------------------------
Q：怎样把所有的/r/n都替换成/n，或者怎样删除所有的/r

A：除了使用一些工具软件（如 dos2unix、tr 等）对文件直接进行转换外，在 Emacs 中有如下两种方法：

[1]、替换法
使用 Emacs 的替换命令 replace-string 将 \r 替换为空以达到删除的目的：
M-x replace-string RETURN # 执行 replace-string 命令
Replace string: C-q C-m RETURN # 替换字符串。C-q C-m 为 \r 字符的输入形式
with: RETURN # 替换为空字符串

[2]、解码法
如果 Emacs 对文件的自动解码失败，可指定文件的解码方式打开文件。对于本问题来说，指定一种可行的 dos 解码方式即可（如 chinese-euc-dos），Emacs将会自动进行转换，从而能正确显示Window格式的文本文件的内容。在启动 Emacs 之后：
C-x C-m c chinese-euc-dos RETURN # 指定编码方式为chinese-euc-dos
C-x C-f your_file_name RETURN # 打开文件
-------------------------------
Q：>;>; 1.有什么可设置emacs在选定文本后输入时把选定的文本换掉?

A：M-x pending_delete_mode # 切换到 Delete_Selection 模式
-------------------------------
Q：>;>; 2.如何将一段选定的文字在大小写之间切换??

A：C-x C-l # 转换为小写文字
C-x C-u # 转换为大写文字
-------------------------------
Q：emacs中如何设置显示文件字体的大小？

A：可通过修改 Default face 的 Height 属性来实现（customize-face命令或者在菜单中找修改 face 的一项）。
如果是 XEmacs，有菜单选项可直接更改字体大小。
-------------------------------
Q：请问从其他地方copy到emacs的快接键

A：
拷贝一个文件到一个ｂｕｆｆｅｒ里面用c-x i
拷贝一个buffer到另外一个buffer用c-x c-i
拷贝剪贴板里的用c-y
在ｌｉｎｕｘ力，可以直接用鼠标选定要拷贝的东西，再用鼠标中间的键拷贝到buffer里
-------------------------------
Q：如何让emacs启动后就最大化？

A：
(setq initial-frame-alist '((top . 0) (left . 0) (width . 97) (height . 49)))
数值自己修改吧。

来源：http://www.chinaunix.net/jh/23/702156.html
