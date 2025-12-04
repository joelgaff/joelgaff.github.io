# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal blog and portfolio site for Joel Gaff, Jr. The site uses the "no-style-please" theme and is hosted on GitHub Pages at joelgaff.com.

## Architecture

### Jekyll Structure
- **Theme**: Uses `no-style-please` gem-based theme with dark mode appearance
- **Content**: Blog posts are stored in `_posts/` with `YYYY-MM-DD-title.md` naming convention
- **Configuration**: `_config.yml` contains site settings, theme config, and build options
- **Navigation**: Controlled by `_data/menu.yml` which defines the site menu structure
- **Permalinks**: Posts use `/blog/:title/` format (important for SEO - maintains Google rankings)
- **Default Layout**: All posts automatically use the "post" layout (configured in front matter defaults)

### Key Files
- `index.html`: Simple landing page with bio and navigation links
- `blog.html`: Main blog listing page showing all posts with excerpts (zolkos.com-inspired minimal style)
- `about.md`: About page with contact information
- `archive.html`: Alternative archive view of all posts
- `_includes/head.html`: Custom HTML head includes
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
bundle config set --local path 'vendor/bundle'
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

### Draft Posts
```bash
bundle exec jekyll serve --drafts
# Include posts from _drafts/ directory
```

## Ruby Environment
- Ruby version: 3.3.6 (specified in `.ruby-version`)
- Jekyll version: ~> 4.3
- Required gems: jekyll, jekyll-feed, no-style-please, webrick

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

### Theme Configuration
The theme is configured in `_config.yml` under `theme_config`:
- `appearance`: Set to "dark" (can be "light", "dark", or "auto")
- `back_home_text`: Navigation text for home link ("..")
- `date_format`: How dates are displayed ("%B %-d, %Y")
- `show_description`: Whether to show site description (true)

## Git Workflow
- Main branch: `main`
- Site is deployed via GitHub Pages
- CNAME file configures custom domain (joelgaff.com)
