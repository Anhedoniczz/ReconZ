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
httpx-toolkit -l subdomains -ports 80,443,8000,8080,8888 -o alivesubs -threads 200

echo "[+] Step 3: Openredirect Check"
python3 Resources/Openredirect.py $domain

echo "[+] Step 4: Host Header Injection scan"
bash Resources/HostHeaderscan.sh -l alivesubs > hhiscan

echo "[+] Step 5: Host Header Injection scan"
python3 ~/tools/Corsy/corsy.py -i alivesubs > CorsyScan

echo "[+] Step 6: Crawling Parameters and filtering them"
cat alivesubs | katana -passive -pss waybackarchive,commoncrawl,alienvault | uro > links

echo "[+] Step 7: Filtering XSS parameters and Testing Target on XSS/CVEs Using XSStrike"
cat links | gf xss > xsslinks
bash Resources/autoxss.sh

echo "[+] Step 8: Filtering LFI parameters and Testing Target on LFI/RFi/Data Traversal"
cat links | gf lfi > lfilinks
nuclei -l lfilinks -tags lfi,rfi
