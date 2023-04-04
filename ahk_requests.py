from requests import get
from pathlib import Path
from os import remove
from jsons import load, dump
from datetime import datetime
from pytz import timezone


class AHKRequest:
    def __init__(self):
        self.cwd = Path.cwd().resolve()
        self.xtra = self.cwd / "xtra.txt"
        self.get = self.cwd / "get.txt"
        self.response = self.cwd / "response.txt"
        self.json = self.cwd / "jdata.json"
        self.redir = False
        self.stream = False
        self.headers = {}
        self.params = {}
        self.responsetxt = ""
        self.responsejson = ""
        self.url = ""
        self.read_data()

    def read_data(self):
        print(self.cwd)
        if self.xtra.is_file():
            with open(self.xtra, "r") as f:
                for i in f.readlines():
                    if "allowRedirects" in i:
                        if "True" in i.split("==")[1]:
                            self.redir = True
                        elif "False" in i.split("==")[1]:
                            self.redir = False
                    elif "stream" in i:
                        if "True" in i.split("==")[1]:
                            self.stream = True
                        elif "False" in i.split("==")[1]:
                            self.stream = False
        if self.get.is_file():
            with open(self.get, "r") as f:
                for i in f.readlines():
                    if "__hk__" in i:
                        self.headers = {i.split("__hk__")[1]: i.split("__hv__")[1]}
                    elif "__pk__" in i:
                        self.params = {i.split("__pk__")[1]: i.split("__pv__")[1]}
                    elif "__url__" in i:
                        self.url = i.split("__url__")[1]
        if self.response.is_file():
            remove(self.response)
        if self.json.is_file():
            remove(self.json)
        if self.headers == {}:
            self.headers = self.default_headers()


    def default_headers(self):
        return {"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36"}
        
        
    
        
    def download_data(self):
        if self.params == {}:
            self.params = False
        response = get(url=self.url, headers=self.headers, params=self.params, allow_redirects=self.redir, stream=self.stream)
        self.responsetxt = str("".join(response.text.split("\n")))
        self.responsejson =  str(response.json())
        return

    def write_data(self):        
        with open(self.response, "w") as f:
            f.write(self.responsetxt)
        with open(self.json, "w") as f:
            f.write(self.responsejson)
        if self.get.is_file():
            remove(self.get)
        if self.xtra.is_file():
            remove(self.xtra)
        print(str(self.responsetxt))
        print(str(self.responsejson))
        

if __name__ == "__main__":
    try:
        ahk = AHKRequest()
        ahk.download_data()
        ahk.write_data()
    except Exception as e:
        tz = timezone('EST')
        time = str(datetime.now(tz))
        with open("ERRORS.txt", "a") as f:
            f.write(str(e))
            f.write(str(f"\nat: {time}\n\n\n"))
            f.write(str(ahk.__dict__))