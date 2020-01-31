require 'nokogiri'
require 'open-uri'

class KScrapper 
  def initialize(website)
    @website = open(website).read
    @parsed_content = Nokogiri::HTML(@website)
  end

  

  def display_results
    values = []
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
      values.push(price)
    end
    values.map do |x|
      new = x.scan(/\d+[,.]\d+/).join(' to ')
      puts new
    end
  end

  def retrieve_prices(string)
    string.map {|x| x[/\d+/]}
  end

end

scrap = KScrapper.new('https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m4084.l1311.R6.TR12.TRC2.A0.H0.Xheadphone.TRS1&_nkw=headphones+wireless&_osacat=619&_odkw=headphone&LH_TitleDesc=0&_sacat=0')
scrap.display_results

