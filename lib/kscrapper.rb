require 'nokogiri'
require 'open-uri'

# rubocop:disable Metrics/MethodLength,Metrics/LineLength,Style/ClassVars

class KScrapper
  attr_accessor :prices_databank

  @@prices_databank = {}
  @@storage = {}
  @@name_storage = {}
  @@search_container = []

  def initialize(website, search_term)
    @website = open(website).read
    @search_term = search_term
    @parsed_content = Nokogiri::HTML(@website)
    @brute_collect = []
    @clean_values = []
    @name_data = []
    @value_data = []
  end

  # Function that Collects and return data in form of array.
  def collect_data
    @@search_container.push(@search_term)
    puts "Search has Returned #{@parsed_content.css('.s-item__wrapper').length} results. Press enter to proceed."
    gets.chomp
    @parsed_content.css('.s-item__wrapper').each do |row|
      title = row.css('.s-item__title').inner_text
      status = row.css('.SECONDARY_INFO').inner_text
      price = row.css('.s-item__price').inner_text
      logistic = row.css('.s-item__logisticsCost').inner_text
      sold = row.css('.NEGATIVE').inner_text
      puts '|=============================================================================|'
      puts title
      puts status
      puts price
      puts logistic
      puts sold
      @name_data.push(title)
      @brute_collect.push(price)
    end
    @clean_values = @brute_collect.map do |x|
      # This line Filters only numbers and punctuation, transform the numbers into floats and if the array size is bigger than 2, takes the average value
      filter_data = ->(a) { a.scan(/\d+[,.]\d+/).to_s.split('').map { |u| u == ',' ? '.' : u }.join('').scan(/\d+[,.]\d+/).map(&:to_f).inject { |k, z| (k + z) / 2 } }
      @value_data.push(filter_data.call(x))
      filter_data.call(x)
    end
    # This line Stores the Data on a Databank
    @@prices_databank[@search_term] = @clean_values
    @@name_storage[@name_data] = @value_data
  end

  def self.show_databank(answer)
    if answer.zero?
      @@prices_databank.each do |x, y|
        puts '----------------------------------------------------------------------'
        puts " | #{x.capitalize} : #{y} | "
      end
    else
      @@name_storage.each_with_index do |(k, v), i|
        puts '============================================================='
        puts '                                                             '
        puts "                      #{@@search_container[i]}               "
        puts '                                                             '
        puts '============================================================='
        puts
        k.each_with_index do |_, y|
          puts "#{k[y]} : #{v[y]}"
          puts '-----------------------------------------------------------------'
        end
      end
    end
  end

  def self.compute_average
    @@prices_databank.each do |key, value|
      @@storage[key] = value.inject { |x, y| x + y } / value.length
      puts '----------------------------------------------------'
      puts "#{key.capitalize} : #{@@storage[key]}"
    end
  end

  def self.compute_biggest
    @@name_storage.each_with_index do |(x, y), z|
      index = y.index(y.max)
      puts "=================================| #{@@search_container[z]} |==============================="
      puts "The biggest value is : #{x[index].capitalize} that costs : #{y[index]}"
    end
  end

  def self.compute_smallest
    @@name_storage.each_with_index do |(x, y), z|
      index = y.index(y.min)
      puts "=================================| #{@@search_container[z]} |==============================="
      puts "The smallest value is : #{x[index].capitalize} that costs : #{y[index]}"
    end
  end
end
## rubocop:enable Metrics/MethodLength,Metrics/LineLength,Style/ClassVars
