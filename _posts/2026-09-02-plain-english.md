---
title: "Plain English"
date: 2026-09-02
categories:
  - "blog"
tags:
  - "omarchy"
  - "linux"
  - "indie"
---

The other day I was working on my Framework 13 and the fans kicked in, which was atypical. I opened btop and looked through all the things that were in there, but I couldn't easily, quickly find what the culprit was. I wanted something just to tell me, in plain English, what was happening, and why my laptop was seemingly acting up.

So, I did what anyone using [Omarchy](https://omarchy.org) these days would do, and I built a plugin.

I call it Omarchy Plain English.

It's a plugin that reads your system stats and translates what's going on there into plain English. It doesn't use any AI. It just has prescribed verbiage for different scenarios. It lives in your top bar and you can click it and see, in plain English, what's happening in your system. If anything is going wonky, it'll tell you. If everything is cool, it'll tell you. That's simple.

Sure, I could learn btop better, but sometimes I just want a quick answer to "why is my laptop running hot?" The laptop has all the data, and now it can easily tell me why.

Check it out here: [https://github.com/joelgaff/omarchy-plain-english](https://github.com/joelgaff/omarchy-plain-english)

P.S. - my Framework was running hot because the Bluetooth service was stuck on something and using an entire core. Claude helped me debug fix. What a time to be alive.
