---
title: "cucamonga.app now pings me for every signup"
date: 2026-08-14
categories:
  - "blog"
tags:
  - "rails"
  - "cucamonga"
  - "telegram"
  - "indie"
---

Small ship. When someone signs up for cucamonga.app, my phone buzzes with a Telegram message from a dedicated bot I set up.

It's the kind of thing that only matters to me now when the product is small. If the app takes off, I'll likely turn these notifications off. But at the moment the emotional payoff of these pings is high.

## Why I wanted this

Between publish and check-stats-a-week-later, there's a long fuzzy void where I have no idea if anything is landing.

A signup is a real signal. Someone read something, tried the product, gave me their email, and made an account. That's not a stat, that's a person.

I want the ping the moment it happens. Not tomorrow morning in a digest email. Now.

## How it works

Under the hood: a small background job on the Rails side that fires whenever a new user is created, packages up a short summary, and sends it to Telegram over their bot API. Around sixty lines of code, plus tests.

A few details worth naming:

- The job only fires in production. Dev signups, test signups, seeded data - none of them buzz my phone. Local iteration is already noisy enough.
- It only fires after the database commit. If a signup gets rolled back for any reason, no ghost ping.
- If Telegram is having a bad day, the job retries a few times, then quietly gives up and logs it. A failed notification should never block or retry a real user's signup.

Nothing exotic. Just quiet, defensive plumbing.

## The nice surprise

Setting up the Telegram bot was faster than I expected. Two minutes with @BotFather, one HTTP call to test, done. Bot tokens are just strings, chat IDs are just numbers. There's nothing you need to configure on Telegram's side beyond creating the bot itself.

Compared to setting up transactional email (deliverability, SPF/DKIM/DMARC, verified domains), Telegram bots are a shockingly easy notification channel for solo-builder use cases. Not for user-facing notifications. I'm not asking Cucamonga users to install Telegram. But for the "ping me, the operator" use case, it's ideal.

Onwards.
