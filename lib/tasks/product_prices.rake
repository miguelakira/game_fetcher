desc 'Fetch product prices'
task :fetch_prices => :environment do
  require 'nokogiri'
  require 'open-uri'
  require 'cgi'

  Product.find_all_by_price(nil).each do |product|
    escaped_product_name = CGI.escape("\"#{product.name}\"")

url =  "http://www.game.co.uk/webapp/wcs/stores/servlet/AjaxCatalogSearchView?searchTermScope=&searchType=&catGroupId=&filterTerm=&filterTermOperator=&langId=44&RASchemaType=&attributeName1=Catalog_GameSalesCatalog_EN_GB&catgrpSchemaType=&attributeName2=Catalog_GameSalesCatalog_EN_GB&sType=SimpleSearch&filterType=&resultCatEntryType=2&searchTerm=#{escaped_product_name}&catalogId=10201&sortColumn=popular&listerOnly=true&categoryType=&searchTermOperator=&sortTypeStr=DESC&storeId=10151&attributeValue1=4294967261&inStockOnly=true&attributeValue2=4294967255"
  doc = Nokogiri::HTML(open(url))
    price = doc.at_css('.price').text[/[0-9\.]+/]
    info = doc.at_css('.uri, .title').text
    product.update_attributes(:price => price, :info => info)

  end
end

=begin
doc.css('.uri').each do |item|
  text = item.at_css('.title').text unless item.at_css('.title').nil?
  price =  item.at_css('.price').text unless item.at_css('.price').nil?
  puts "#{text} - #{price}"
end
=end
