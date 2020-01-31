require 'nokogiri'
require 'open-uri'

class KScrapper 
  def initialize(website)
    @website = open(website).read
    @parsed_content = Nokogiri::HTML(@website)
  end

  def display_results
    @parsed_content.css('.s-item__wrapper').each do |row|
      puts '==============================================================================================================='
      puts row.css('.s-item__title').inner_text
      puts row.css('.SECONDARY_INFO').inner_text
      puts row.css('.s-item__price').inner_text
      puts row.css('.s-item__logisticsCost').inner_text
      puts row.css('.NEGATIVE').inner_text
      
    end
  end
end

search = KScrapper.new('https://www.ebay.com/sch/i.html?_from=R40&_nkw=headphones+wireless')
search.display_results


'https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m4084.l1311.R6.TR12.TRC2.A0.H0.Xheadphone.TRS1&_nkw=headphones+wireless&_osacat=619&_odkw=headphone&LH_TitleDesc=0&_sacat=0'

'https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m4084.l1311.R6.TR12.TRC2.A0.H0.Xheadphone.TRS1&_nkw=headphones+wireless&_osacat=619&_odkw=headphone&LH_TitleDesc=0&_sacat=0'