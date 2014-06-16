# OBS
 **I haven't updated this in a while and I can no longer condone using this project on your computer. I will remove this message when I get it up to date (probably in relation with the next OS X release)**
# /OBS

# Nice OS X Settings

## What is this?

ask_osx_dotfile.sh is an amalgamation of two dotfiles with nice settings for OS X (great for fresh installs!).
All I've done is **wrap everything in if-statements** so you can choose which settings you wish to use.
The basis is [Mathias Bynens excellent .osx dotfile](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)

**Please Note: This is not an exact mirror of all the settings in these dotfiles. This is merely a manual version for the things which would seem to be applicable to most computers.**

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

Please check out [Mathias dotfiles repo](https://github.com/mathiasbynens/dotfiles) for more dotfiles goodness.

## License &/or Disclaimer

**Use at your own risk! This will run sudo commands on your computer!**

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
