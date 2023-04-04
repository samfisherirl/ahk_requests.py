# ahk_requests.py
<h3>Fast, comprehensive HTTP GET request library => using python's requests library to download from APIs, or grab website data.</h3>

praise and credit to: https://github.com/TheArkive/JXON_ahk2

I'm sharing a new autohotkey library that I recently created, which allows you to easily perform HTTP GET requests and get back text and JSON data. It's based on Python's requests library, which is widely recognized as one of the best HTTP libraries out there.

Here are some of the key features of the library:

Simple syntax: You only need to provide the URL, and the library takes care of everything else.
JSON and text support: The library can automatically parse JSON responses and return them as objects, or return plain text.
Error handling: The library raises exceptions for common HTTP errors, such as 404 Not Found or 500 Internal Server Error, so you can handle them gracefully in your code.
Custom headers: You can also provide custom headers to the library, such as authentication tokens or user agents.
Here's an example of how to use the library:
```autohotkey

#Include %A_ScriptDir%\lib\JXON.ahk
#Include %A_ScriptDir%\lib\ahk_requests.ahk
;praise and credit to: https://github.com/TheArkive/JXON_ahk2


; Simple 
url := "https://httpbin.org/get"
; see bottom for additional params
req := requests(url)

req.get()
msgbox(req.jdata["origin"])
msgbox(req.txt)

; Complex
url := "https://httpbin.org/get"
headers := Map("myheaderkey", "myheaderval", "myheaderkey2", "myheaderval2")
; headers := False => gets converted to {"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36"}
params := Map("myparamkey", "myparamval")
req := requests(url, headers, params)

req.allowRedirect := True ;optional
req.stream := True ;optional

req.get()
msgbox(req.jdata["origin"])
msgbox(req.txt)

```
