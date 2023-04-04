#Include %A_ScriptDir%\lib\JXON.ahk
#Include %A_ScriptDir%\lib\ahk_requests.ahk


; Simple 
url := "https://httpbin.org/get"
; see bottom for additional params
req := requests(url)

req.get()

msgbox(req.jdata["origin"])
msgbox(req.txt)


; Complex
url := "https://httpbin.org/get"
headers := Map("myheaderkey", "myheaderval")
params := Map("myparamkey", "myparamval")
; see bottom for additional params- #1

req := requests(url, headers, params)

req.allowRedirect := True ;optional
req.stream := True ;optional

req.get()
msgbox(req.jdata["origin"])
msgbox(req.txt)