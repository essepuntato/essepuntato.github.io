---
layout: archive
author_profile: true
permalink: /act/
title: Activities
---

This page lists various (editorial, reviewing, teaching) activities I have done in the past.

## Journals
{% for item in site.data.activities.journal %}
<p>
    {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>, ISSN: {{item.issn}}
</p>
{% endfor %}

## Conferences
{% for item in site.data.activities.conference %}
<p>
    {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
</p>
{% endfor %}

## Workshops
{% for item in site.data.activities.workshop %}
<p>
    {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
</p>
{% endfor %}

## Summer Schools
{% for item in site.data.activities.school %}
<p>
    {{item.role}}, <a href="{{item.url}}">{{item.name}}</a>
</p>
{% endfor %}

## Other teaching duties
{% for item in site.data.activities.teaching %}
<p>
    <a href="{{item.url}}">{{item.name}}</a>, {{item.degree}}, academic year {{item.aa}}
</p>
{% endfor %}