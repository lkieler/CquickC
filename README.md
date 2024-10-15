# Overview

CquickC is a *very simple* bash script to compile c Programms *just a little faste*.
(This Script is by no means intended to be used in any Production/Professional enviroments.)

# Usage

Once install you should be able to simply execute `c` in any directory. The script should automatically find any .c files and compile and run them. If multpile files are found it will provide a list to choose from.

If you want to change the name of the command you simply have to rename the file before installing. If you already installed the script or if you used the Manual method you can also just rename it in `/usr/local/bin/`. (might require sudo)

# Installation

## Using the Install Script

1. Clone the Repo and cd into it
2. Run the `install.sh` file

## Alternative: Manually move the Files

1. Clone the Repo
2. Move the file(s) from the bin folder into `$PATH`
3. Make the file(s) executable using `chmod +x`
