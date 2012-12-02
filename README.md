# Nice OS X Settings

## What is this?

ask_osx_dotfile.sh is an amalgamation of two dotfiles with nice settings for OS X (great for fresh installs!).
All I've done is **wrap everything in if-statements** so you can choose which settings you wish to use.
The basis is [Mathias Bynens excellent .osx dotfile](https://github.com/mathiasbynens/dotfiles/blob/master/.osx) and 
[Paul Irishes fork](https://github.com/paulirish/dotfiles/blob/master/.osx) of it.

Please check out [Mathias dotfiles repo](https://github.com/mathiasbynens/dotfiles) and [Pauls fork](https://github.com/paulirish/dotfiles) for more goodness.

## Installation

Just download ask_osx_dotfile.sh manually (or with git if you want to track it) and run it from the terminal (while standing in same directory as the file) like so

Download
```bash
> curl -#L https://github.com/chrisdl/ask_osx_dotfile/master/ask_osx_dotfile.sh
```

or with Git
```bash
> git clone https://github.com/chrisdl/ask_osx_dotfile.git
```

Run
```bash
> sh /path/to/ask_osx_dotfile.sh
```

## Protips

The shell script will first ask you if you want to modify a general app or OS X functionality such as Twitter.app or "Screen". Answering yes to this will not change any settings, it only means you wish to see it's available settings. Answering yes to them will however change your settings.

These settings are a one way street, **answering NO WIll NOT UNDO changes**, it will simply not set them in the first place. This means that if you've already changed a setting previously you **cannot** run the file again, answer no, and the setting will revert.
If you modify a setting which you wish to change back, I would recommend taking a peek inside of the file.

y, Y, yes, Yes and YES = yes. **Everything else = no**

Take a look in the ask_osx_dotfile.sh file, how it works is very straightforward.
