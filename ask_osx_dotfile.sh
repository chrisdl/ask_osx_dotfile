#!/usr/bin/env bash

# ask_osx_dotfile.sh https://github.com/chrisdl
# Last updated: ~Dec 2013

# If you find a bug don't hesistate to contact me and/or suggest a fix for it.

# These settings originally came from
#  - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#  - https://github.com/paulirish/dotfiles/blob/master/.osx
# But are definitely tailed to my taste in settings as well.

# Ask for the administrator password upfront

echo "This dotfile will ask to change your settings (that is why it needs your admin password)."
echo "It DOES NOT TOGGLE settings, i.e. it is a one way street. Thus if you are unsure"
echo "about a setting, please select NO so that it skips it."
echo "Please type your password to continue..."

sudo -v

# Keep-alive: update existing `sudo` time stamp until `.ask_osx_dotfile` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

############################################
# Section 1: General UI/UX                 #
############################################

read -p "[SECTION] Do you wish to change General UI/UX settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Menu bar: disable transparency? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false
    fi

    # Create folder if it does not already exist
    if [ -f '/System/Library/CoreServices/Menu Extras/hidden' ]; then
        sudo mkdir /System/Library/CoreServices/Menu\ Extras/hidden
    fi

    read -p "Menu bar: hide Time Machine icon? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

        # This works for most users
        defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.* dontAutoLoad -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"

        # This will always work (it seems)
        sudo mv /System/Library/CoreServices/Menu\ Extras/TimeMachine.menu /System/Library/CoreServices/Menu\ Extras/hidden/
    fi

    read -p "Menu bar: hide Volume icon? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.* dontAutoLoad -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
        sudo mv /System/Library/CoreServices/Menu\ Extras/Volume.menu /System/Library/CoreServices/Menu\ Extras/hidden/
    fi

    read -p "Menu bar: hide User icon? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.* dontAutoLoad -array-add "/System/Library/CoreServices/Menu Extras/User.menu"
        sudo mv /System/Library/CoreServices/Menu\ Extras/User.menu /System/Library/CoreServices/Menu\ Extras/hidden/
    fi

    read -p "Menu bar: hide Bluetooth icon? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.* dontAutoLoad -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
        sudo mv /System/Library/CoreServices/Menu\ Extras/Bluetooth.menu /System/Library/CoreServices/Menu\ Extras/hidden/
    fi

    # You can manually edit the plist file in ByHost with xcode.
    # If you want your icons back.
    # Also you can move the menu bar extras back in CoreServices (from the hidden directory.)

    read -p "Scrollbars: Edit scrollbars behaviour? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        read -p "Possible values: WhenScrolling, Automatic or Always? (value or n)> " ans
        if [ "$ans" != "n" ]; then
            defaults write NSGlobalDomain AppleShowScrollBars -string "$ans"
        fi
    fi

    read -p "Disable smooth scrolling (Only do this if you’re on an older Mac that messes up the animation) (y/n)> " ans
        defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

    read -p "Disable opening and closing window animations? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
    fi

    read -p "Increase window resize speed for Cocoa applications? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
    fi

    read -p "Expand save panel by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    fi

    read -p "Expand print panel by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    fi

    read -p "Save to disk (not to iCloud) by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    fi

    read -p "Automatically quit printer app once the print jobs complete? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
    fi

    read -p "Disable the “Are you sure you want to open this application?” dialog? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.LaunchServices LSQuarantine -bool false
    fi

    read -p "Display ASCII control characters using caret notation in standard text views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
        defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
    fi

    read -p "Disable Resume system-wide? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
    fi

    read -p "Disable automatic termination of inactive apps? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
    fi

    read -p "Set Help Viewer windows to non-floating mode? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.helpviewer DevMode -bool true
    fi

    read -p "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
    fi

    read -p "Restart automatically if the computer freezes? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        systemsetup -setrestartfreeze on
    fi

    read -p "Never go into computer sleep mode? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        systemsetup -setcomputersleep Off > /dev/null
    fi

    read -p "Check for software updates daily, not just once per week? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Trackpad, mouse, keyboard, Bluetooth     #
# accessories, and input                   #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Trackpad, mouse, keyboard, Bluetooth accessories and input settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p  "Trackpad: enable tap to click for this user and for the login screen? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
        defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
        defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    fi

    read -p  "Trackpad: map bottom right corner to right-click? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
        defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
        defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
    fi

    read -p  "Trackpad: swipe between pages with three fingers? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
        defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
        defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1
    fi

    read -p  "Disable “natural” (Lion-style) scrolling? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
    fi

    read -p "Disable the sound effects on boot (y = off, n = on)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        sudo nvram SystemAudioVolume=" "
    else
        nvram -d SystemAudioVolume
    fi

    read -p  "Increase sound quality for Bluetooth headphones/headsets? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
    fi

    read -p  "mute all sounds, incl volume change feedback? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write "com.apple.sound.beep.feedback" -int 0
        defaults write "com.apple.systemsound" "com.apple.sound.uiaudio.enabled" -int 0
    fi

    read -p  "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    fi

    read -p  "Enable access for assistive devices? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
        sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
        # TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
        #sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'
    fi

    read -p  "Use scroll gesture with the Ctrl (^) modifier key to zoom? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
        defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
    fi
    read -p  "Follow the keyboard focus while zoomed in? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
    fi

    read -p  "Disable press-and-hold for keys in favor of key repeat? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    fi

    read -p  "Set a blazingly fast keyboard repeat rate? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain KeyRepeat -int 0
    fi

    read -p  "Automatically illuminate built-in MacBook keyboard in low light? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.BezelServices kDim -bool true
    fi

    read -p  "Turn off keyboard illumination when computer is not used for 5 minutes? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.BezelServices kDimTime -int 300
    fi

    # Set language and text formats
    # Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
    # `Inches`, and `true` with `false`.
    # defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
    # defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
    # defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    read -p "Set to metric units? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleMetricUnits -bool true
    fi

    read -p  "Disable auto-correct? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Screen and Screenshot                    #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Screen and Screenshot settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Require password immediately after sleep or screen saver begins? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

        # Broken?
        defaults write com.apple.screensaver askForPassword -int 1
        defaults write com.apple.screensaver askForPasswordDelay -int 0
    fi

    read -p "Save screenshots to the desktop? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.screencapture location -string "$HOME/Desktop"
    fi

    echo "Please view/edit ask_osx_dotfile.sh to choose another format manually if you wish"
    read -p "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.screencapture type -string "png"
    fi

    read -p "Disable shadow in screenshots? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.screencapture disable-shadow -bool true
    fi

    read -p "Enable subpixel font rendering on non-Apple LCDs? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleFontSmoothing -int 2
    fi

    read -p "Enable HiDPI display modes (requires restart)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Finder                                   #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Finder settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Finder: disable window animations and Get Info animations? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder DisableAllAnimations -bool true
    fi

    read -p "Show icons for hard drives, servers, and removable media on the desktop? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
        defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
        defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
        defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    fi

    read -p "Finder: show hidden files by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder AppleShowAllFiles -bool true
    fi

    read -p "Finder: show all filename extensions? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    fi

    read -p "Finder: show status bar? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder ShowStatusBar -bool true
    fi

    read -p "Finder: allow text selection in Quick Look? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder QLEnableTextSelection -bool true
    fi

    read -p "Display full POSIX path as Finder window title? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    fi

    read -p "When performing a search, search the current folder by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    fi

    read -p "Disable the warning when changing a file extension? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    fi

    read -p "Avoid creating .DS_Store files on network volumes? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    fi

    read -p "Disable disk image verification? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.frameworks.diskimages skip-verify -bool true
        defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
        defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
    fi

    read -p "Automatically open a new Finder window when a volume is mounted? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
        defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
        defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    fi

    read -p "Show item info below icons on the desktop and in other icon views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    fi

    read -p "Enable snap-to-grid for icons on the desktop and in other icon views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    fi

    read -p "Increase grid spacing for icons on the desktop and in other icon views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    fi

    read -p "Increase the size of icons on the desktop and in other icon views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
        /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    fi

    read -p "set a default view (Nlsv is recommended) type in Finder.app to default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        CORRECT="false"
        while [ "$CORRECT" != "true" ]
        do
            read -p "type the four-letter code for a view mode: 'icnv', 'clmv', 'Flwv' 'Nlsv' (type n to cancel)> " ans
            if [ "$ans" != "n" ]; then
                if [ "$ans" == "icnv" ] || [ "$ans" == "clmv" ] || [ "$ans" == "Flwv" ] || [ "$ans" == "Nlsv" ]; then
                    defaults write com.apple.finder FXPreferredViewStyle -string "$ans"
                    CORRECT="true"
                else
                    echo "please write one of:  'n', 'icnv', 'clmv', 'Flwv' 'Nlsv'> "
                fi
            else
                CORRECT="true"
            fi
        done
    fi

    read -p "Disable the warning before emptying the Trash? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder WarnOnEmptyTrash -bool false
    fi

    read -p "Empty Trash securely by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.finder EmptyTrashSecurely -bool true
    fi

    read -p "Enable AirDrop over Ethernet and on unsupported Macs running Lion? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
    fi

    read -p "Show the ~/Library folder? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        chflags nohidden ~/Library
    fi

    read -p "Remove Dropbox’s green checkmark icons in Finder? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        file=/Applications/Dropbox.app/Contents/Resources/check.icns
        [ -e "$file" ] && mv -f "$file" "$file.bak"
        unset file
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Dock, Dashboard & hot corners            #
############################################

echo ""
read -p "[SECTION] Do you wish to modify dock & hot corner settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Enable highlight hover effect for the grid view of a stack (Dock)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock mouse-over-hilite-stack -bool true
    fi

    read -p "Disable Dashboard? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dashboard mcx-disabled -bool true
    fi

    read -p "Set the icon size of Dock items to 36 pixels? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock tilesize -int 36
    fi

    read -p "Enable spring loading for all Dock items? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
    fi

    read -p "Show indicator lights for open applications in the Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock show-process-indicators -bool true
    fi

    echo "Wipe all (default) app icons from the Dock:"
    echo "--------------------"
    echo "This is only really useful when setting up a new Mac, or if you don’t use"
    echo "the Dock to launch apps."
    echo "--------------------"
    read -p "Wipe all (default) app icons from the Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock persistent-apps -array
    fi

    read -p "Don’t animate opening applications from the Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock launchanim -bool false
    fi

    read -p "Speed up Mission Control animations? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock expose-animation-duration -float 0.1
    fi

    read -p "Don’t group windows by application in Mission Control? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock expose-group-by-app -bool false
    fi

    read -p "Don’t show Dashboard as a Space? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock dashboard-in-overlay -bool true
    fi

    read -p "Don’t show Dashboard at all? (y/n)>" ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dashboard mcx-disabled -bool true
    fi

    read -p "Remove the auto-hiding Dock delay? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Dock autohide-delay -float 0
    fi

    read -p "Remove the animation when hiding/showing the Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock autohide-time-modifier -float 0
    fi

    read -p "Enable the 2D Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock no-glass -bool true
    fi

    read -p "Automatically hide and show the Dock? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock autohide -bool true
    fi

    read -p "Make Dock icons of hidden applications translucent? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock showhidden -bool true
    fi

    read -p "Reset Launchpad? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete
    fi

    read -p "Add iOS Simulator to Launchpad? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app
    fi

    read -p "Add a spacer to the left side of the Dock (where the applications are)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
    fi

    read -p "Add a spacer to the right side of the Dock (where the Trash is)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
    fi

    read -p "[MINI-SECTION] Setup Hot Corners? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        read -p "Top left screen corner -> Mission Control? (y/n)> " ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
            defaults write com.apple.dock wvous-tl-corner -int 2
            defaults write com.apple.dock wvous-tl-modifier -int 0
        fi

        read -p "Top right screen corner -> Desktop? (y/n)> " ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
            defaults write com.apple.dock wvous-tr-corner -int 4
            defaults write com.apple.dock wvous-tr-modifier -int 0
        fi

        read -p "Bottom left screen corner -> Start screen saver? (y/n)> " ans
        if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
            defaults write com.apple.dock wvous-bl-corner -int 5
            defaults write com.apple.dock wvous-bl-modifier -int 0
        fi
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Safari & WebKit                          #
############################################

echo ""
read -p "[SECTION] Do you wish to change Safari and WebKit settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Set Safari’s home page to 'about:blank' for faster loading? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari HomePage -string "about:blank"
    fi

    read -p "Prevent Safari from opening 'safe' files automatically after downloading? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
    fi

    read -p "Allow hitting the Backspace key to go to the previous page in history? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
    fi

    read -p "Hide Safari’s bookmarks bar by default? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari ShowFavoritesBar -bool false
    fi

    read -p "Disable Safari’s thumbnail cache for History and Top Sites? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
    fi

    read -p "Enable Safari’s debug menu? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    fi

    read -p "Make Safari’s search banners default to Contains instead of Starts With? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
    fi

    read -p "Remove useless icons from Safari’s bookmarks bar? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari ProxiesInBookmarksBar "()"
    fi

    read -p "Enable the Develop menu and the Web Inspector in Safari? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.Safari IncludeDevelopMenu -bool true
        defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
        defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    fi

    read -p "Add a context menu item for showing the Web Inspector in web views? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Mail                                     #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Mail.app settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Disable send and reply animations in Mail.app? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.mail DisableReplyAnimations -bool true
        defaults write com.apple.mail DisableSendAnimations -bool true
    fi

    read -p "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
    fi

    read -p "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Terminal                                 #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Terminal settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Only use UTF-8 in Terminal.app? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.terminal StringEncodings -array 4
    fi

    echo "Info: hover over a terminal and start typing in it without clicking first"
    read -p "Enable “focus follows mouse” for Terminal.app and all X11 apps? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.terminal FocusFollowsMouse -bool true
        defaults write org.x.X11 wm_ffm -bool true
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Time Machine                             #
############################################

echo ""
read -p "Do you wish to modify Time Machine settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Prevent Time Machine from prompting to use new hard drives as backup volume? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    fi

    read -p "Disable local Time Machine backups? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        hash tmutil &> /dev/null && sudo tmutil disablelocal
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Spotlight                                #
############################################

echo ""
echo "-- SPOTLIGHT --"
read -p "Only spotlight index applications and directories (will get buggy if we disable applications)? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
    defaults write com.apple.spotlight orderedItems -array \
    '{"enabled" = 1;"name" = "APPLICATIONS";}' \
    '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
    '{"enabled" = 1;"name" = "DIRECTORIES";}' \
    '{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "DOCUMENTS";}' \
    '{"enabled" = 0;"name" = "MESSAGES";}' \
    '{"enabled" = 0;"name" = "CONTACT";}' \
    '{"enabled" = 0;"name" = "EVENT_TODO";}' \
    '{"enabled" = 0;"name" = "IMAGES";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
    '{"enabled" = 0;"name" = "MUSIC";}' \
    '{"enabled" = 0;"name" = "MOVIES";}' \
    '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
    '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 0;"name" = "SOURCE";}'

    # Load new settings before rebuilding the index
    killall mds
    # Make sure indexing is enabled for the main volume
    sudo mdutil -i on /
    # Rebuild the index from scratch
    sudo mdutil -E /
fi

############################################
# Address Book, Dashboard, iCal, TextEdit  #
# and Disk Utility                         #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Address Book, Dashboard, iCal, TextEdit and Disk Utility settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Enable the debug menu in Address Book? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.addressbook ABShowDebugMenu -bool true
    fi

    read -p "Enable Dashboard dev mode (allows keeping widgets on the desktop)? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.dashboard devmode -bool true
    fi

    read -p "Use plain text mode for new TextEdit documents? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.TextEdit RichText -int 0
    fi

    read -p "Open and save files as UTF-8 in TextEdit? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.TextEdit PlainTextEncoding -int 4
        defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
    fi

    read -p "Enable the debug menu in Disk Utility? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
        defaults write com.apple.DiskUtility advanced-image-options -bool true
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Mac App Store                            #
############################################

echo ""
read -p "Do you wish to modify Mac App Store settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Enable the WebKit Developer Tools in the Mac App Store? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.appstore WebKitDeveloperExtras -bool true
    fi

    read -p "Enable Debug Menu in the Mac App Store? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.apple.appstore ShowDebugMenu -bool true
    fi
else
    echo "Moving to next section of settings..."
fi

############################################
# Google Chrome & Google Chrome Canary     #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Google Chrome & Google Chrome Canary settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
    read -p "Allow installing user scripts via GitHub, gists or Userscripts.org? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
        defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
    fi
else
    echo "Moving to next section of settings..."
fi

############################################
# Transmission.app                         #
############################################

echo ""
read -p "[SECTION] Do you wish to modify Transmission.app settings? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then

    read -p "Use '~/Documents/Torrents' to store incomplete downloads? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
        defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"
    fi

    read -p "Don’t prompt for confirmation before downloading? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write org.m0k.transmission DownloadAsk -bool false
    fi

    read -p "Trash original torrent files? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
    fi

    read -p "Hide the donate message? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write org.m0k.transmission WarningDonate -bool false
    fi
    read -p "Hide the legal disclaimer? (y/n)> " ans
    if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
        defaults write org.m0k.transmission WarningLegal -bool false
    fi

else
    echo "Moving to next section of settings..."
fi

############################################
# Kill affected applications               #
############################################

read -p "Do you wish to restart all potentially affected applications right now? (y/n)> " ans
if [ "$ans" == "y" ] || [ "$ans" == "Y" ] || [ "$ans" == "Yes" ] || [ "$ans" == "YES" ]; then
    echo "...restarting"
    for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
        "Mail" "Safari" "SystemUIServer" "Terminal" "Transmission" "iCal"; do
        killall "$app" > /dev/null 2>&1
    done
    echo "done."
fi

echo "This is the end of the ask_osx_dotfile.sh."
echo "Note that some of these changes require a full logout/restart to take effect."
echo "Enjoy your improved OS X experience!"
