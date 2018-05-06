#!/usr/bin/python
# -*- coding: utf-8 -*-
__author__ = 'essepuntato'
import web
import os
from wl import WebLogger
from ud import URIDecoder
import cgi
import urllib2
import re
from rrh import RewriteRuleHandler
import requests

# Vars
base_path = "templates" + os.sep

# For redirecting
urls = (
    "/", "Home",
    "/lode(/.+)?", "LODE"
)

# For rendering
render = web.template.render(base_path)

rewrite = RewriteRuleHandler(
    "Redirect",
    [
        ("^(/(css|img)/.*)$",
         "/static/old\\1",
         True)
    ],
    urls
)

web_logger = WebLogger("essepuntato.it", "essepuntato_log.txt", [
    "REMOTE_ADDR",      # The IP address of the visitor
    "HTTP_USER_AGENT",  # The browser type of the visitor
    "HTTP_REFERER",     # The URL of the page that called your program
    "HTTP_HOST",        # The hostname of the page being attempted
    "REQUEST_URI"       # The interpreted pathname of the requested document
                        # or CGI (relative to the document root)
    ],
    {"REMOTE_ADDR": ["212.47.249.17"]}  # uncomment this for real app
    # {"REMOTE_ADDR": ["127.0.0.1"]}  # uncomment this for test
)

class Redirect:
    def GET(self, *args):
        raise web.seeother(rewrite.rewrite(args[0]))


class Home:
    def GET(self):
        web_logger.mes()
        return render.home()


class LODE:
    def GET(self, params):
        if params is None or re.match("^/?$", params):
            web_logger.mes()
            return render.lode()
        else:
            web_logger.mes()

            # This part only if the requests come from the URL
            # TODO: check if "http://" is intepreted as encoded
            translated_string = URIDecoder().decodes(params[1:])

            # This part for all the requests
            req = requests.get("http://eelst.cs.unibo.it/apps/LODE/extract?" + translated_string)

            web.header('Access-Control-Allow-Origin', '*')
            web.header('Access-Control-Allow-Credentials', 'true')
            web.header('Content-Type', 'Content-type: text/html')
            web_logger.mes()
            return req.text + params[1:] + translated_string


if __name__ == "__main__":
    app = web.application(rewrite.get_urls(), globals())
    app.run()
