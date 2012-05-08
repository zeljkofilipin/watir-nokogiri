require "watir-webdriver"
browser = Watir::Browser.new :firefox

folder = Dir.pwd
browser.goto "file://#{folder}/table.html"

require "benchmark"
require "nokogiri"

Benchmark.bm do |x|
  x.report("nokogiri") do
    Nokogiri::HTML(browser.html).css("td").each do |td|
      if td.text == "999"
        css = td.css_path
        browser.element(css: css).wd.location_once_scrolled_into_view
        browser.element(css: css).flash
        break
      end
    end
  end
end

Benchmark.bm do |x|
  x.report("watir") do
    browser.td(text: "999").wd.location_once_scrolled_into_view
    browser.td(text: "999").flash
  end
end

browser.close
