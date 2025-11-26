---
title: " "
description: Shiny dulls. Boring endures.
layout: splash
share: true
header:
  overlay_filter: 0.7
  overlay_color: "#000000"
  overlay_image: /assets/images/sensible_header.png
  caption: "bor·ing (adj.): reliably predictable; free of drama."
---

## Why BoringOps

Exciting infrastructure means outages, drama, and late-night calls.

Boring is **predictable**. Boring is **stable**. 
Boring is a good nights sleep during a change window.

BoringOps is the discipline of making systems so dull they
disappear, freeing teams to **build what matters**.

## The BoringOps Law of Excitation

 The more exciting a system is, the less reliable it is.

 The less reliable it is, the more heroics it demands.
 
 The more heroics it demands, the closer the operation drifts toward failure.

## Latest Articles

<ul class="articles-list">
{% for post in site.articles limit:5 %}
  <li>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <span class="post-meta">{{ post.author }} • {{ post.date | date: "%b %-d" }}</span>
    <blockquote class="post-excerpt">{{ post.excerpt }}</blockquote>
  </li>
{% endfor %}
</ul>

<div class="articles-footer">
  <a href="/articles/" class="view-all-articles">View all articles →</a>
</div>

## The Closing Charge
We don’t worship boredom because it is dull.  

We choose boredom because it is freedom from **chaos**, freedom from **heroics**, freedom to **build what matters**.  

Boring isn’t the enemy of progress.  

**Boring is the engine of progress**.  
