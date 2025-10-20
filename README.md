# Media-uploader
A bash and powershell script for both a windows client and a linux server to automatically upload a media file to your plex directory and changes user permissions. Also converts a file to .mp4 for combatibility.

## Prerequisites
Handbrake CLI installed on your windows client

Plex installed and setup on your linux server

## Setup
Install the Converter.ps1 on your windows machine and create a watch folder and a converterd folder. 

Edit the Converter.ps1 script to include the paths to your folders and server credentials in the variable section

Install the FileMove.sh script on your linux server and create an incoming folder in your main user. 

Then run `sudo nano FileMove.sh` and edit the **INCOMING** variable to your incoming folder and **MEDIA_DIR** to your plex media directory

Give the file the permissions by running `sudo chmod +x /home/user/FileMove.sh` of course replacing wherever you have stored your file.

Lastly run the two files by opening the file on windows and running `sudo ./FileMove.sh`

And your all done!
