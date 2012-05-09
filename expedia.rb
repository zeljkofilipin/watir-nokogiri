require "watir-webdriver"
browser = Watir::Browser.new :firefox

browser.goto "http://www.expedia.com/Flights-Search?trip=roundtrip&leg1=from:SEA,to:SFO,departure:11%2F11%2F2012TANYT&leg2=from:SFO,to:SEA,departure:11%2F16%2F2012TANYT&passengers=children:0,adults:2,seniors:0,infantinlap:Y&options=cabinclass:coach,nopenalty:N,sortby:price&mode=search"

require "benchmark"
require "nokogiri"

Benchmark.bm do |x|
  x.report("nokogiri") do
    Nokogiri::HTML(browser.html).css("div[id ^= 'flightModule']").each do |div|
      if div["id"] == "flightModuleControl38"
        css = div.css_path
        browser.element(css: css).wd.location_once_scrolled_into_view
        browser.element(css: css).flash
      end
    end
  end
end

Benchmark.bm do |x|
  x.report("watir") do
    browser.divs(id: /^flightModule/).each do |div|
      if div.id == "flightModuleControl38"
        div.wd.location_once_scrolled_into_view
        div.flash
      end
    end
  end
end

browser.close
