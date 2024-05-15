from googlesearch import search
from urllib.parse import urlparse
import requests
import sys
import time

text1 = "\033[0;91m[+] Openredirect Exploit tool made by Anhedoniczz!"
for z in text1:
  time.sleep(0.02) 
  sys.stdout.write(z)
  sys.stdout.flush()
print()

def search_and_filter(input_domain):
    search_query = f"site:{input_domain} inurl:redir | inurl:url | inurl:redirect | inurl:return | inurl:src=http | inurl:r=http"
    search_results = search(search_query, num=10, stop=10)
    
    filtered_links = []
    
    for link in search_results:
        try:
            response = requests.get(link)
            if response.status_code == 200:
                parsed_url = urlparse(link)
                if parsed_url.netloc.endswith(input_domain):
                    filtered_links.append(link)
        except Exception as e:
            print(f"Error accessing {link}: {e}")
    
    return filtered_links

if len(sys.argv) != 2:
    print("Usage: python Openredirect.py <domain>")
    sys.exit(1)

input_domain = sys.argv[1]
filtered_links = search_and_filter(input_domain)
print("Filtered Links:")
for link in filtered_links:
    print(link)
