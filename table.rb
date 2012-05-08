require "watir-webdriver"
browser = Watir::Browser.new :firefox

folder = Dir.pwd
browser.goto "file://#{folder}/table.html"

require "benchmark"
require "nokogiri"

p Benchmark.measure {Nokogiri::HTML(browser.html).css("td").each {|td| p td.text}}
p Benchmark.measure {browser.table.tds.each {|td| p td.text}}

browser.close
