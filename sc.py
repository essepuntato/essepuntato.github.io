#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
from requests import get
from glob import glob
from os import sep, makedirs
from os.path import exists
from re import search
from web import badrequest
from time import time


class Store:
    def __init__(self, c_dir, base_url, timeout=60, max_mb=5):
        self.dir = c_dir + ("" if search("[/\\\]$", c_dir) else sep)
        if not exists(self.dir):
            makedirs(self.dir)

        self.base_url = base_url if base_url.endswith("/") else base_url + "/"
        self.timeout = timeout
        self.max = (1024 * 1024) * max_mb

    def store(self, u, ext=""):
        try:
            req = get(u, timeout=self.timeout, stream=True,
                      headers={"accept": "application/rdf+xml, text/turtle, application/ld+json, "
                                         "application/json, text/plain"})
            req.raise_for_status()

            content = ""

            if req.status_code == 200:
                size = 0
                start = time()

                for chunk in req.iter_content(1024, decode_unicode=True):
                    if time() - start > self.timeout:
                        raise badrequest("Timeout reached (max %s seconds)." % self.timeout)

                    size += len(chunk)
                    if size > self.max:
                        raise badrequest("File too large, you can upload files up to %s MB." % self.max_mb)

                    content += chunk

            return self.store_file(content, ext)
        except:
            pass  # do nothing

    def store_file(self, content, ext=""):
        try:
            if content is not None:
                n = -1
                for cf in sorted(glob(self.dir + "[0-9]")):
                    n += 1

                n = (n + 1) % 10
                f = str(n) + ext

                with open(self.dir + f, "w") as fs:
                    fs.write(content)

                return self.base_url + self.dir.replace("\\", "/") + f
        except:
            pass  # do nothing


