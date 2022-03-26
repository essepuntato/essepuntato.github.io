---
layout: archive
author_profile: true
permalink: /act/
title: Activities
---

This page lists various activities I am doing and have done in the past, according to the following categories:

* [institutional roles](#institutional-roles)
* [journals](#journals)
* [conferences](#conferences)
* [workshops](#workshops)
* [summer schools](#summer-schools)
* [teaching duties](#teaching-duties)

## Institutional roles
<ul>
{% for item in site.data.activities.institutional %}
    <li>
        {{item.role}}, <a href="{{item.website}}">{{item.institution}}</a>{% if item.behalfof %} (on behalf of {{item.behalfof}}){% endif %}, from {{item.start}} {% if item.end %} to {{item.end}}{% endif %}
    </li>
{% endfor %}
</ul>

## Journals
<ul>
{% for item in site.data.activities.journal %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>, ISSN: {{item.issn}}
    </li>
{% endfor %}
</ul>

## Conferences
<ul>
{% for item in site.data.activities.conference %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
    </li>
{% endfor %}
</ul>

## Workshops
<ul>
{% for item in site.data.activities.workshop %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
    </li>
{% endfor %}
</ul>

## Summer Schools
<ul>
{% for item in site.data.activities.school %}
    <li>
        {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
    </li>
{% endfor %}
</ul>

## Teaching duties
<ul>
{% for item in site.data.activities.teaching %}
    <li>
        <a href="{{item.url}}">{{item.name}}</a>, {{item.degree}}, academic year {{item.aa}}
    </li>
{% endfor %}
</ul>