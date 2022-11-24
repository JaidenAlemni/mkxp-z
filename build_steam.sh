STEAM="$PWD/steam/sdk"
APPID="1504930"
cd build
meson configure -Dsteamworks_path="$STEAM" -Dsteam_appid="$APPID" -Dhide_console=true
ninja
start .