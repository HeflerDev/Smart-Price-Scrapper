#!/usr/bin/env ruby

# rubocop:disable Metrics/BlockNesting,Style/IfInsideElse

require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative '../lib/kscrapper.rb'

object  = KScrapper.new("https://www.ebay.com/sch/i.html?_from=R40&_nkw=coffee+cup", 'coffee+cup')
