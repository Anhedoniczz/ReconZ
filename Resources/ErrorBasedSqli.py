import requests
import time
from huepy import *

start_time = time.time()

def banner():
    ban = '''
 ______                     ____                     _  _____  ____  _      _____ _______        _   
|  ____|                   |  _ \                   | |/ ____|/ __ \| |    |_   _|__   __|      | |  
| |__   _ __ _ __ ___  _ __| |_) | __ _ ___  ___  __| | (___ | |  | | |      | |    | | ___  ___| |_ 
|  __| | '__| '__/ _ \| '__|  _ < / _` / __|/ _ \/ _` |\___ \| |  | | |      | |    | |/ _ \/ __| __|
| |____| |  | | | (_) | |  | |_) | (_| \__ \  __/ (_| |____) | |__| | |____ _| |_   | |  __/\__ \ |_ 
|______|_|  |_|  \___/|_|  |____/ \__,_|___/\___|\__,_|_____/ \___\_\______|_____|  |_|\___||___/\__|                                                                                                          
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
