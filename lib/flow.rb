module Flow
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
    result
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
  
end