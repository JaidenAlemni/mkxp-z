cd build
meson configure -Dsteamworks_path="" -Dsteam_appid="" -Dhide_console=true
ninja
mv mkxp-z.exe Game.exe
start .