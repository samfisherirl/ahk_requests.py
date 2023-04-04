# ahk_requests.py
<h3>Fast, comprehensive HTTP GET request library => using python's requests library to download from APIs, or website data.</h3>

prase and credit to: https://github.com/TheArkive/JXON_ahk2

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

url := "https://httpbin.org/get"
headers := Map("myheaderkey", "myheaderval")
params := False
; see bottom for additional params- #1

req := requests(url, headers, params)

/*
req.allowRedirect := True ;optional
req.stream := True ;optional
this.py := A_ScriptDir "\ahk_requests.exe"
*/


req.get()
msgbox(req.jdata["origin"])
msgbox(req.txt)



```
