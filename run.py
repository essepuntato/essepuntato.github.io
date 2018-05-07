#!/usr/bin/python
# -*- coding: utf-8 -*-
__author__ = 'essepuntato'
import web
import os
from wl import WebLogger
from ud import URIDecoder
import re
from rrh import RewriteRuleHandler
import requests

# Vars
base_path = "templates" + os.sep

# For redirecting
urls = (
    "/", "Home",
    "/lode(/.+)?", "LODE",
    "/ditto(/.+)?", "Ditto"
)

# For rendering
render = web.template.render(base_path)

rewrite = RewriteRuleHandler(
    "Redirect",
    [
        ("^/2013/citalo/test/data/?$", "http://dwellonit.sourceforge.net/citalotestdata", True),
        ("^/2013/06/patterns/test/?$", "http://fpoggi.web.cs.unibo.it/JASIST/", True),
        ("^/2013/doco/test/?$", "/2013/doco/test.html", True),
        ("^/2013/dchanges$", "/2013/DChanges/earmark.ttl", True),
        ("^/2013/metacategorisation/test/?$", "/2013/metacategorisation/data.html", True),
        ("^/2013/ntds/tests/?$", "/2013/ntds/tests.html", True),
        ("^/2014/ntds/tests/?$", "/2014/ntds/tests.html", True),
        ("^/2012/06/lodetest(/.*)?$", "http://dwellonit.sourceforge.net/lodetest", True),
        ("^/2012/06/lodetest-(.+)(/.*)?$", "http://dwellonit.sourceforge.net/lodetest-\\1", True),
        ("^/2013/sepublica/test/?$", "/2013/sepublica/test.html", True),
        ("^/2013/sepublica/xslt/?$", "/2013/sepublica/ExtractRefsFromBalisage.xsl", True),
        ("^/2013/citalo/tests?/?$", "/2013/citalo/tests.html", True),
        ("^/2013/citalo/xslt/?$", "/2013/sepublica/ExtractRefsFromBalisage.xsl", True),
        ("^/2013/03/cito2wordnet(/.*)?$", "http://dwellonit.sourceforge.net/cito2wordnet", True),
        ("^/2013/03/cito2wordnet-all-synsets(/.*)?$", "http://dwellonit.sourceforge.net/cito2wordnet-all-synsets", True),
        ("^/2013/03/cito-functions(/.*)?$", "http://dwellonit.sourceforge.net/cito-functions", True),
        ("^/2012/05/ontologydocumentationtests/?$", "/2012/05/ontologydocumentationtests.html", True),
        ("^/2012/04/lodeusertesting/?$", "/2012/04/lodeusertesting.html", True),
        ("^/graffoo/preliminary-test$", "/graffoo/preliminary-test.zip", True),
        ("^/graffoo/sources$", "https://svn.code.sf.net/p/dwellonit/code/GraFFOO/Graffoo.graphml", True),
        ("^/xml2earmark/xslt$", "http://eelst.cs.unibo.it/apps/XML2EARMARK/FromXMLToEARMARK.xsl", True),
        ("^/xml2earmark/?$", "http://eelst.cs.unibo.it/apps/XML2EARMARK", True),
        ("^/lenses-paper/prefixes$", "/lenses-paper/prefixes.ttl", True),
        ("^/lenses-paper/xml$", "/lenses-paper/lenses_doceng2012.iml", True),
        ("^/lenses-paper/earmark$",
         "http://eelst.cs.unibo.it/apps/XML2EARMARK/transform?url=http://www.essepuntato.it/lenses-paper/xml", True),
        ("^/2013/tal/prefixes$", "/2013/tal/prefixes.ttl", True),
        ("^/2013/tal/questionaires$", "/2013/tal/questionaires.html", True),
        ("^/lisc2014/questionn?aries$", "/2013/tal/questionaires.html", True),
        ("^/lisc2014/lens-example$", "/2013/tal/example.ttl", True),
        ("^/lisc2014/LensedMika.html$", "/2013/tal/LensedMika.html", True),
        ("^/slam/?$", "/slam/slam.html", True),
        ("^/2011/02/argumentmodel(/.*)?$", "http://dwellonit.sourceforge.net/argumentmodel", True),
        ("^/2011/03/lens$", "http://dwellonit.sourceforge.net/lens", True),
        ("^/2011/jasist/discussion$", "/2011/jasist/discussion.html", True),
        ("^/2011/jasist/examples$", "/2011/jasist/examples.html", True),
        ("^/2009/10/error(/.*)?$", "http://dwellonit.sourceforge.net/error", True),
        ("^/2010/05/ghost(/.*)?$", "http://dwellonit.sourceforge.net/ghost", True),
        ("^/2008/12/earmark(/.*)?$", "http://dwellonit.sourceforge.net/shell", True),
        ("^/2013/06/la-earmark(/.*)?$", "http://dwellonit.sourceforge.net/la-earmark", True),
        ("^/2013/07/echo(/.*)?$", "http://dwellonit.sourceforge.net/echo", True),
        ("^/2011/05/overlapping(/.*)?$", "http://dwellonit.sourceforge.net/overlapping", True),
        ("^/2011/11/toc(/.*)?$", "http://dwellonit.sourceforge.net/tvc", True),
        ("^/2012/04/tvc(/.*)?$", "http://dwellonit.sourceforge.net/tvc", True),
        ("^/2010/04/ParadiseLost(/.*)?$", "/2010/04/ParadiseLost.owl", True),
        ("^/2010/04/ParadiseLostAlign(/.*)?$", "/2010/04/AlignementWithPatterns.owl", True),
        ("^/2010/04/ParadiseLost/test$", "/2010/04/test.html", True),
        ("^/2011/03/schemaexample(/.*)?$", "/2011/03/schemaexample.owl", True),
        ("^/2011/03/schemaexample/test$", "/2011/03/test.html", True),
        ("^/2008/12/pattern(/.*)?$", "https://w3id.org/people/essepuntato/po", True),
        ("^/2010/04/SWWEx(/.*)?$", "/2010/04/SWWEx.owl", True),
        ("^/about$", "/me", True),
        ("^/about/me$", "/me", True),
        ("^/me\.rdf$", "/me", True),
        ("^/me\.html$", "/", True),
        ("^/2010/07/rankedlist$", "/2010/07/rankedlist-1_0.owl", True),
        ("^/2010/06/literalreification(/.*)?$", "http://dwellonit.sourceforge.net/literalreification", True),
        ("^/2010/09/skosdeclarations(/.*)?$", "/2010/09/skosdeclarations.owl", True),
        ("^/ditto/preliminary-test/?$", "/2014/ditto/preliminary-test.zip", True),
        ("^/foaf.rdf$", "/me", True),
        ("^/me/?$", "http://www.w3.org/2007/08/pyRdfa/shadowextract?uri=http://www.essepuntato.it&format=turtle"
                    "&rdfa-lite=false&graph=output&vocab-expansion=false&embedded-turtle=true&space-preserve="
                    "true&vocab-cache-report=false&vocab-cache-bypass=false", True),
        ("^(/graffoo)/?$", "/static\\1/graffoo.html", True),
        ("^(/(lenses-paper|slam|vao|css|img|2008|2009|2010|2011|2012|2013|2014|2015)/.*)$", "/static\\1", True)
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


class Ditto:
    def GET(self, params):
        if params is None or re.match("^/?$", params):
            web_logger.mes()
            return render.ditto()
        else:
            translated_string = URIDecoder().decodes(params[1:])
            req = requests.get("http://eelst.cs.unibo.it/apps/LODE/extract?" + translated_string)

            web.header('Access-Control-Allow-Origin', '*')
            web.header('Access-Control-Allow-Credentials', 'true')
            web.header('Content-Type', 'text/html')
            web_logger.mes()
            return req.text


class LODE:
    def GET(self, params):
        if params is None or re.match("^/?$", params):
            web_logger.mes()
            return render.lode()
        else:
            translated_string = URIDecoder().decodes(params[1:])
            req = requests.get("http://eelst.cs.unibo.it/apps/LODE/extract?" + translated_string)

            web.header('Access-Control-Allow-Origin', '*')
            web.header('Access-Control-Allow-Credentials', 'true')
            web.header('Content-Type', 'text/html')
            web_logger.mes()
            return req.text


if __name__ == "__main__":
    app = web.application(rewrite.get_urls(), globals())
    app.run()