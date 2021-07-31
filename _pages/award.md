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
        <a href="{{item.url}}">{{item.name}}</a><br />
        role: {{item.role}}<br />
        funded by: {{item.funder}}<br />
        {% if item.number != "" %}
        grant number: {{item.number}}<br />
        {% endif %}
        total amount: {{item.amount}}<br />
        period: from {{item.sdate}} to {{time.edate}}
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
