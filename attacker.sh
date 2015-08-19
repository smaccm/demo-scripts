#!/bin/bash

set -x

USB_PORT=/dev/ttyUSB0
UDP_PORT=5000

gnome-terminal -t GCS --working-directory=smaccmpilot-build/smaccmpilot-stm32f4/src/smaccm-comm-client
gnome-terminal -t CAMERA --working-directory=camera_demo -x java -jar SmaccmViewer.jar $UDP_PORT
firefox localhost:8080/hud.html &
gnome-terminal -t SSH -x ssh root@smaccmbox

sleep 3

# Move ssh terminal to workspace 2
xdotool search SSH windowactivate key Ctrl+Alt+Shift+Right
sleep 1

# Move camera terminal to workspace 3
xdotool search CAMERA windowactivate key Ctrl+Alt+Shift+Down
sleep 1

# Move GCS terminal to workspace 4
xdotool search GCS windowactivate key Ctrl+Alt+Shift+Right
sleep 1
xdotool search GCS windowactivate key Ctrl+Alt+Shift+Down
sleep 1

# Resize video to bottom corner, always on top
xdotool search SMACCMcopter windowactivate key Ctrl+Alt+89
wmctrl -r SMACCMcopter -b add,above
sleep 1

# Clear Ubuntu workspace manager
xdotool key Ctrl+Alt+Left
xdotool key Ctrl+Alt+Up
