#!/usr/bin/env ruby

# rubocop:disable Metrics/BlockNesting,Style/IfInsideElse

require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'tty-prompt'

require_relative 'str_content.rb'
require_relative '../lib/kscrapper.rb'


