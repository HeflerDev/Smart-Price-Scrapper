require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

#document = open('https://newyork.craigslist.org/search/ggg?query=computer%20gigs&sort=rel')

#content = document.read

#parsed_content = Nokogiri::HTML(content)

#parsed_content.css('example').first.inner_html

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
choices = %w(Normal_Mode Developer_Mode)
answer = prompt.select(greeting, choices)
'do something' if answer == choices[0]

case answer
when choices[0]
  #Normal Mode Start
  puts 'Choosed Normal Mode'
  puts 'Choose one of the '



  #Normal Mode End
when choices[1]
  puts 'Choosed Developer Mode'
else
  puts 'Invalid entering: How did you do that ?'
end


