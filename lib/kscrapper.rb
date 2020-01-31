require 'nokogiri'
require 'open-uri'

class KScrapper 
  def initialize(website)
    @website = open(website).read
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect = []
    @clean_values = []
  end

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
      @brute_collect.push(price)
    end
    @clean_values = @brute_collect.map do |x|
      #This line Filters only numbers and punctuation
      selector = x.scan(/\d+[,.]\d+/)
      #This line transform the numbers into floats, and if the array size is bigger than 2, takes the average value
      selector.to_s.split('').map {|x| x == ',' ? '.' : x}.join('').scan(/\d+[,.]\d+/).map(&:to_f).inject{|x,y| (x+y)/2}
    end
  end
end

