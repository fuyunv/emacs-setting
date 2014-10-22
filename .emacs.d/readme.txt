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