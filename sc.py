#!/usr/bin/python
# -*- coding: utf-8 -*-
import re
from requests import get


class Store:
    def __init__(self, c_dir, base_url):
        self.dir = c_dir
        self.base_url = base_url if base_url.endswith("/") else base_url + "/"

    def store(self, u, ext=""):
        req = get(u)
        f = ""

        # TODO: check max size

        return self.base_url + self.dir.replace("\\", "/") + f

