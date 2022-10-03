# fcitx5自动隐藏输入框
> 更合适的修改应该放到fcitx5-rime里，移步至[相关内容](https://github.com/dcLunatic/fcitx5-rime)

## 介绍

用fcitx5去挂接小鹤音形后，确实满足linux日常下基本输入。习惯了windows下隐藏候选框(如果有`时则自动显示)，但fcitx5并没有提供类似的功能。

所以，考虑在源码的基础上做一些小改动来实现这个功能，配合小鹤音形一起使用，输入会更加的流畅。


### VersionInfo
- fcitx5: 5.0.19
- cmake: 3.23.2
- make: GNU Make 4.3
- gcc: 12.1.0
- other...

## 效果
![](assets/1.gif)

## 快速开始
> 要求对应的fcitx5版本为5.0.19，其他版本可能出现在前后不兼容问题（不过可以试试看）
```sh
git clone https://github.com/dcLunatic/fcitx5.git
cd fcitx5/quickStart
sudo sh quickInstall.sh
```

## 其他
- 如果是其他的fcitx5版本，类似的改源码然后编译即可。
- 简单的算做是个引入，如果有其他魔改fcitx5的想法，也可以简单参考参考。
