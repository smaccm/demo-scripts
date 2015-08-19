#!/bin/bash

set -x

USB_PORT=/dev/ttyUSB0
UDP_PORT=5000

gnome-terminal -t GCS --working-directory=smaccmpilot-build/smaccmpilot-stm32f4/src/smaccm-comm-client
gnome-terminal -t CAMERA --working-directory=camera_demo -x java -jar SmaccmViewer.jar $UDP_PORT
firefox localhost:8080/hud.html &
gnome-terminal -t SSH -x ssh root@smaccmbox

sleep 3

# Move ssh terminal to workspace 2, fullscreen
xdotool search SSH windowactivate key Ctrl+Alt+Shift+Right
sleep 1
wmctrl -r SSH -b toggle,maximized_vert,maximized_horz
sleep 1

# Move camera terminal to workspace 3
xdotool search CAMERA windowactivate key Ctrl+Alt+Shift+Down
sleep 1

# Move GCS terminal to workspace 4
xdotool search smaccm-comm-client windowactivate key Ctrl+Alt+Shift+Right
sleep 1
xdotool search smaccm-comm-client windowactivate key Ctrl+Alt+Shift+Down
sleep 1
# Some initial typing gets cut off so we add Returns
xdotool search smaccm-comm-client windowactivate key Return key Return key Return key Return key Return key Ctrl+L type "./gcs.sh /dev/ttySMACCMbox 57600 --verbose"

# Resize video to bottom corner, always on top
xdotool search SMACCMcopter windowactivate key Ctrl+Alt+89
wmctrl -r SMACCMcopter -b add,above
sleep 1

# Clear Ubuntu workspace manager
xdotool key Ctrl+Alt+Left
xdotool key Ctrl+Alt+Right
