---
layout: archive
author_profile: true
permalink: /pub/
title: Publications
---

The (hopefully complete) list of my publications, as listed in my [Zotero account](https://www.zotero.org/essepuntato/).

<div class="loader"></div>

<div id="pub"></div>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script>
$.get("https://api.zotero.org/users/5306497/publications/items?include=bib&style=https://essepuntato.it/assets/csl/apa.csl&linkwrap=1&sort=date&itemType=-presentation&limit=100", function( data ) {
    $.each(data, function(idx, val) {
        $(".loader").hide();
        $("#pub").append(val.bib);
    });
});
</script> 