cd build
meson configure -Dsteamworks_path="" -Dsteam_appid="" -Dhide_console=false
ninja
mv mkxp-z.exe Game.exe
cp ${MKXPZ_PREFIX}/bin/x64-msvcrt-ruby310.dll $PWD
cp /mingw64/bin/zlib1.dll $PWD
start .