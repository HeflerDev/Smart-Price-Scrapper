#first import nokogiri
require 'nokogiri'
#then import rest-client
require 'rest-client'

html = RestClient.get('www.blackbytes.info')
doc = Nokogiri::HTML.parse(html)

articles = doc.css('.tve-post-grid-title')

articles.each do |article|
  p article.css('a').text
end