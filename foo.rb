require 'rubygems'
require 'sinatra'
require 'erb'

require 'net/http'
require 'rexml/document'

menu = ['Agriculture', 'Transportation', 'Service', 'Construction', 'Manufacturing', 'Retail', 'Community & Tourism', 'Health & Wellness', 'Ecommerce', 'Other']
url_suffix = ['agriculture', 'transportation', 'service', 'construction', 'manufacturing', 'retail', 'travel', 'health', 'ecommerce', 'other']
xml_data = {}

configure do
	url_suffix.each_with_index do |suffix, index|
		xml_data[index] = []
		xml_doc = REXML::Document.new(Net::HTTP.get_response(URI.parse("http://www.sitepro.com/index.cfm?event=flashrotation&flashpiecename=portfolio.websites.#{suffix}")).body)
		xml_doc.elements.each('flashpiece/flashrecord') do |ele|
			xml_data[index] << ele
		end
	end
end

get '/' do
	@backLink = ''
	@menu = menu
	
	headers['Cache-Control'] = 'public, max-age=31536000'
	headers['Expires'] = (Time.now + 31536000).rfc2822
	erb :index
end

get '/:category/?' do
	category_index = params[:category].to_i - 1
	@backLink = '/'
	@categoryName = menu[category_index]
	@flashrecords = xml_data[category_index]
	
	headers['Cache-Control'] = 'public, max-age=31536000'
	headers['Expires'] = (Time.now + 31536000).rfc2822
	erb :category
end

get '/:category/:index/?' do
	category_index = params[:category].to_i - 1
	@backLink = "/#{params[:category]}"
	@flashrecord = xml_data[category_index][params[:index].to_i - 1]
	
	headers['Cache-Control'] = 'public, max-age=31536000'
	headers['Expires'] = (Time.now + 31536000).rfc2822
	erb :website
end