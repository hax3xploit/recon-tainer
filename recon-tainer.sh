#!/bin/bash



NOCOLOR='\033[0m'
BOLD='\e[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
mainPATH=$(pwd)/
param="gau" # use gau or waybackmachine
bar="---------------------------------------"

echo -e "\n$bar\n\t ${RED} @hax_3xploit ${NOCOLOR} \n$bar\n"
read -p "Please enter target (i.e. site.com): " domain

HOST=$domain

echo -e "\n${bar}\n Creating Directory ${LIGHTGREEN}$domain${NOCOLOR}\n${bar} $(mkdir -p results/$domain)"


sublist3rPATH=../results/$domain/$HOST-sublist3r.txt
subfinderPATH=./results/$domain/$HOST-subfinder.txt
amassPATH=./results/$domain/$HOST-amass.txt
dirsearchPATH=./results/$domain/$HOST-dirsearch.txt
oneForAllPATH=../results/$domain/
assetfinderPATH=./results/$domain/$HOST-assetfinder.txt
finddomainPATH=./results/$domain/$HOST-findomain.txt

function automateSublist3r() {
	echo -e "\n$bar\n\tRunning Sublist3r\n$bar\n"
	cd $mainPATH
	cd Sublist3r/
	python3 sublist3r.py -t 100 -v -o $sublist3rPATH -d $HOST
}

function automateSubfinder() {
	echo -e "\n$bar\n\tRunning Subfinder\n$bar\n"
	cd $mainPATH
	subfinder -o $subfinderPATH -t 100 -d $HOST 
}

function automateAmass() {
	echo -e "\n$bar\n\tRunning Amass\n$bar\n"
	cd $mainPATH
	amass enum -active -o $amassPATH -d $HOST
}

function automateOneForAll() {
	echo -e "\n$bar\n\tRunning OneForAll\n$bar\n"
	cd $mainPATH
	cd OneForAll/
	python3 oneforall.py --target $HOST run --path=$oneForAllPATH
	cd $mainPATH/results/$domain/
	rm -rf *.csv
	mv all_subdomain_result* $HOST-oneforall.txt
}

function automateAssetsFinder() {
	echo -e "\n$bar\n\tRunning Assets finder\n$bar\n"
	cd $mainPATH
	assetfinder --subs-only $HOST | tee $assetfinderPATH
}

function automateFindomain() {
	echo -e "\n$bar\n\tRunning Findomain\n$bar\n"
	cd $mainPATH
	findomain-linux -t $HOST -u $finddomainPATH
}

function sortResults() {
	cd $mainPATH
	cd results/$domain/
	cat *.txt | sed "s/www.//" | sed "s/nwww.//" | sort | uniq > results.txt
	echo -e "\n$bar\nFinal Results:\n$bar\n"
	echo -e "[#] Subdomains Count: $(wc -l < results.txt)\n"
	cat results.txt
}


function livedomains() {
    echo -e "\n${bar}\n${WHITE}Starting ${GREEN}HTTPx${WHITE} on all filtered subdomains${NOCOLOR}\n${bar}\n"
    cat /root/results/$domain/results.txt  | sort -u | uniq -u | httpx -silent > /root/results/$domain/$domain-alive.txt
    cat /root/results/$domain/$domain-alive.txt |sed 's/https\?:\/\///' > /root/results/$domain/$domain-alive-final.txt
	echo -e "[#] Live Subdomains: $(wc -l < $domain-alive-final.txt)\n"
    echo -e "${LIGHTPURPLE}$(cat $domain-alive-final.txt) ${NOCOLOR}"
    sleep 2
}


function paramHunt() {
    echo -e "\n${bar}\n${BLUE}${BOLD}🔥 Starting ${GREEN}$3${NOCOLOR}${BOLD} param output on $domain. \n${bar}\n${NOCOLOR}"
    cat $domain-alive-final.txt | ${param} > $domain-${param}.txt
}

function xssparam(){
    echo -e "\n${bar}\n${BLUE}${BOLD}🔥 XSS${NORMAL} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf xss > $domain-xss.txt
    echo -e "\n"
    echo -e "$(cat $domain-xss.txt)" 
    echo -e "\n"
}

function ssrf(){
    echo -e "\n${bar}\n$Starting ${GREEN}🔥 SSRF${NORMAL} param filtering on $1. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt  | gf ssrf > /root/results/$domain/$domain-ssrf.txt
}

function SSTI(){
    echo -e "Starting ${GREEN}🔥 SSTI${NORMAL} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf ssti > /root/results/$domain/$domain-ssti.txt
    echo -e "\n"
    echo -e "$(cat $domain-ssti.txt)" 
    echo -e "\n"
}

function REDIRECT (){
    cat $domain-${param}.txt | gf redirect > /root/results/$domain/$domain-redirect.txt
    echo -e "\n"
    echo -e "$(cat $domain-redirect.txt)" 
    echo -e "\n"
}


function SQLi(){
    echo -e "\n${bar}\nStarting ${WHITE}🔥 SQLi${NORMAL} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf sqli > /root/results/$domain/$domain-sqli.txt
    echo -e "\n"
    echo -e "$(cat $domain-sqli.txt)"
    echo -e "\n"
}


function LFI(){
    echo -e "\n${bar}\nStarting ${WHITE}🔥 LFI${NORMAL} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf lfi > /root/results/$domain/$domain-lfi.txt
    echo -e "\n"
    echo -e "$(cat $domain-lfi.txt)"
    echo -e "\n"
}


function RCE(){
    echo -e "\n${bar}\n ${GREEN}🔥 RCE ${WHITE} on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf rce > /root/results/$domain/$domain-rce.txt
    echo -e "\n"
    echo -e "$(cat $domain-rce.txt)" 
    echo -e "\n"
}

function idor(){
    echo -e "\n${bar}\n${RED}${BOLD}🔥 IDOR${WHITE} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 2
    cat $domain-${param}.txt | gf idor > /root/results/$domain/$domain-idor.txt
    echo -e "\n"
    echo -e "$(cat $domain-idor.txt)" 
    echo -e "\n"
}


function img-traversal(){
    echo -e "\n${bar}\n${BLUE}${BOLD}Image-traversal${WHITE} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 1
    cat $domain-${param}.txt | gf img-traversal > /root/results/$domain/$domain-img-traversal.txt
    echo -e "\n"
    echo -e "$(cat $domain-img-traversal.txt)" 
    echo -e "\n"
}


function interestingEXT(){
    echo -e "\n${bar}\n${RED}${BOLD}interestingEXTENSION${WHITE} param filtering on ${domain}. ${NOCOLOR} \n${bar}\n"
    sleep 1
    cat $domain-${param}.txt | gf interestingEXT > /root/results/$domain/$domain-interestingEXT.txt
    echo -e "\n"
    echo -e "$(cat $domain-interestingEXT.txt)" 
    echo -e "\n"

}

function dirsearch(){
    echo -e "\n${bar}\n${WHITE}Launching ${GREEN}Dirsearch${WHITE} on all filtered subdomains${NOCOLOR}\n${bar}\n"
    cat /root/results/$domain/$domain-alive.txt | xargs -I@ sh -c "python3 /root/dirsearch/dirsearch.py -r -b -w  /root/dirsearch/db/dicc.txt -u @ -e php,html,json,aspx --plain-text-report ${dirsearchPATH}" 
}



automateSublist3r $HOST
sleep 2
automateSubfinder $HOST
sleep 2
automateAmass $HOST
sleep 2
automateOneForAll $HOST
sleep 2
automateAssetsFinder $HOST
sleep 2
automateFindomain $HOST
sleep 2
sortResults
sleep 1
livedomains
sleep 1
paramHunt
sleep 1
xssparam
sleep 1
ssrf
sleep 1
SSTI
sleep 1
REDIRECT
sleep 1
SQLi
sleep 1
LFI
sleep 1
RCE
sleep 1
idor
sleep 1
img-traversal
sleep 1
interestingEXT
sleep 1
dirsearch
