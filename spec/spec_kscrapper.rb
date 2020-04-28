require_relative '../lib/kscrapper'

require 'rspec'
require 'nokogiri'

RSpec.describe KScrapper do
  scrap = KScrapper.new('https://www.ebay.com/sch/i.html?_from=R40&_nkw=coffee+cup', 'coffee+cup')
  describe '#initialize' do
    it 'grabs the correct data' do
      expect((scrap.website.is_a? String)).to eql(true)
      expect((scrap.website.split('//').all? { |x| x != ' ' })).to eql(true)
    end
  end
  scrap.collect_data
  describe '#collect_data' do
    it 'variables are arrays bigger than 0' do
      expect((scrap.brute_collect_values.is_a? Array)).to eql(true)
      expect((scrap.brute_collect_titles.is_a? Array)).to eql(true)
      expect((scrap.brute_collect_logistics.is_a? Array)).to eql(true)
    end
    it 'pushes the values to the variables and checks if has at least one number' do
      expect(scrap.brute_collect_values.all? { |x| (x.is_a? String) && x.match(/\d/) }).to eql(true)
    end
  end
  scrap.clean_data
  describe '#clean_data' do
    it 'clean junk from Strings, and check if each item is Numeric' do
      expect((scrap.clean_values.is_a? Array)).to eql(true)
      expect(scrap.clean_values.all? { |x| x.is_a? Numeric }).to eql(true)
    end
  end
  scrap.add_to_databank
  describe '#add_to_databank' do
    it 'check if pushed the right value' do
      expect(scrap.search_term).to eql(KScrapper.take_search_history[0])
    end
    it 'check if databank values are valid' do
      expect(KScrapper.take_databank.is_a?(Hash)).to eql(true)
      KScrapper.take_databank.each do |k, v|
        expect((k.is_a? Array)).to eql(true)
        expect((v.is_a? Array)).to eql(true)
        expect(k.length).to eql(v.length)
        k.each { |x| expect((x.is_a? String)).to eql(true) }
        v.each { |x| expect((x.is_a? Numeric)).to eql(true) }
      end
    end
  end
  describe '#take_search_history' do
    it 'check if the flow is right' do
      KScrapper.new('https://www.ebay.com/sch/i.html?_from=R40&_nkw=model', 'unicorns').add_to_databank
      flow = KScrapper.new('https://www.ebay.com/sch/i.html?_from=R40&_nkw=model', 'flow').add_to_databank
      expect(KScrapper.take_search_history[0]).to eql(scrap.search_term)
      expect(KScrapper.take_search_history[-1]).to eql(flow[-1])
    end
  end
  # The other Methods I didn't done because they are just getters
end
