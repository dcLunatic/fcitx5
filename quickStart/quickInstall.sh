targetProgram=fcitx5
requiredVersion=5.0.19

coreFile=libFcitx5Core.so.$requiredVersion
classicuiFile=libclassicui.so

if [ `whoami` != "root" ]; then
    echo "请以root身份执行"
    exit 1
fi

if ! type $targetProgram >/dev/null 2>&1; then
    echo "未安装$targetProgram"
    exit 2
fi

if [ `$targetProgram -v` != "$requiredVersion" ]; then
    echo "版本错误, required($requiredVersion), accepted(`$targetProgram -v`)"
    exit 3
fi

echo ">> backup file..."
mv /usr/lib/$coreFile /usr/lib/$coreFile.bak
mv /usr/lib/$targetProgram/$classicuiFile /usr/lib/$targetProgram/$classicuiFile.bak

echo ">> replace file..."
cp $coreFile /usr/lib/$coreFile
cp $classicuiFile /usr/lib/$targetProgram/$classicuiFile

echo ">> restart $targetProgram"
$targetProgram -r -d > /dev/null 2>&1

echo "Done."