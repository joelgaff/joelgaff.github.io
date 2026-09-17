---
title: "Omarchy Hatchbox Plugin"
date: 2026-09-17
categories:
  - "blog"
tags:
  - "omarchy"
  - "linux"
  - "deployment"
  - "indie"
---

I wanted a way to see the status of my Hatchbox apps at a glance without leaving my [Omarchy](https://omarchy.org) desktop: their deploy state, whether a deploy failed, whether one is in progress. I also wanted to be able to deploy, restart, or jump straight to the app on [Hatchbox.io](https://hatchbox.io). Omarchy didn't have anything for that, so I built a plugin.

![The Omarchy Hatchbox plugin listing every app with deploy, restart, and open buttons](/images/omarchy-hatchbox-plugin.png)

It's simple. It lists every app on your Hatchbox account, each with small buttons to deploy, to restart, or to open the app and dig into its finer settings on Hatchbox.io itself. It's a quick place to see when each app was last deployed and what state it's in.

When I push to GitHub and want to know if that deploy is actually done, I don't have to open Hatchbox at all. I just click the little icon in the Omarchy top bar and the state is right there. I added some fun flair to the deploy stage animations, too.

<video autoplay loop muted playsinline preload="metadata" width="100%" style="max-width:100%;height:auto;">
  <source src="/images/omarchy-hatchbox-plugin-animations.mp4" type="video/mp4">
</video>

[Here's the link to the plugin](https://plugins.omarchy.org/plugin.html?id=joelgaff.hatchbox) on plugins.omarchy.org.
