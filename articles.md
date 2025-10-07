---
layout: archive
title: " "
permalink: /articles/
author_profile: false
entries_layout: grid
classes: wide
tags: [consistency, deployment, infrastructure]
header:
  overlay_filter: 0.7
  overlay_color: "#000000"
  overlay_image: /assets/images/sensible_header.png
  teaser: /assets/images/sensible_header.png
  caption: "bor·ing (adj.) — reliably predictable; free of drama."
---

{% for post in site.articles %}
  {% include archive-single.html type="grid" %}
{% endfor %}
