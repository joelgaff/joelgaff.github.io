# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal blog for Joel Gaff, Jr. The site uses the default **Minima** theme and is hosted on GitHub Pages at joelgaff.com.

## Architecture

### Jekyll Structure
- **Theme**: Uses default `minima` gem-based theme (v2.5.2)
- **Content**: Blog posts are stored in `_posts/` with `YYYY-MM-DD-title.md` naming convention
- **Configuration**: `_config.yml` contains minimal site settings
- **Permalinks**: Posts use `/blog/:title/` format (custom, to preserve Google rankings)
- **No custom layouts or includes**: Everything comes from the Minima theme

### Key Files
- `index.markdown`: Homepage using the `home` layout (automatically lists posts)
- `about.markdown`: About page with contact information
- `404.html`: Custom error page
- `_posts/`: All blog posts
- `images/`: All blog post images
- `_site/`: Generated static site output (excluded from git)

### Post Structure
Posts use YAML front matter with:
- `title`: Post title
- `date`: Publication date (YYYY-MM-DD)
- `categories`: Array of categories (typically "blog")
- `tags`: Array of tags for categorization

## Development Commands

### Setup
```bash
bundle install
```

### Local Development
```bash
bundle exec jekyll serve
# Site will be available at http://localhost:4000
```

### Build Site
```bash
bundle exec jekyll build
# Output goes to _site/ directory
```

### Watch Mode (auto-rebuild)
```bash
bundle exec jekyll serve --watch
# Jekyll automatically rebuilds when files change
```

## Ruby Environment
- Ruby version: 3.3.6 (specified in `.ruby-version`)
- Jekyll version: ~> 4.4.1
- Theme: minima ~> 2.5
- Plugins: jekyll-feed

## Bundle Configuration
- Gems are installed to `vendor/bundle/` (use `bundle exec` for commands)
- Gemfile.lock is excluded from git

## Content Guidelines

### Creating New Posts
1. Create file in `_posts/` with format: `YYYY-MM-DD-post-title.md`
2. Add front matter:
   ```yaml
   ---
   title: "Post Title"
   date: YYYY-MM-DD
   categories:
     - "blog"
   tags:
     - "tag1"
     - "tag2"
   ---
   ```
3. Write content in Markdown below front matter

### Adding Images
- Place images in `/images/` directory
- Reference in posts: `![alt text](/images/filename.jpg)`

## Git Workflow
- Main branch: `main`
- Site is deployed via GitHub Pages
- CNAME file configures custom domain (joelgaff.com)
- `.gitignore` excludes: `_site`, `.jekyll-cache`, `.sass-cache`, `.jekyll-metadata`, `vendor`
