require 'nokogiri'
require 'open-uri'

# rubocop:disable Metrics/MethodLength,Metrics/LineLength,Style/ClassVars

class KScrapper
  attr_accessor :prices_databank
  attr_accessor :brute_collect

  @@prices_databank = {}
  @@storage = {}
  @@name_storage = {}
  @@search_container = []

  def initialize(website, search_term)
    @website = open(website).read
    @search_term = search_term
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect = [1,2]
    @clean_values = []
    @name_data = []
    @value_data = []
  end

  # Method that Collects and return data in form of array.

  def collect_data
    #push value to maintain track of what's happening
    @@search_container.push(@search_term)
  
    @parsed_content.css('.s-item__wrapper').each do |row|
      title = row.css('.s-item__title').inner_text
      status = row.css('.SECONDARY_INFO').inner_text
      price = row.css('.s-item__price').inner_text
      logistic = row.css('.s-item__logisticsCost').inner_text
      sold = row.css('.NEGATIVE').inner_text
      @name_data.push(title)
      @brute_collect.push(price)
    end
  end
end