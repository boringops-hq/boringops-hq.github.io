---
layout: default
title: "BoringOps: All Article Tags"
permalink: /tags/
---

# Article Topics and Disciplines

The BoringOps philosophy is built on core principles. Explore all articles by topic to find the foundational pieces on **consistency, incentives, and stability.**

---

{% assign sorted_tags = site.tags | sort %}

{% for tag in sorted_tags %}
  {% assign tag_name = tag | first %}
  {% assign posts = tag | last %}

  <a name="{{ tag_name | slugify }}"></a>
  
## {{ tag_name | capitalize }} ({{ posts.size }})
  
  <ul class="tag-list">
    {% for post in posts %}
      {% assign sorted_posts = posts | sort: "date" | reverse %}
    {% endfor %}

    {% for post in sorted_posts %}
      <li>
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        <span class="post-meta">
          — <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time>
        </span>
      </li>
    {% endfor %}
  </ul>
  
  <!-- {% if forloop.last == false %}
    ---
  {% endif %} -->

{% endfor %}