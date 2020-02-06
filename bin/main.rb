#!/usr/bin/env ruby

# rubocop:disable Metrics/BlockNesting,Style/IfInsideElse

require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative '../lib/kscrapper.rb'

#Encapsulations

def validate_field(field)
  puts 'Validating Field...'
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

def validate_search(query)
  puts 'Validating Input...'
  result = query.split('').each_with_index { |value, index| result[index] = '+' if value == ' ' }
end

def new_search
  loop do
    puts
    puts 'Type your Search'
    search = gets.chomp.downcase
    break unless validate_field(search)
    
    search = validate_search(search)
    puts 'Searching ...'
    result = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=#{search}", search)
    result.collect_data
    result.clean_data
    result.add_to_databank
    puts "Done Colecting Data, the Search Found #{result.brute_collect_values.length} results.Press Enter to Continue..."
    gets.chomp
    break
  end
end

def find_average
  history = KScrapper.get_search_history
  KScrapper.get_databank.map.with_index do |(key, value), index | 
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts "The average value of #{history[index].join.capitalize} is: #{value.inject{ |x, y| x+y} / value.length}."
  end
end

def find_max
  history = KScrapper.get_search_history
  KScrapper.get_databank.each_with_index do |(x, y), z|
    index = y.index(y.max)
    puts "=================================| #{history[z].join} |==============================="
    puts "The biggest value is : #{x[index].capitalize} that costs : #{y[index]}"
  end
end

def find_min
  history = KScrapper.get_search_history
  KScrapper.get_databank.each_with_index do |(x, y), z|
    index = y.index(y.min)
    puts "=================================| #{history[z].join} |==============================="
    puts "The biggest value is : #{x[index].capitalize} that costs : #{y[index]}"
  end
end

def show_data
  history = KScrapper.get_search_history
  KScrapper.get_databank.each_with_index do |(k, v), i|
    puts '============================================================='
    puts '                                                             '
    puts "                      #{history[i].join}               "
    puts '                                                             '
    puts '============================================================='
    puts
    k.each_with_index do |_, y|
      puts "#{k[y]} : #{v[y]}"
      puts '-----------------------------------------------------------------'
    end
  end
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
loop do
  prompt = TTY::Prompt.new
  greeting = 'Choose an option below'
  choices = ['Search New', 'Access Databank']
  answer = prompt.select(greeting, choices)

  case answer
  when choices[0]
    new_search

  when choices[1]
    choices = ['Data Parsed', 'Compute Data']
    answer = prompt.select('What do you want to do ?', choices)
    case answer
    when choices[0]
      show_data
    when choices[1]
      choices = ['Return Average Value', 'Return Biggest Value', 'Return Lowest Value']
      answer = prompt.select('Choose Operation', choices)
      case answer  
      when choices[0]
        find_average
      when choices[1]
        find_max
      else
        find_min
      end
    else
      puts 'ERROR: BAD CODE'
    end
  else
    puts 'ERROR: BAD CODE'
  end
end