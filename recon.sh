#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 -u <domain>"
    exit 1
}

# Check if there are no arguments provided
if [ $# -eq 0 ]; then
    usage
fi

# Parse command line options
while getopts ":u:" opt; do
    case ${opt} in
        u )
            domain=$OPTARG
            ;;
        \? )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if domain is provided
if [ -z "$domain" ]; then
    echo "Domain is required"
    usage
fi

mkdir $domain
echo "[+] Step 1: Running spyhunt.py to find subdomains for $domain..."
python3 ~/tools/spyhunt/spyhunt.py -s "$domain" --save $domain/subdomains

echo "[+] Step 2: Checking for live subdomains using httpx-toolkit..."
httpx-toolkit -l $domain/subdomains -ports 80,443,8000,8080,8888 -threads 200 -o $domain/alivesubs 

echo "[+] Step 3: Openredirect Check"
python3 Resources/Openredirect.py $domain

echo "[+] Step 4: Host Header Injection scan"
sudo bash Resources/HostHeaderScan.sh -l $domain/alivesubs | grep "is vuln" > $domain/hhscanvulns

echo "[+] Step 5: Cors Exploit scan"
python3 ~/tools/Corsy/corsy.py -i $domain/alivesubs > $domain/CorsyScan

echo "[+] Step 6: Crawling Parameters and filtering them"
cat $domain/alivesubs | gau --threads 5 | uro > $domain/links

echo "[+] Step 7: Filtering JS links and finding sensitive data in them"
cat $domain/links | grep ".js$" > $domain/jsfiles.txt
cat $domain/jsfiles.txt | while read url; do python3 ~/tools/SecretFinder/SecretFinder.py -i $url -o cli >> $domain/secret.txt; done
cat $domain/secret.txt | grep aws > $domain/awsapi.txt
cat $domain/secret.txt | grep Heroku > $domain/herokuapi.txt
cat $domain/secret.txt | grep google > $domain/googleapi.txt

echo "[+] Step 8: Filtering XSS parameters and Testing Target on XSS"
cat $domain/links | gf xss > $domain/xsslinks
payload="<sCript>confirm(1)</sCript>"
cat $domain/xsslinks | qsreplace $payload | xsschecker -match $payload -vuln

echo "[+] Step 9: Filtering LFI parameters and Testing Target on LFI/RFi/Data Traversal"
cat $domain/links | gf lfi > $domain/lfilinks
nuclei -l $domain/lfilinks -tags lfi,rfi

echo "[+] Step 10: SQLI Scan {Ak Sxva rame ewera magram Twizzy Never Broke Again <3}"
cat $domain/links | gf sqli > sqlilinks
python3 Resources/ErrorBasedSqli.py
