import glob
import sys

f = open(".gitattributes")

regexlist = {}

for newline in f:
    if " eol=" in newline:
        fileregex = newline.split(" ")[0]
        eol = newline.split("=")[1]
        regexlist[fileregex] = { "eol" : eol, "files" : {} }

f.close()

for i in regexlist:
    regexlist[i]["files"] = set(glob.glob(i, recursive = True))
    for j in regexlist:
        if i is j:
            break
        regexlist[j]["files"].difference_update(regexlist[i]["files"])

for i in regexlist:
    print(i)

errors = 0
for i in regexlist:
    eol = regexlist[i]["eol"]
    if "crlf" in eol:
        for j in regexlist[i]["files"]:
            f = open(j, newline='', encoding="utf-8")
            if "\r\n" in f.readline():
                f.close()
            else:
                errors += 1
                print("::error file=" + j + ",line=1::This file has the wrong line endings, should have CRLF!")
                f.close()
    elif "lf" in eol:
        for j in regexlist[i]["files"]:
            f = open(j, newline='', encoding="utf-8")
            if "\r" in f.readline():
                errors += 1
                print("::error file=" + j + ",line=1::This file has the wrong line endings, should have LF!")
                f.close()
            else:
                f.close()

sys.exit(errors)
