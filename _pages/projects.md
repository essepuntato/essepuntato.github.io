---
layout: archive
author_profile: true
permalink: /project/
title: Projects
---

This page lists some of the main projects and initiatives in which I am directly involved in.

{% for prj in site.data.projects %}
<div class="prj">
    <img src="{{ prj.img }}" />
    <p>
        <a href="{{ prj.url }}>"<strong>{{ prj.name }}.</strong></a> 
        {{ prj.description }}
    </p>
</div>
{% endfor %}