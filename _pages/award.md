---
layout: archive
author_profile: true
permalink: /grt/
title: Grants and awards
---

This page lists the the grants and award I have received during the past years. 

* [grants](#grants)
* [awards](#awards)

## Grants
<ul>
{% for item in site.data.grants %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>, ISSN: {{item.issn}}
    </li>
{% endfor %}
</ul>

## Awards
<ul>
{% for item in site.data.activities.awards %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
    </li>
{% endfor %}
</ul>