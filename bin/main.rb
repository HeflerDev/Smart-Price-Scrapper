require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative '../lib/amazon.rb'

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
  puts
  puts 'Choosed Normal Mode'
  puts

  choices = %w(MercadoLivre[Under_Development] Amazon Saraiva[Under_Development])
  answer  = prompt.select('Choose one of the websites to scrap Data from: ',choices)

  case answer
  when choices[0]
    puts 'Choosed MercadoLivre'
  when choices[1]
    #Amazon Start
    puts 'Choosed Amazon'
    choices = %w(Arts_&_Crafts Automotive Baby Beauty Books Boy's_Fashion Photograph Phones Computers Costumes Eletronics Generic)
    answer  = prompt.select('Choose a Category to Scrap !', choices)

    case answer
    when choices[0]
      #Arts & crafts
    when choices[1]
      #Automotive
    when choices[2]
      #Baby
    when choices[3]
      #Beauty
    when choices[4]
      #books
    when choices[5]
      #Fashion
    when choices[6]
      #Photograph
    when choices[7]
      #Phones
    when choices[8]
      #Computers
    when choices[9]
      #Costumes
    when choices[10]
      #Eletronics
    when choices[11]
      #Generic
    end

    #Amazon End
  when choices[2]
    #Saraiva Start
    puts 'Choosed Saraiva'
    choices = %w(Books)
    answer  = prompt.select('Select a Category',choices)
    case answer
    when choices[0]
      puts
      puts 'Parsing Data...'
      puts 'Those are the Results'
    when choices[1]

    end
    #saraiva End
  else
  end

  #Normal Mode End
when choices[1]
  puts 'Choosed Developer Mode'
else
  puts 'Invalid entering: How did you do that ?'
end


