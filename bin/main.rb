require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative '../lib/kscrapper.rb'

#Welcome Section
Gem.win_platform? ? (system "cls") : (system "clear")
puts
puts 'Welcome to Kasuhira Price Scrapping system, how may I be of assistance ?'
puts 
puts '     _________'
puts '    / ======= \\'
puts "   / __________\\"
puts '  | ___________ |'
puts '  | | -       | |'
puts '  | |         | |'
puts '  | |_________| |_____________________________'
puts '  \=____________/   Developed by Kasuhira     )'
puts '  / """"""""""" \                            /'
puts " / ::::::::::::: \\                      =D-'"
puts "|_________________|"
puts

prompt = TTY::Prompt.new
greeting = 'Choose an option below'
choices = ['Search New', 'Access Databank']
answer = prompt.select(greeting, choices)
'do something' if answer == choices[0]

case answer
when choices[0]
  #Search Mode Start
  choices = ['Fast Search','Custom Search']
  answer  = prompt.select('Select a Search Method', choices)
  #Fast Search Code
  if answer == choices[0]
    puts
    puts 'Type your Search'
    search = gets.chomp
    search.split('').each_with_index {|value, index| search[index] = '+' if value == ' '}
    result = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=#{search}")
    result.display_results
  end
when choices[1]
  
else
  puts 'Invalid entering: How did you do that ?'
end


