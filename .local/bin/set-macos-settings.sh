#!/usr/bin/env bash

set -e

# ============================================================
# macOS defaults
# ============================================================

# Quit System Preferences
osascript -e 'tell application "System Preferences" to quit' 2> /dev/null || true

# ============================================================
# Language and appearance
# ============================================================

# Preferred languages
defaults write NSGlobalDomain AppleLanguages -array 'en-GB' 'pl-PL'

# Light appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string Light

# Disable Reduce Motion
defaults write com.apple.universalaccess reduceMotion -bool false

# ============================================================
# Menu bar clock
# ============================================================

defaults write com.apple.menuextra.clock DateFormat -string 'HH:mm'
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false
defaults write com.apple.menuextra.clock ShowDate -bool false

# ============================================================
# Dock
# ============================================================

# Position and auto-hide
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Size and magnification
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock magnification -bool false

# Behaviour
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string scale

# Mission Control animation
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock expose-group-by-app -bool true

# Restart Dock
killall Dock

# ============================================================
# Window management
# ============================================================

# Disable margins around tiled windows
defaults write com.apple.WindowManager TileWindowsHaveMargins -bool false

# ============================================================
# Finder
# ============================================================

# Show hidden files and all filename extensions
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show external drives on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Show path and status bars
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Display full POSIX path in window titles
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# List view by default
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

# Sort folders first
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# File extension and Trash warnings
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Finder behaviour
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder ShowRecentTags -bool false

# Sidebar and table sizing
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write com.apple.finder SidebarWidth -int 175

# Restart Finder
killall Finder

# ============================================================
# File dialogs
# ============================================================

# Expand Save panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand Print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# ============================================================
# Mouse and trackpad
# ============================================================

# Reset mouse tracking and scrolling preferences to defaults
defaults delete -g com.apple.mouse.scaling 2> /dev/null || true
defaults delete com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode 2> /dev/null || true
defaults delete -g com.apple.scrollwheel.scaling 2> /dev/null || true
defaults delete -g com.apple.swipescrolldirection 2> /dev/null || true

# Trackpad tracking speed
defaults write -g com.apple.trackpad.scaling -float 1.5

# ============================================================
# Display
# ============================================================

# Disable automatic brightness adjustment
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor \
    "Automatic Display Enabled" -bool false

# ============================================================
# Control Centre
# ============================================================

# Hide Bluetooth
defaults write com.apple.controlcenter \
    "NSStatusItem Visible Bluetooth" -bool false

# Hide AirDrop
defaults write com.apple.controlcenter \
    "NSStatusItem Visible AirDrop" -bool false

# Hide Now Playing
defaults write com.apple.controlcenter \
    "NSStatusItem Visible NowPlaying" -bool false

# Restart Control Centre
killall ControlCenter

# ============================================================
# Safari and privacy
# ============================================================

# Disable search suggestions
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Disable quarantine metadata for downloaded applications
# WARNING: Reduces macOS security protections.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ============================================================
# General system behaviour
# ============================================================

# Always open documents in tabs
defaults write NSGlobalDomain AppleWindowTabbingMode -string always

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Avoid .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ============================================================
# TextEdit
# ============================================================

# Plain text by default
defaults write com.apple.TextEdit RichText -int 0

# UTF-8 encoding for reading and writing plain text
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# ============================================================
# Printing
# ============================================================

# Quit the printer app after print jobs finish
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# ============================================================
# Window management and desktop animations
# ============================================================

# Disable margins around tiled windows
defaults write com.apple.WindowManager TileWindowsHaveMargins -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0

# Reduce delay when moving windows to screen edges
defaults write com.apple.dock workspaces-edge-delay -float 0.1

# Restart Dock to apply changes
killall Dock

# ============================================================
# Refresh system UI
# ============================================================

killall SystemUIServer

# ============================================================
# Summary
# ============================================================

echo ""
echo "macOS preferences applied:"
echo "  - Language: English (UK), Polish"
echo "  - Appearance: Light mode"
echo "  - Menu bar clock: HH:mm, no date or weekday"
echo "  - Dock: left side, auto-hide enabled"
echo "  - Dock hover delay: 0 ms"
echo "  - Dock show/hide animation: 0 ms"
echo "  - Dock icon size: 36 px, magnification disabled"
echo "  - Recent applications in Dock: disabled"
echo "  - Mission Control animation duration: 0 ms"
echo "  - Window tiling margins: disabled"
echo "  - Workspace edge delay: 100 ms"
echo "  - Finder: hidden files and extensions visible"
echo "  - Finder: path bar, status bar and list view enabled"
echo "  - Finder: folders sorted first"
echo "  - File dialogs: expanded by default"
echo "  - TextEdit: plain text and UTF-8"
echo "  - Control Centre: Bluetooth, AirDrop and Now Playing hidden"
echo "  - Safari: search suggestions disabled"
echo "  - Software updates: daily schedule"
echo ""
echo "Note: Desktop swipe animations may still be present."
echo "All requested preference commands have been executed."
