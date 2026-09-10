---
title: "Introducing the Omarchy Guild"
date: 2026-09-10
categories:
  - "blog"
tags:
  - "omarchy"
  - "linux"
  - "rails"
  - "indie"
---

Recently I launched a website called omarchyguild.com as a place for all contributors to [Omarchy](https://omarchy.org) to have their work featured and highlighted. The idea is that anybody who has a pull request, a plugin, or a theme can share those things, and the site will pull them all in automatically.

I've built it so that a user simply has to authorize omarchyguild.com to access their GitHub account. From there it can see what they've done related to Omarchy, and any work they've done on pull requests, themes, or plugins gets automatically pulled into their profile. Pull requests are imported and updated automatically as new work comes in while users manually add plugins and themes.

## The stack

- Rails 8, SQLite + Solid Queue/Cache/Cable, Hotwire, Propshaft + import maps, Minitest.
- Auth via email magic link with long-lived sessions.
- Deployed via [Hatchbox](https://hatchbox.io), Cloudflare in front, MailerSend for transactional emails. Solid Queue runs as its own Hatchbox process (`bin/jobs`) next to the web server.

## The leaderboard

The first of my favorite features is the leaderboard, which shows a ranking of people who have contributed PRs, themes, and plugins. You can break that down into all contributions combined (pull requests, themes, and plugins), or you can see separate views for just pull request rankings, theme rankings, and plugin rankings. That way you can see how the members of the guild rank based on those subcategories.

## The globe

Another great feature that I really enjoy is the globe, which is a visualization of the Earth with all the Omarchs on it. Users can choose to drop a dot on the globe where they're located. They don't have to, but they can, and then their name and their dot will appear on the globe. This way we can see where everybody in the Guild is and what the world looks like with contributors to Omarchy all over it.

## You don't have to be a contributor

On that note, you don't actually have to be a contributor to sign up for the site. You can simply be somebody who's interested. You can show off your setups as well, post images of your desktop, your cool computer, your cool setups, very similar to what we have going on in the Discord. You can post all of that here on the Omarchy Guild too.

## Where this fits with Discord

Discord is obviously THE place to chat and converse, and I don't currently have any features built on omarchyguild.com that allow communication. No like buttons, no chats, no communication. It's all just presentation. It brings all of these things together into one spot, because I didn't feel that the Discord group had a place to showcase a person's work in one single location.

Check it out at [omarchyguild.com](https://omarchyguild.com).
