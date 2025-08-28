#!/bin/bash

DIR=$(dirname "$0")

for app in "$DIR"/*.app; do
    echo "Installing $(basename "$app")..."
    cp -rv "$app" "$HOME"/Applications/
    xattr -dr com.apple.quarantine "/Applications/$(basename "$app")"
done

open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
