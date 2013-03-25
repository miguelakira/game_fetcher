desc 'Generating products'
task :generate_products=> :environment require
  do 'nokogiri'
  require 'open-uri'
  require 'cgi'


url =  "http://www.game.co.uk/en/games/playstation-3/?langId=44&storeId=10151&catalogId=10201&categoryId=10225&pageView=&sortBy=MOST_POPULAR_DESC&inStockOnly=true&listerOnly=true&contentOnly=&storeOnly=&provenance=New&resultCatEntryType=&catgrpSchemaType=&RASchemaType=&searchTerm=&searchType=&searchTermOperator=&searchTermScope=&filterTerm=&filterType=&filterTermOperator=&catGroupId=&categoryType=&sType=&minPrice=&maxPrice=&attributeName1=Shop+By&attributeValue1=63&pageSize=All"

  doc = Nokogiri::HTML(open(url))
  doc.css('.product').each do |item|
    price = item.at_css('.price').text[/[0-9\.]+/]
    name = item.at_css('.uri, .title').text
    info = item.at_css('.frame img').first[1]
    Product.create(:price => price, :name=> name, :info => info)

  end
end

=begin
doc.css('.uri').each do |item|
  text = item.at_css('.title').text unless item.at_css('.title').nil?
  price =  item.at_css('.price').text unless item.at_css('.price').nil?
  puts "#{text} - #{price}"
end
=end
