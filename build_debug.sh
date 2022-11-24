cd build
meson configure -Dsteamworks_path="" -Dsteam_appid="" -Dhide_console=false
ninja
mv mkxp-z.exe Game.exe
start .