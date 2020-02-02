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

gatter = true
has_data = false

  while gatter
    prompt = TTY::Prompt.new
    puts
    greeting = 'Choose an option below'
    choices = ['Search New', 'Access Databank']
    answer = prompt.select(greeting, choices)
    'do something' if answer == choices[0]

    if answer == choices[0]
      # Search Mode Start
      choices = ['Fast Search','Custom Search']
      answer  = prompt.select('Select a Search Method', choices)
      # Fast Search Code
      if answer == choices[0]
        # Loop that validates Search
        loop do
          puts
          puts 'Type your Search'
          $search = gets.chomp.downcase
          puts 'Error : No item to Search' if $search == ""
          puts 'Error : The search must start with characters between a and z' unless $search =~ /^[a-z]/
          break if $search =~ /^[a-z]/
        end

        # Guarantee HTML adress Validation
        $search.split('').each_with_index {|value, index| $search[index] = '+' if value == ' '}
        puts 'Searching ...'
        result = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=#{$search}", $search).collect_data
        puts 'Done Collecting Data, Saved to Temporary Files.Press enter to continue.'
        gets.chomp
        has_data = true
        Gem.win_platform? ? (system "cls") : (system "clear")
      end

    else

      #if has_data
        choices = ['Data Parsed', 'Compute Data']
        answer = prompt.select('What do you want to do ?', choices)

        if answer == choices[0]
          KScrapper.show_databank
        else
          choices = ['Return Average Value', 'Return Biggest Value', 'Return Lowest Value']
          answer = prompt.select('Choose Operation', choices)

          if answer == choices[0]
            KScrapper.compute_average
          
          elsif answer == choices[1]
            KScrapper.compute_biggest
          else
            p 'Not Ready'
          end  
        
        end

      #else
      #  puts 'No data to Store'
      #  gets.chomp
      #end

    end

  end

puts "Operation terminated at #{Time.now}"
gets.chomp





