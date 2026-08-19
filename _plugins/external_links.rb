# _plugins/external_links.rb
# After each page/post renders, add target="_blank" rel="noopener" to every
# link that points off-site (absolute http(s) URL not on joelgaff.com).
# Links that already carry a target attribute are left alone.
EXTERNAL_LINK_RE = /<a\s+(?![^>]*\btarget=)(?=[^>]*\bhref="https?:\/\/(?!(?:www\.)?joelgaff\.com)[^"]*")([^>]*)>/i

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  next unless doc.output_ext == ".html"
  doc.output = doc.output.gsub(EXTERNAL_LINK_RE) do
    %(<a target="_blank" rel="noopener" #{Regexp.last_match(1)}>)
  end
end
