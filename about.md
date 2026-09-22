---
title: About
permalink: /about/
---

{% include page-hero.html title="Self-taught. Solo. Shipping." %}

<section class="about-intro">
  <img src="{{ "/images/profile.jpg" | relative_url }}" alt="Joel Gaff, Jr." class="avatar">
  <div class="post-content">
    <p>I'm Joel Gaff, Jr., a self-taught Ruby on Rails developer in Portland, Oregon, USA. For the past four-plus years I've designed, built, and operated nearly a dozen production Rails apps. Solo. I manage every migration, the DNS records, and deploys.</p>
    <p>I borrow a lot from 37signals: a single, maintainable, Rails monolith, Hotwire for the front end, and almost always SQLite. I like to write about what I'm working on, too.</p>
    <p class="rails-guild-badge"><a href="https://railsguild.com/developers/joel-gaff"><img src="https://railsguild.com/developers/joel-gaff/badge.svg" alt="Joel Gaff, Jr. is Rails Guild member #0"></a></p>
  </div>
</section>

{% include numbered-section.html label="How I work" items=site.data.principles small=true %}

<section class="home-section">
  <p class="closing">Currently shipping {% include product-links.html last_sep=", and " %}, and looking for the next thing to build.</p>
  <p class="closing-cta"><a href="{{ "/hire/" | relative_url }}">Hire me &rarr;</a></p>
</section>
