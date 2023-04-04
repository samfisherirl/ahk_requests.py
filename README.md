# ahk_requests.py
<h3>Fast, comprehensive HTTP GET request library => using python's requests library to download from APIs, or website data.</h3>

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
