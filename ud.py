#!/usr/bin/python
# -*- coding: utf-8 -*-
import re


class URIDecoder:
    def decodes(self, stringToDecode):
        # Add the additional slash to the protocol definition if needed
        if re.compile(".*(http|ftp)s?:/(?!/).+").search(stringToDecode):
            stringToDecode = re.sub(":/","://", stringToDecode)
        
        searchProtocol = re.compile("(http|ftp)s?://.+")
        matchProtocol = searchProtocol.search(stringToDecode)
        
        result = ""
        
        if matchProtocol :
            stringWithoutProtocol = searchProtocol.sub("", stringToDecode)
            
            splittedStringList = stringWithoutProtocol.strip("/").split("/")
            
            for splittedString in splittedStringList:
                if len(splittedString) != 0:
                    if "=" in splittedString :
                        result += splittedString + "&"
                    else :
                        result += splittedString + "=true&"
            
            result += "url=" + matchProtocol.group(0)
        
        return result
