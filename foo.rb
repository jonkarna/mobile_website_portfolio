require 'rubygems'
require 'sinatra'
require 'erb'

require 'net/http'
require 'rexml/document'

menu = ['Agriculture', 'Transportation', 'Service', 'Construction', 'Manufacturing', 'Retail', 'Community & Tourism', 'Health & Wellness', 'Ecommerce', 'Other']

# Web search for "madonna"
url = 'http://www.sitepro.com/index.cfm?event=flashrotation&flashpiecename=portfolio.websites.agriculture'

# get the XML data as a string
xml_data = Net::HTTP.get_response(URI.parse(url)).body

# extract event information
doc = REXML::Document.new(xml_data)

get '/' do
	@backLink = ''
	@menu = menu
	erb :index
end

get '/:category/?' do
	@menu = menu
	@backLink = '/'
	@categoryName = menu[params[:category].to_i - 1]
	@flashrecords = []
	doc.elements.each('flashpiece/flashrecord') do |ele|
		@flashrecords << ele
	end
	erb :category
end

get '/:category/:index/?' do
	@backLink = "/#{params[:category]}"
	@flashrecord = ''
	doc.elements.each("flashpiece/flashrecord[#{params[:index]}]") do |ele|
		@flashrecord = ele
	end
	halt if @flashrecord == ''
	erb :website
end