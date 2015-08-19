#!/bin/bash

set -x

USB_PORT=${1-/dev/ttyUSB0}
UDP_PORT=${2-4000}

# Start in top left
xdotool key Ctrl+Alt+Left
xdotool key Ctrl+Alt+Up

# Open GCS and CAMERA terminals
gnome-terminal -t GCS --working-directory=smaccmpilot-build/smaccmpilot-stm32f4/src/smaccm-comm-client -x bash -c "./gcs.sh $USB_PORT 57600 --verbose"
gnome-terminal -t CAMERA --working-directory=camera_demo -x java -jar SmaccmViewer.jar $UDP_PORT

# Open Firefox for HUD
firefox localhost:8080/hud.html &

sleep 5

# Move camera terminal to workspace 3
xdotool search CAMERA windowactivate key Ctrl+Alt+Shift+Down
sleep 1

# Move GCS terminal to workspace 2
xdotool search GCS windowactivate key Ctrl+Alt+Shift+Right
sleep 1

# Resize video to bottom corner, always on top
xdotool search SMACCMcopter windowactivate key Ctrl+Alt+89
wmctrl -r SMACCMcopter -b add,above
sleep 1

# Clear Ubuntu workspace manager
xdotool key Ctrl+Alt+Left
xdotool key Ctrl+Alt+Up

# Refresh Firefox
sleep 10
xdotool search "Problem loading page" windowactivate key Ctrl+r
xdotool search "SMACCMPilot" windowactivate key Ctrl+r
