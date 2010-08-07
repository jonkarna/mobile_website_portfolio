require 'rubygems'
require 'sinatra'
require 'erb'

require 'net/http'
require 'rexml/document'

menu = ['Agriculture', 'Transportation', 'Service', 'Construction', 'Manufacturing', 'Retail', 'Community & Tourism', 'Health & Wellness', 'Ecommerce', 'Other']
url_suffix = ['agriculture', 'transportation', 'service', 'construction', 'manufacturing', 'retail', 'travel', 'health', 'ecommerce', 'other']

# get the XML data as a string
$xml_data = {}
#xml_data = Net::HTTP.get_response(URI.parse(url)).body

# extract event information
#doc = REXML::Document.new(xml_data)

configure do
	url_suffix.each_with_index do |suffix, index|
		$xml_data[index] = REXML::Document.new(Net::HTTP.get_response(URI.parse("http://www.sitepro.com/index.cfm?event=flashrotation&flashpiecename=portfolio.websites.#{suffix}")).body)
	end
end

get '/' do
	@backLink = ''
	@menu = menu
	erb :index
end

get '/:category/?' do
	category_index = params[:category].to_i - 1
	doc = $xml_data[category_index]
	
	@menu = menu
	@backLink = '/'
	@categoryName = menu[category_index]
	@flashrecords = []
	doc.elements.each('flashpiece/flashrecord') do |ele|
		@flashrecords << ele
	end
	erb :category
end

get '/:category/:index/?' do
	category_index = params[:category].to_i - 1
	doc = $xml_data[category_index]
	
	@backLink = "/#{params[:category]}"
	@flashrecord = ''
	doc.elements.each("flashpiece/flashrecord[#{params[:index]}]") do |ele|
		@flashrecord = ele
	end
	halt if @flashrecord == ''
	erb :website
end