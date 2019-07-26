---
layout: archive
author_profile: true
permalink: /prj/
title: Projects
---

This page lists some of the main projects and initiatives in which I am directly involved in.

{% for prj in site.data.projects %}
<div class="prj">
    <img src="{{ prj.img }}" />
    <p>
        <strong><a href="{{ prj.url }}">{{ prj.name }}</a> | </strong> 
        {{ prj.description }}
    </p>
</div>
{% endfor %}