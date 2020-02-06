#!/usr/bin/env ruby

# rubocop:disable Metrics/BlockNesting,Style/IfInsideElse

require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative '../lib/flow.rb'
require_relative '../lib/kscrapper.rb'


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
    when choices[1]
      choices = ['Return Average Value', 'Return Biggest Value', 'Return Lowest Value']
      answer = prompt.select('Choose Operation', choices)
      case answer  
      when choices[0]
        history = KScrapper.get_search_history
        KScrapper.get_databank.map.with_index do |(key, value), index | 
          puts "The average value of #{history[index].join.capitalize} is: #{value.inject{ |x, y| x+y} / value.length}."
        end
        i = 0
      when choices[1]
        data = KScrapper.get_databank
        puts data
      else
        data = KScrapper.get_databank
        puts data
      end
    else
      puts 'ERROR: BAD CODE'
    end
  else
    puts 'ERROR: BAD CODE'
  end
end