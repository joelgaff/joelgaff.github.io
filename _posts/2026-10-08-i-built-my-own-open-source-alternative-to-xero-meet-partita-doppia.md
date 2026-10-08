---
title: "I Built My Own Open-Source Alternative to Xero: Meet Partita Doppia"
date: 2026-10-08
categories:
  - "blog"
tags:
  - "rails"
  - "indie"
  - "open-source"
---

An idea for this app has always been in the back of my mind, but before AI-assisted development I would never have thought of tackling it myself. It just would not have been worth it to build. I would have stuck with my $25 a month plan with xero.com and moved on.

![The dashboard in Partita Doppia](/images/partita-doppia-dashboard.png)

The nudge that actually got me going came from Wes Grimes ([@ncfrontiersman](https://x.com/ncfrontiersman)). He mentioned, tongue in cheek, making something called OmaBudget for Omarchy. I bit, and said "Yes, I need this for Rails!"

I've used xero.com as my small business accounting software for the last eight or nine years. One of the nice things about Xero is that they have a great CLI and API. So I knew that if I wanted to transfer all of my data from Xero over to my new application, it would be relatively easy. And that was the case.

I got started by giving Claude some general prompts and some screenshots from Wes' idea, and told it that I would be building an application similar to Xero. I wanted to maintain as much of the functionality as I could, so the switch would be smooth.

This part still amazes me: it is absolutely incredible how well Claude can build a clone like this, especially when the app you are copying from gives you a CLI or an API. That access lets Claude dig deep and actually see what is happening inside the application, rather than guessing from a features page on a website. It is a completely different level of understanding.

I didn't build it in one sitting. It came together over several weeks, a day here and a day there, with three or four concerted long sessions where I really got into the groove. After enough iterating, fine-tuning, and chasing down small bugs, I finally had a stable release.

One big decision I made early on was to use the [delegated type](https://dev.37signals.com/the-rails-delegated-type-pattern/) architecture. This pattern scales well when you have many items that share a common core but differ in the details. Think bills, invoices, purchase orders, and so on. At their heart they're all the same thing: a document that captures some kind of transaction. But each one has its own edges and specifics.

On the name: I initially called it Ledger, but that namespace felt pretty crowded. So I brainstormed some options with Claude and settled on Partita Doppia. It is Italian for double-entry bookkeeping, and I liked both the sound of it and the Italian vibe.

I've open-sourced the code on GitHub. Anybody who wants to can go clone the repo and use it themselves. At the moment I have pull requests closed, because I'm still working on it and moving pretty fast. But the issues board is open for anyone who wants to give feedback or finds bugs. Once I slow development down a little and get to a more stable place, I will happily open up pull requests and make this a project others can contribute to as well.

I don't have a definite roadmap for where I'll take things, but I'm tweaking and building features as I use the app myself, integrating things as I find what needs fixing or adding. And as of today, I have essentially switched over to Partita Doppia as my daily driver for accounting. I still maintain my Xero subscription, and probably will at least through the end of this year, but my day-to-day is now the Italian way.

Find Partita Doppia here: [partitadoppia.app](https://partitadoppia.app/)
