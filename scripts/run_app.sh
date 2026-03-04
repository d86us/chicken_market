#!/bin/bash

# Run Flutter app on Android device and launch scrcpy
# This script should ALWAYS be used to run the app - never run flutter run directly

set -e

echo "Checking for Android device..."
ANDROID_DEVICE=$(flutter devices 2>/dev/null | grep -i "samsung" | head -1 | awk '{print $1}')
if [ -z "$ANDROID_DEVICE" ]; then
    # Fallback: just get the first android device
    ANDROID_DEVICE=$(flutter devices 2>/dev/null | grep "android-arm" | head -1 | awk '{print $1}')
fi
if [ -z "$ANDROID_DEVICE" ]; then
    echo "No Android device found!"; exit 1;
fi
echo "Found device: $ANDROID_DEVICE"

SCRCPY_RUNNING=$(pgrep -f "scrcpy" || true)

if [ -n "$SCRCPY_RUNNING" ]; then
    echo "scrcpy is already running - bringing window to front..."
    osascript -e 'tell application "System Events" to set frontmost of process "scrcpy" to true' 2>/dev/null || \
    osascript -e 'tell application "Terminal" to activate' 2>/dev/null || true
else
    echo "Starting scrcpy in background..."
    scrcpy --window-title="Chicken Market" &
    sleep 1
fi

echo "Installing and running app on Android device..."
nohup flutter run -d "$ANDROID_DEVICE" > /tmp/flutter_run.log 2>&1 &
echo "App started in background. View logs with: tail -f /tmp/flutter_run.log"
