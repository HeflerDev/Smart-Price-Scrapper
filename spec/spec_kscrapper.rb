require_relative '../lib/kscrapper'

require 'rspec'

#Test to see if the Cleaner transformed the results accordingly
RSpec.describe KScrapper do
  describe '#clean_values' do
    it 'something' do
      scrap_one = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=coffee+cup", 'cup')
      scrap_one.collect_data
      scrap_one.clean_data
      expect(scrap_one.clean_values.is_a? Array).to eql(true)
      expect(scrap_one.clean_values.all? { |x| x.is_a? Numeric}).to eql(true)
    end
  end
end