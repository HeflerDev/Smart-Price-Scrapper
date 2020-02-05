require 'nokogiri'
require 'open-uri'

# rubocop:disable Metrics/MethodLength,Metrics/LineLength,Style/ClassVars

class KScrapper
  attr_accessor :prices_databank
  attr_reader :brute_collect

  @@prices_databank = {}
  @@storage = {}
  @@name_storage = {}
  @@search_container = []

  filter_data = lambda { |a| a.scan(/\d+[,.]\d+/).to_s.split('').map { |u| u == ',' ? '.' : u }.join('').scan(/\d+[,.]\d+/).map(&:to_f).inject { |k, z| (k + z) / 2 }

  def initialize(website, search_term)
    @website = open(website).read
    @search_term = search_term
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect_values = []
    @brute_collect_titles = []
    @brute_collect_logistics = []
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
      #Instance Gattering
      @brute_collect_values.push(price)
      @brute_collect_titles.push(title)
      @brute_collect_logistics
    end
  end

  def clean_data
    @brute_collect_values.map do |x|
      @clean_values.push()
      filter_data = ->(a) { } }
      @value_data.push(filter_data.call(x))
      filter_data.call(x)
    end
  end
end