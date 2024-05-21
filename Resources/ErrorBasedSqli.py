import requests
import time
from huepy import *

start_time = time.time()

def banner():
    ban = '''
 _               _ _     _     _         _       _         
| |__   ___   __| (_)___| |__ (_)  _ __ (_) __ _| | _____  
| '_ \ / _ \ / _` | / __| '_ \| | | '_ \| |/ _` | |/ / _ \ 
| |_) | (_) | (_| | \__ \ | | | | | | | | | (_| |   < (_) |
|_.__/ \___/ \__,_|_|___/_| |_|_| |_| |_|_|\__,_|_|\_\___/ 
                                                           
           _                                                    _     _     _ 
 _ __ ___ (_)_   ___   ____ _ _ ____  ____ _ _ __    __ _ _   _| |___| |__ (_)
| '_ ` _ \| | | | \ \ / / _` | '__\ \/ / _` | '__|  / _` | | | | / __| '_ \| |
| | | | | | | |_| |\ V / (_| | |   >  < (_| | |    | (_| | |_| | \__ \ | | | |
|_| |_| |_|_|\__, | \_/ \__,_|_|  /_/\_\__,_|_|     \__, |\__,_|_|___/_| |_|_|
             |___/                                  |___/                     
      '''

    print(green(ban))

def concatenate_list_data(list, result):
    for element in list:
        result = result + "\n" + str(element)
    return result

def main():
    banner()

    with open('sqlilinks', 'r') as file:
        content = file.read()
    urls = content.splitlines()
    with open('ErrorSQLPayloads.txt', 'r') as file:
        payloads = file.read().splitlines()

    vulnerable_urls = []

    for uri in urls:
        for payload in payloads:
            final_url = uri + payload
            
            try:
                req = requests.get("{}".format(final_url))
                if req.status_code == 200:
                    res = req.text
                    if 'SQL' in res or 'sql' in res or 'Sql' in res:
                        print("[" + green("sql-injection") + "] " + final_url)
                        break                           
            except requests.RequestException as e:
                print(red("Error: {}".format(e)))
                pass

if __name__ == "__main__":
    main()
