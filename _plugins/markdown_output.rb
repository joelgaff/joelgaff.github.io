# _plugins/markdown_output.rb
# After the site is written, drop a raw-markdown sibling next to every post:
#   /blog/some-title/  ->  /blog/some-title.md
# Requires building with GitHub Actions (custom plugins don't run on the
# default GitHub Pages build).
Jekyll::Hooks.register :site, :post_write do |site|
  site.posts.docs.each do |post|
    raw = File.read(post.path).sub(/\A---.*?---\s*/m, '')
    header = "# #{post.data['title']}\n\n"
    header << "Date: #{post.data['date'].strftime('%Y-%m-%d')}\n"
    tags = Array(post.data['tags'])
    header << "Tags: #{tags.join(', ')}\n" unless tags.empty?
    header << "URL: #{site.config['url']}#{post.url}\n\n---\n\n"
    dest = File.join(site.dest, post.url.sub(%r{/\z}, '') + '.md')
    FileUtils.mkdir_p(File.dirname(dest))
    File.write(dest, header + raw)
  end
end
