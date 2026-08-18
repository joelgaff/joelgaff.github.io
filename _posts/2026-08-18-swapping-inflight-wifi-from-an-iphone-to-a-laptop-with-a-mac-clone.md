---
title: "Swapping inflight wifi from an iPhone to a laptop with a MAC clone"
date: 2026-08-18
categories:
  - "blog"
tags:
  - "linux"
  - "omarchy"
  - "networking"
  - "travel"
---

I flew Icelandair today, headed home from vacation in London, and redeemed a handful of airline points for a wifi pass. Redeemed it on my iPhone. That was the mistake.

The pass is apparently bound to whichever device you activate it on. Icelandair's portal has a "Swap Device" option, but it only works if you paid with a credit card and gave them an email at checkout. Points purchases don't create a lookup record, so the swap silently fails with "no device associated with this email." Poor error message, but Claude helped me figure it out.

I still wanted to use my laptop. I needed to install Omarchy Quattro, after all.

Claude said that the wifi pass follows the MAC address of the device, and the fix is to make the laptop present the iPhone's MAC.

Framework 13 running Omarchy 3.8.5, iwd for wifi set up. Here is what Claude cooked up that worked.

On the iPhone:

- Find the Wi-Fi address (not IP address)
- Toggle Wi-Fi off entirely so the AP can age out the association.

On the laptop, save your real MAC first:

```bash
cat /sys/class/net/wlan0/address
```

Then clone the iPhone's MAC and reconnect:

```bash
iwctl station wlan0 disconnect
sudo ip link set wlan0 down
sudo ip link set wlan0 address <iphone-mac>
sudo ip link set wlan0 up
ip link show wlan0 | grep link/ether
iwctl station wlan0 connect "Icelandair Internet Access"
```

Confirm the grep echoes the iPhone MAC and not your real one. If iwd overwrote it, check `/etc/iwd/main.conf` for `AddressRandomization=network` or `once` and comment it out.

Then re-point DNS at the portal gateway:

```bash
sudo resolvectl dns wlan0 172.19.0.1
sudo resolvectl domain wlan0 '~.'
```

That last part was needed because my `resolved.conf` had Cloudflare hardcoded in `DNS=`, which was overriding the network's own DNS and swallowing the portal redirect. Moving Cloudflare to `FallbackDNS=` is the real long-term fix for captive portals.

Before landing, restore everything:

```bash
sudo ip link set wlan0 down
sudo ip link set wlan0 address <your-real-mac>
sudo ip link set wlan0 up
sudo resolvectl revert wlan0
```

That revert matters. Skip it and the next network I try to join will look mysteriously broken, because wlan0 is still trying to reach a gateway at 35,000 feet.

## The gotchas that cost me the most time

- I typed the phone's IP where its MAC belonged. `ip` complained "must be 6 bytes." Bytes, not octets. IP is 4, MAC is 6.
- I dropped the `address` keyword a couple times. Without it, `ip link set wlan0 F6:4F:...` reads the MAC as a device name and returns "garbage." Always `ip link set dev wlan0 address <mac>`.
- iwd can silently rewrite your MAC back to the hardware one on connect if `AddressRandomization` is set. If your first clone succeeds and then the change disappears, that is why.

This kind of stuff is just magical. I wouldn't feel as confident messing with my Mac, but I feel a closer connection to my Linux machine, and know my way around the CLI much more comfortably (with plenty of help from Claude). I felt like a true hacker, doing something that I wasn't technically supposed to be able to do. Big win for us nerds.

Now off to explore [Quattro](https://github.com/basecamp/omarchy/releases/tag/v4.0.0).
