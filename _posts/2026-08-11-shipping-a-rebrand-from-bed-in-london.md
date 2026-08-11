---
title: "Shipping a rebrand from bed in London"
date: 2026-08-11
categories:
  - "blog"
tags:
  - "rails"
  - "deployment"
---

I moved my trips app to a new domain last night while lying in bed on vacation. Kids were finally asleep. I was on my phone. I couldn't help it.

Here is the whole thing, in the order it happened, because I think this is what modern Rails deployment can look like now, and it's worth writing down.

## The setup

The trips app has lived at trips.joelgaff.com for a while. It's a subdomain on my personal domain. It's fine, but the app has outgrown it. I rebranded the app to be called Cucamonga, and cucamonga.app is its new home. Time to move it over.

But I'm in London. On vacation. In bed. On my phone.

I only need three tools:

1. **Cloudflare**: where my DNS lives
2. **Hatchbox**: where the app runs
3. **GitHub Mobile App**: where the code lives

That's essentially the entire deploy pipeline. Rails 8, SQLite, Hotwire, one Hetzner box behind Caddy, auto-deploy on push to master. It's boring in the best way.

## Step 1: DNS

Open Cloudflare. Add two records:

- `A cucamonga.app` → server IP
- `CNAME www.cucamonga.app` → cucamonga.app

Grey cloud, not orange. Caddy needs to see real origin traffic to provision certs, so the Cloudflare proxy stays off. Save. DNS propagates in about ten seconds because Cloudflare doesn't mess around.

## Step 2: Hatchbox

Open Hatchbox on my phone. Trips app → Domains → Add Domain → `cucamonga.app`. Repeat with `www.cucamonga.app`. Save.

Caddy on the server immediately went and provisioned a Let's Encrypt cert for the new hostnames. This is normally the part where you'd go get a coffee. I'm lying in bed, so I scroll on X for a few minutes. On modern Rails hosting, it's a background job you notice by accident when it finishes.

## Step 3: The 403

I hit https://cucamonga.app expecting the app.

I got a 403.

DNS was correct. The cert was valid. The app was running. And it was refusing me.

Took me a minute to recall what was happening. Didn't even need to ask Claude.

Rails 8 is paranoid about host headers by default. `ActionDispatch::HostAuthorization` checks every request's Host header against your allowlist in `config/environments/production.rb`, and if it's not on the list, you get a 403. This is the correct behavior. DNS rebinding attacks are real. But it also means adding a new domain requires a code change.

## Step 4: The one-file patch

Open the GitHub app on my phone. Navigate to `config/environments/production.rb`. Tap the pencil icon. Find the `config.hosts` block:

```ruby
config.hosts = [
  "trips.joelgaff.com",
  /.*\.joelgaff\.com/,
  "cucamonga.io",
  "www.cucamonga.io",
  /.*\.hatchboxapp\.com/
]
```

Add two lines:

```ruby
"cucamonga.app",
"www.cucamonga.app",
```

Save. Commit to master.

## Step 5: Hatchbox again

Push to master triggers auto-deploy. Hatchbox pulls, builds, restarts. About 90 seconds. Refresh cucamonga.app.

200.

Whole thing, phone in hand: about 15 minutes.

## The point

It's not that I did anything clever. It's that the tools are good enough now that this is what shipping a rebrand looks like. One config file. No rebuild. No downtime. One commit. Thumb typing.

I'm not saying you should ship from vacation. I am saying this. On a mature Rails 8 + Hatchbox stack, the friction between "I want to do a thing" and "the thing is live in production" has collapsed to almost nothing. On a phone. In bed. In a foreign country.

Small ship. Now back to my tea.
