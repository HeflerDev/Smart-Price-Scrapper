#!/usr/bin/env ruby

# rubocop:disable Metrics/BlockNesting,Style/IfInsideElse

require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative 'str_content.rb'
require_relative '../lib/kscrapper.rb'

def validate_field(field)
  puts 'Validating...'
  if field == ''
    puts 'Error : No item to Search' if field == ''
    puts 'Returning...'
    return false
  elsif field !~ /^[a-z]/
    puts 'Error : The search must start with characters between a and z'
    puts 'Returning...'
    return false
  else 
    true
  end
end
#
def search_for(query)

end

Gem.win_platform? ? (system 'cls') : (system 'clear')
puts
puts 'Welcome to Kasuhira Price Scrapping system, how may I be of assistance ?'
puts
puts '     _________'
puts '    / ======= \\'
puts '   / __________\\'
puts '  | ___________ |'
puts '  | | -       | |'
puts '  | |         | |'
puts '  | |_________| |_____________________________'
puts '  \=____________/   Developed by Kasuhira     )'
puts '  / """"""""""" \                            /'
puts " / ::::::::::::: \\                      =D -'"
puts '|_________________|'
puts 

#Selection Menu

prompt = TTY::Prompt.new
greeting = 'Choose an option below'
choices = ['Search New', 'Access Databank']
answer = prompt.select(greeting, choices)

case answer
when choices[0]
  loop do
    puts
    puts 'Type your Search'
    search = gets.chomp.downcase
    break unless validate_field(search)
    #Validates the Search
    search.split('').each_with_index { |value, index| search[index] = '+' if value == ' ' }
    puts 'Searching ...'
    init = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=#{search}", search).collect_data
    puts 'Done Collecting Data, Saved to Temporary Files.Press enter to continue.'
    gets.chomp
    has_data = true
    Gem.win_platform? ? (system 'cls') : (system 'clear')
    break
  end
when choices[1]
  
else
  puts 'ERROR: BAD CODE'
end

