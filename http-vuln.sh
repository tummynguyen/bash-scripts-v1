#!/bin/bash

# ONLY ROOT CAN ONLY CAN RUN SCRIPT 
if [[ $UID != 0 ]]
then 
	echo "[+] YOU MUST BE ROOT TO RUN THIS SCRIPT!"
	exit
fi

# INSTALLING NIKTO OR NMAP IF UNAVAILABLE
if [[ ! -f /usr/bin/nikto ]] || [[ ! -f /usr/bin/nmap ]]
then
	echo "[+] MUST INSTALL DEPENDENCIES"
	echo "[+] INSTALLING: "
	apt update -yy && apt install nikto -yy  && apt install nmap -yy 
fi 

# INPUT THE IP OR SUBNET [USE POSITIONAL PARAMETERS FOR MORE INPUTS] 
echo -e "[+] ENTER AN IP OR SUBNET:"
read ip

# NMAP SCAN ON PORT HTTP 80 [REMOVE /DEV/NULL TO SEE NMAP PROCESS] 
echo -e "\n[+] NMAP SCANNING ON ${ip} FOR  PORT 80"
nmap -sV -p 80 ${ip} -oG REPORT.TXT > /dev/null
if grep -q  "open" REPORT.TXT > /dev/null 
then 
 echo -e "TCP PORT 80 FOUND!"
else 
 echo -e "TCP PORT 80 UNVALIABLE!\nEXITING SCRIPT"
 exit
fi

# INPUTTING THE TARGET IP INTO A TARGET.TXT TEXT FILE
echo -e "\n[+] INPUTTING TARGET IP ON TARGET.TXT"
cat REPORT.TXT | awk '/Up$/{print $2}'  > TARGET.TXT
echo -e "SUCCESSFULLY GENERATED TARGET.TXT ON $PWD"


# WEB SCANNING USING NIKTO AND INPUTTING RESULTS ON TARGET.TXT TEXT FILE
# IF PROCESS TAKES TOO LONG, PRESS ENTER NIKTO MAY ASK FOR A PROMPT DURING SCAN
echo -e "\n[+] WEB SCANNING TARGET" 
nikto -h TARGET.TXT >> REPORT.TXT

# GENERATING A VULNERABILITY REPORT
echo -e "\n[+] SUCCESSFULLY CREATED REPORT.TXT" 
cat -n REPORT.TXT 

# DELETE TARGET.TXT
rm -rf TARGET.TXT 

