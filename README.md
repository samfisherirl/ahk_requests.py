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
;grab python executable here https://github.com/samfisherirl/ahk_requests.py
;praise and credit to: https://github.com/TheArkive/JXON_ahk2

; Simple 
url := "https://httpbin.org/get"
; see bottom for additional params
req := requests(url)

req.get()

msgbox(req.jdata["origin"])
msgbox(req.txt)

/*
**************************************************************
*/

; Intermediate example

url := "https://httpbin.org/get"
headers := Map("key1", "value1")
params := Map("key1", "value1")
req := requests(url, headers, params)

req.get()

msgbox(req.jdata["origin"])
msgbox(req.txt)





; Complex example Airtable API 
; https://github.com/josephbestjames/airtable.py

api_key := "xxxxx"
base_id := "yyyyy"
table_name := "zzzzzz"

url := "https://api.airtable.com/v0/" . base_id  . "/" . table_name
headers := Map(
            "Authorization", 
            "Bearer " . api_key
            )
; headers := False => gets converted to {"User-Agent":"Mozilla/5.0 (Macintosh;...
params := Map("view", "Grid view")
req := requests(url, headers, params)

req.allowRedirect := True ;optional
req.stream := False ;optional

req.get()
msg := ""
for k, v in req.jdata
{
    ;json data
    try {
    msg .= k . ": " . v . "`n"
    }
    catch {
        continue
    }
}
msgbox(msg)
msgbox(req.txt)


```
