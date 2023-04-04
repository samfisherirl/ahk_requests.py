#Include JXON.ahk


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




class requests
{
    __New(url, headers, params) {
        this.url := url
        this.paramKeys := []
        this.paramVals := []
        this.headerKeys := []
        this.headerVals := []
        this.py := A_ScriptDir "\ahk_requests.exe"
        
        this.headers := this.headerEnum(headers)
        this.params := this.paramEnum(params)
        this.allowRedirects := False
        this.stream := False
        this.xtrapath := A_ScriptDir "\xtra.txt"
        this.getpath := A_ScriptDir "\get.txt"
        this.response := A_ScriptDir "\response.txt"
        this.json := A_ScriptDir "\jdata.json"
        this.txt := ""
        this.jdata := ""
    }
    get(){
        this.appendXtra()
        this.appendParams()
        this.execute()
        this.waitResponse()
    }
    
    
    headerEnum(headers) {
        if (headers != False) or (headers != 0)
        {
            for key, value in headers
            {
                this.headerKeys.push("__hk__" . key . "__hk__")
                this.headerVals.push("__hv__" . value . "__hv__")
            }
            return True
        }
        return False
    }


    paramEnum(params) {
        if (params != False) or (params != 0)
        {
            for key, value in params
            {
                this.paramKeys.push("__pk__" . key . "__pk__")
                this.paramVals.push("__pv__" . value . "__pv__")
            }
            return True
        }
        return False
    }
    
    appendXtra(){
        
        if this.allowRedirects == True {
            this.allowRedirects := "allowRedirects==True"
        }
        else {
            this.allowRedirects := "allowRedirects==False`n"
        }
        if this.stream == True {
            this.stream := "stream==True"
        }
        else {
            this.stream := "stream==False`n"
        }
        try{
        FileDelete(this.xtrapath)
        }
        catch {
            sleep(1)
        }
        FileAppend(this.allowRedirects . this.stream, this.xtrapath)
        
    }
    appendParams(){
        
        this.url := "__url__" . this.url . "__url__"
        len := this.paramKeys.Length
        if (this.params != False) or (this.params != 0)
        {
            Loop len
            {
                this.params .= this.paramKeys[A_Index] . this.paramVals[A_Index] . "`n"
            }
        }
        else
        {
            this.params := ""
        }
        len := this.headerKeys.Length
        if (this.headers != False) or (this.headers != 0)
        {
            Loop len
            {
                this.headers .= this.headerKeys[A_Index] .  this.headerVals[A_Index] . "`n"
            }
        }
        else
        {
            this.headers := ""
        }
        try{
        FileDelete(this.getpath)
        }
        catch {
            sleep(1)
        }
        FileAppend(this.url . "`n" . this.params . "`n" . this.headers, this.getpath)
    }
    
    execute(){       
        try{
            FileDelete(this.response)
            }
        catch {
            sleep(1)
        }
        try{
            FileDelete(this.json)
            }
        catch {
            sleep(1)
        }
        Run(this.py)
        
    }
    waitResponse(){
        txt:=0
        jdata:=0
        loop 100 {
            sleep(200)
            if (txt==0){
                if not FileExist(this.xtrapath) {
                    this.txt := FileRead(this.response)
                    txt := 1
                }
            }
            if (jdata==0){
                if not FileExist(this.getpath) {
                    jdata := FileRead(this.response)
                    this.jdata := Jxon_Load(&jdata)
                    jdata := 1
                }
            }
            if (jdata==1) and (txt==1){
                break
            }
        }
    }

}

/*
_________________________________________
appendex of sorts -- additional parameters corresponding to the see-bottom numbers above
_________________________________________


___________________1_____________________
other methods
 headers := False
 params := Map("myparamskey", "myparamsval", "myparamskey2", "myparamsval2")

 or:
 headers := False => converted to {"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36"}
 
 params := False


___________________1_____________________