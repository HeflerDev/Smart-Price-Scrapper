require 'nokogiri'
require 'open-uri'

class KScrapper 

  attr_accessor :prices_databank

  @@prices_databank = {}
  @@name_databank = {}
  @@storage = {}

  def initialize(website, search_term)
    @website = open(website).read
    @search_term = search_term
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect = []
    @clean_values = []
  end
#Function that Collects and return data in form of array.
  def collect_data
    puts "Search has Returned #{@parsed_content.css('.s-item__wrapper').length} results. Press enter to proceed."
    gets.chomp
    @parsed_content.css('.s-item__wrapper').each do |row|
      title   = row.css('.s-item__title').inner_text
      status  = row.css('.SECONDARY_INFO').inner_text
      price   = row.css('.s-item__price').inner_text
      logistic= row.css('.s-item__logisticsCost').inner_text
      sold    = row.css('.NEGATIVE').inner_text
      puts '============================================================================='
      puts title
      puts status
      puts price
      puts logistic
      puts sold
      @@name_databank[title] = nil
      @brute_collect.push(price)
    end
    @clean_values = @brute_collect.map do   |x|
      #This line Filters only numbers and punctuation
      selector = x.scan(/\d+[,.]\d+/).to_s.split('').map {|x| x == ',' ? '.' : x}.join('').scan(/\d+[,.]\d+/).map(&:to_f).inject{|x,y| (x+y)/2}
      #This line transform the numbers into floats, and if the array size is bigger than 2, takes the average value
    end
    #This line Stores the Data on a Databank
    @@prices_databank[@search_term] = @clean_values
    
  end  
  
  def KScrapper.show_databank
    @@prices_databank.each do |x, y|
      puts '----------------------------------------------------------------------'
      puts " | #{x.capitalize} : #{y} | "
    end
  end

  def KScrapper.compute_average
    @@prices_databank.each do |key, value|
      @@storage[key] = value.inject{ |x, y| x+y}/value.length
      puts '----------------------------------------------------'
      puts "#{key.capitalize} : #{@@storage[key]}"
    end
  end

  def KScrapper.compute_biggest
    @@prices_databank.each do |x, y|
      puts '----------------------------------------------------------'
      puts "The biggest value of #{x.capitalize} is #{y.max(1)}"
    end
    
  end
end

