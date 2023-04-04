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
