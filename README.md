# fcitx5自动隐藏输入框

## 介绍

用fcitx5去挂接小鹤音形后，确实满足linux日常下基本输入。习惯了windows下隐藏候选框(如果有`时则自动显示)，但fcitx5并没有提供类似的功能。

所以，考虑在源码的基础上做一些小改动来实现这个功能，配合小鹤音形一起使用，输入会更加的流畅。


### VersionInfo
- fcitx5: 5.0.19
- cmake: 3.23.2
- make: GNU Make 4.3
- gcc: 12.1.0
- other...

## 快速开始
> 要求对应的fcitx5版本为5.0.19，其他版本可能出现在前后不兼容问题（不过可以试试看）
```sh
git clone https://github.com/dcLunatic/fcitx5.git
cd fcitx5/quickStart
sudo sh quickInstall.sh
```

## 改动
由于只是一个小功能，所以要魔改的内容并不多。核心改动如下：
```c++
// inputwindow.cpp
std::pair<int, int> InputWindow::update(InputContext *inputContext) {
    // ***
    if(instance->flypyHideMode() && preedit.textLength() && preedit.toString().find("`") == std::string::npos){
        visible_ = false;
        outfile.close();
        return {0, 0};
    }
    // ****
}
```

后续简单的将配置给完善到configtool那边去，可以按需开启及关闭。核心改动如下：
```c++
// globalconfig.cpp
FCITX_CONFIGURATION(
    CustomConfig,
    Option<bool> flypyHideInputPannel{
        this, "flypyHideInputPannel",
        _("auto hide the input pannel flypyly(by '`')"), true};
);

FCITX_CONFIGURATION(GlobalConfig,
                    Option<HotkeyConfig> hotkey{this, "Hotkey", _("Hotkey")};
                    Option<BehaviorConfig> behavior{this, "Behavior",
                                                    _("Behavior")};
                    Option<CustomConfig> customconfig{this, "CustomConfig", _("CustomConfig")};
                                                    );
} // namespace impl

```
> 在`inputwindow.cpp`这里去改，主要是编译后的相关产物只有`libclassicui.so`，其他的基本不变，直接替换原有的库文件即可完成对应的功能。
> `globalconfig.cpp`里边的配置如果有需要做成快捷键切换的也行，编译后产物也只有`libFcitx5Core.so.5.0.19`，也可以直接替换使用。


### 相关文件
- **M**       src/lib/fcitx/globalconfig.cpp
- **M**       src/lib/fcitx/globalconfig.h
- **M**       src/lib/fcitx/instance.cpp
- **M**       src/lib/fcitx/instance.h
- **M**       src/ui/classic/inputwindow.cpp

## 其他
- 如果是其他的fcitx5版本，类似的改源码然后编译即可。
- 简单的算做是个引入，如果有其他魔改fcitx5的想法，也可以简单参考参考。