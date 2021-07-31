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
        <strong><a href="{{item.url}}">{{item.name}}</a></strong><br />
        <strong>role:</strong> {{item.role}}<br />
        <strong>funded by:</strong> {{item.funder}}<br />
        {% if item.number %}
        <strong>reference:</strong> {{item.number}}<br />
        {% endif %}
        <strong>total amount:</strong> {{item.amount}}<br />
        <strong>period:</strong> from {{item.sdate}} to {{item.edate}}
    </li>
{% endfor %}
</ul>

## Awards
<ul>
{% for item in site.data.awards %}
    <li>
        {{item.description}}, {{item.date}} <a href="{{item.url}}">{{item.name}}</a>
        {% if item.url %}
        - more info available <a href="{{item.url}}"online</a>
        {% endif %}
    </li>
{% endfor %}
</ul>
