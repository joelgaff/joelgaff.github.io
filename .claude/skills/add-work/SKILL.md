---
name: add-work
description: Add, remove, or reorder a product, app, or open-source project on joelgaff.com. Use whenever a new piece of work ships, an existing one changes description or ordering, or one is retired — the site renders these lists from data files, and this covers which file to edit and what a data edit does not reach.
---

# Adding a piece of work to joelgaff.com

The site renders every list of work from a data file. **Do not hand-edit the pages.**
If you find yourself writing a `<div class="numbered-row">` or a literal `01`, stop — you're
editing output, not source.

Pick the path that matches the work:

| Kind of work | Source of truth | How it gets there |
|---|---|---|
| A product of Joel's (a domain he runs) | `_data/products.yml` | Edit by hand |
| An open-source app, plugin, or merged PR | `_data/opensource.yml` | **Generated** — run `bin/sync-opensource` |

## A product → one entry in `_data/products.yml`

Three fields:

```yaml
- name: example.com          # the domain, lowercase — this is the display text
  url: https://example.com
  detail: >-
    One paragraph for /work. Product voice, no first person. End with the stack.
```

That single entry feeds four surfaces, all generated:

- the homepage hero tagline (`_includes/product-links.html`, inline "a, b & c" list)
- homepage "Current work" — address plus a `Learn more →` link to `/work/#<slug>`
- `/work` — the `detail` paragraph plus a `Visit <name> →` link
- `/about`'s closing line — "Currently shipping a, b, and c"

A fifth surface is **not** generated and must be updated by hand — see `_config.yml` below.

**Position in the file is the order on every page.** Newest or most prominent first. There is
no renumbering: `_includes/numbered-section.html:48` derives `01`, `02`… from `forloop.index`.

**`name` is also the anchor.** `/work/#<slug>` comes from `name | slugify`, and the homepage
links to it. Both regenerate together, so internal links can't break — but renaming does break
anyone's existing bookmark or inbound link.

**Retiring a product:** delete the entry. It disappears from all four surfaces at once. Leave
`_posts/` alone — posts are historical record, never retro-edited.

YAML gotchas in this file:

- Use `>-` for `detail`. Plain multi-line text will not fold the way you expect.
- **Quote any value containing ` #`** — YAML reads it as a comment. `_data/principles.yml` has
  `title: "Customer #1"` for exactly this reason; an unquoted version silently rendered
  as "Customer".
- HTML entities are fine and pass through (`&amp;`, `&middot;`).

## Open-source work → run the script, don't edit the file

`_data/opensource.yml` carries a "do not hand-edit" header and is regenerated wholesale:

```bash
bin/sync-opensource    # needs `gh` authenticated; writes _data/opensource.yml
```

It pulls three sections from GitHub, so **the text comes from each repo's description field,
not its README**. To fix wording on `/open-source`, edit the repo description on GitHub and
re-run — don't patch the YAML.

- **apps** — only the repos named in the `APPS` constant at the top of the script. Listed by
  hand because there's no pattern to match. Name the app repo only, never its landing-site or
  ops repo. Adding an app = one entry in `APPS`, then re-run.
- **plugins** — auto-discovered: non-fork public repos matching `/\Aomarchy-/`. A new plugin
  needs no code change at all. Widen `PLUGIN_NAME` if one ever lands outside that namespace.
- **merged** — auto-discovered: Joel's merged PRs in repos he doesn't own.

A weekly workflow (`.github/workflows/sync-opensource.yml`, Mondays 13:00 UTC) runs the same
script, commits only if the file changed, and then dispatches the Pages deploy itself —
GitHub's recursion guard means a `GITHUB_TOKEN` push triggers nothing. So **a plugin or merged
PR reaches the site on its own.** Run the script locally only to publish sooner.

Re-running with nothing new is a true no-op; there's deliberately no sync timestamp in the
file, because that alone would make every run a commit.

## What a data edit does NOT reach

Two surfaces fall outside the data files. Both need attention on every product change.

- **`_config.yml` → `tagline:`** — update this by hand, every time. It looks like dead config
  (no template references `site.tagline`), but **jekyll-seo-tag renders it as the `<title>`
  suffix on every page that has no title of its own** — the homepage, `/404.html`, and all 14
  pagination pages. It's the homepage `<title>`, so it's the most SEO-visible copy on the site.
  Verify with `grep -o '<title>[^<]*' _site/index.html`.

  It duplicates the hero's product list by hand, so it drifts silently — it had fallen out of
  order once already. Keep its membership and order matching `products.yml`. Keep it plain
  text: seo-tag strips HTML for the title, so link tags there do nothing. `&amp;` is correct
  (it's escaped HTML in the title, displayed as `&`).
- **`now.md`** — Joel's first-person prose. A new product may or may not belong there. **Ask.**
  Any edit must bump `last_modified_at` in the front matter to that day's date. It must never
  fall back to `site.time` — that's the build timestamp and silently re-dates the page on every
  deploy. (It did exactly that until 2026-09-11.)

Adding a whole new *page* (not a new product) also means a nav entry: the one-line string in
`_includes/header.html:9`. Nav is deliberately an explicit list, not derived from `site.pages`
— `vendor/` isn't in Jekyll's `exclude`, so `site.pages` is polluted and deriving it renders
garbage.

## Voice

- Product `detail` is product voice, third person, ending in the stack. Look at the neighbours
  in `products.yml` and match them.
- **If a post in `_posts/` announces the work, read it first** and take the stack and feature
  details from there. It's the accurate source — more so than the live site or memory.
- **Don't overclaim infrastructure.** State a deploy or host detail only if a post or Joel
  confirms it for *that* product. Ask rather than generalize from the other apps.

## Verify

```bash
bundle exec jekyll build    # must exit clean

# the new work should appear on every generated surface
grep -rln '<newdomain>' _site/ --exclude-dir=blog | sort
```

For a product, expect at minimum `_site/index.html`, `_site/work/index.html` and
`_site/about/index.html`. If `_config.yml`'s `tagline` was updated too, `_site/404.html`,
`_site/feed.xml` and `_site/page2`–`page14` also hit, via the `<title>`.

Rather than matching that list by eye, re-grep an **existing** product the same way: the new one
should hit exactly the same set of files. A diff between the two greps is the real signal.

Watch for a silently empty page: a duplicate top-level key in `_config.yml` makes the later one
win with no warning. A second `defaults:` block once dropped the layout default site-wide and
every page rendered with no header or nav, while the build still exited 0.

## Commit

Per `~/CLAUDE.md`: **no Claude attribution, no `Co-Authored-By`, no tool trailers, ever.**
Site deploys from `main` via `.github/workflows/jekyll.yml`, so pushing publishes.
