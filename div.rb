require "watir-webdriver"
browser = Watir::Browser.new :firefox

folder = Dir.pwd
browser.goto "file://#{folder}/div.html"

require "benchmark"
require "nokogiri"

Benchmark.bm do |x|
  x.report("nokogiri") do
    Nokogiri::HTML(browser.html).css("div[id ^= 'id']").each do |div|
      if div["id"] == "id999"
        css = div.css_path
        browser.element(css: css).wd.location_once_scrolled_into_view
        browser.element(css: css).flash
      end
    end
  end
end

Benchmark.bm do |x|
  x.report("watir") do
    browser.divs(id: /^id/).each do |div|
      if div.id == "id999"
        div.wd.location_once_scrolled_into_view
        div.flash
      end
    end
  end
end

browser.close
