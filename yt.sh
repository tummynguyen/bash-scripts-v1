#!/bin/bash

# INSTALLING THE CONVERTOR & DEPENDENCIES IF UNAVAILABLE 
if [[ ! -f /usr/local/bin/youtube-dl ]]
then
        echo -e "\n[+] DOWNLOADER NOT FOUND, INSTALLING NOW"
        sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl / 
        sudo apt-get install ffmpeg /
        sudo chmod a+rx /usr/local/bin/youtube-dl /
        sudo youtube-dl -U / 
fi

# CHOOSE A FORMAT TO CONVERT THE VIDEO [TYPE IN CORRESPONDING NUMBER]
echo -e "\n[+] CHOOSE A FORMAT: " 
echo -e "1) AUDIO"
echo -e "2) VIDEO" 
echo -e "*) EXIT"
read prompt 

# ENTER A VALID YOUTUBE LINK
echo -e "\n[+] ENTER THE LINK: "
read link

# CASE PROMPT TO INSTALL VIDEO
case $prompt in
        1) 
        read -p "INPUT A FORMAT [EX: MP3, M4A, WAV]: " type
        read -p "DO YOU WANT TO INCLUDE THUMBNAIL?: " thumb
        if [[ $thumb == '' ]] || [[ $thumb == 'y' ]]
        then
                echo -e "\n[+] $(youtube-dl -x --embed-thumbnail --audio-format ${type} ${link})"
        else
                echo -e "\n[+] $(youtube-dl -x --audio-format ${type} ${link})"
        fi
        ;;

        *)
        echo -e "[+] EXITING SCRIPT!"
        ;;
esac