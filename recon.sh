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
echo "[+] Step 1: Subdomain searching for $domain..."
assetfinder -subs-only "$domain" | uniq | sort > "$domain/subdomains_assetfinder"
subfinder -d "$domain" -silent > "$domain/subdomains_subfinder"
cat "$domain/subdomains_assetfinder" "$domain/subdomains_subfinder" | sort -u > "$domain/subdomains"
rm "$domain/subdomains_assetfinder" "$domain/subdomains_subfinder"
echo "[+] Subdomains saved to $domain/subdomains."

echo "[+] Step 2: Checking for live subdomains using httpx-toolkit..."
httpx-toolkit -l $domain/subdomains -ports 80,443,8000,8080,8888 -threads 200 -o $domain/alivesubs 
awk -F'//' '{print $2}' "$domain/alivesubs" | sort -u > "$domain/validdomains"

echo "[+] Step 3: Openredirect Check"
python3 Resources/Openredirect.py $domain

echo "[+] Step 4: Host Header Injection scan"
sudo bash Resources/HostHeaderScan.sh -l $domain/alivesubs | grep "is vuln" > $domain/hhscanvulns

echo "[+] Step 5: Cors Exploit scan"
python3 ~/tools/Corsy/corsy.py -i $domain/alivesubs > $domain/CorsyScan

echo "[+] Step 6: Crawling Parameters and filtering them"
cat $domain/alivesubs | gau --threads 5 | uro > $domain/links

echo "[+] Step 7: Filtering XSS parameters and Testing Target on XSS"
cat $domain/links | gf xss > $domain/xsslinks
cat $domain/xsslinks | Gxss -p Rxss | dalfox pipe > $domain/xsserrors

echo "[+] Step 8: Filtering LFI parameters and Testing Target on LFI/RFi/Data Traversal"
cat $domain/links | gf lfi > $domain/lfilinks
nuclei -l $domain/lfilinks -tags lfi,rfi
