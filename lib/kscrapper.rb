require 'nokogiri'
require 'open-uri'

# rubocop:disable Metrics/MethodLength,Metrics/LineLength,Style/ClassVars

class KScrapper
  attr_accessor :products_databank
  attr_reader :brute_collect_values
  attr_reader :clean_values

  @@search_history = []
  @@products_databank = {}
  def initialize(website, search_term)
    @website = open(website).read
    @search_term = search_term
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect_values = []
    @brute_collect_titles = []
    @brute_collect_logistics = []
    @clean_values = []
    @clean_logistics = []
    @name_data = []
    @value_data = []
  end

  def collect_data
    #Assign values to instance variables
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
      @brute_collect_logistics.push(logistic)
    end
  end
  #Wipe the garbage from the number string to work it as floats
  def clean_data
    filter_data = lambda { |a| a.scan(/\d+[,.]\d+/).to_s.split('').map { |u| u == ',' ? '.' : u }.join('').scan(/\d+[,.]\d+/).map(&:to_f).inject { |k, z| (k + z) / 2 } }
    @clean_values = @brute_collect_values.map { |x| filter_data.call(x) } 
    @clean_logistics = @brute_collect_logistics.map { |x| filter_data.call(x) }
     
  end

  def add_to_databank
    @@products_databank[@brute_collect_titles] = @clean_values
    @@search_history.push(@search_term)
  end

  def self.get_search_history
    @@search_history
  end

  def self.get_databank
    @@products_databank
  end

  def get_clean_values
    @clean_values
  end
end