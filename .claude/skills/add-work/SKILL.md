---
name: add-work
description: Add, remove, or reorder a product/project across joelgaff.com. Use whenever a new piece of work ships, an existing one changes description or ordering, or one is retired — it lists every page that must stay in sync so no surface is left stale.
---

# Adding a piece of work to joelgaff.com

A product appears in **six** places. Miss one and the site contradicts itself.
Work the checklist top to bottom; rebuild and verify at the end.

## The checklist

| # | File | What lives there | Style |
|---|------|------------------|-------|
| 1 | `_layouts/home.html` — hero tagline | Inline "Shipping a, b & c." link list | Domain names, `target="_blank" rel="noopener"` |
| 2 | `_layouts/home.html` — "Current work" | Numbered row: domain heading + one-line blurb | Product-voice, no first person |
| 3 | `work.md` | Numbered row: domain heading, blurb **with stack**, `Visit x →` link | Longest of the three blurbs |
| 4 | `hire.md` — "Recent ships" | Numbered row titled by **accomplishment**, not product name | See voice note below |
| 5 | `about.md` — closing line | "Currently shipping a, b, and c, …" | Prose list |
| 6 | `_config.yml` — `tagline` | Mirrors the hero tagline | **Currently unused** by any template; keep in sync anyway or delete it |

## Rules

- **Numbered rows are hand-numbered.** `<span class="num">01</span>` is literal text, not
  generated. Inserting at the top means renumbering every row below it in that section.
- **Keep ordering consistent across pages.** Joel puts the newest/most prominent work at `01`.
  If it leads on the homepage, it leads on `work.md` and `hire.md` too.
- **`hire.md` has a different voice.** Rows are titled by what was accomplished
  ("A rebrand shipped from a phone"), not by product name. Write the capability the entry
  demonstrates to a prospective client, then name the product inside the paragraph.
- **Watch aggregate claims.** `hire.md` carries a "Three products, run end to end" row —
  the count and the product list in it must both be updated. Grep for `products, run end to end`.
- **Don't overclaim infrastructure.** Only state a deploy/host detail if a blog post or Joel
  confirms it for *that* product. Ask rather than generalize from the other apps.
- **`now.md` is Joel's first-person prose — do not edit it silently.** If a new product belongs
  there, ask. Any edit to it must also bump `last_modified_at` in its front matter (see below).
- **`_posts/` mentions are historical.** Never retro-edit a published post to add new work.

## Source the blurb from the announcement post

If there's a post in `_posts/` announcing the work, read it first and take the stack and
feature details from there rather than from the live site or memory. It's the accurate source.

## The `/now` page date

`now.md` shows `last_modified_at` from its front matter. It must **never** fall back to
`site.time` — that's the build timestamp and silently re-dates the page on every deploy.
If you edit `/now` content, bump `last_modified_at` to that day's date.

## Verify

```bash
bundle exec jekyll build          # must exit clean
grep -rn '<newdomain>' --include='*.md' --include='*.html' --include='*.yml' . \
  | grep -v _site/ | grep -v vendor/ | grep -v '^./_posts'
```

Expect a hit for every checklist row above. Then re-grep an **existing** product the same way —
the new one should appear in the same set of files.

## Commit

Per `~/CLAUDE.md`: **no Claude attribution, no `Co-Authored-By`, no tool trailers, ever.**
Site deploys from `main` via GitHub Actions (`.github/workflows/jekyll.yml`), so pushing publishes.
