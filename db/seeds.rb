require 'net/http'
require 'rexml/document'

Categorization.delete_all
Website.delete_all
Category.delete_all

menu = ['Agriculture', 'Transportation', 'Service', 'Construction', 'Manufacturing', 'Retail', 'Community & Tourism', 'Health & Wellness', 'Ecommerce', 'Other']
url_suffix = ['agriculture', 'transportation', 'service', 'construction', 'manufacturing', 'retail', 'travel', 'health', 'ecommerce', 'other']

url_suffix.each_with_index do |suffix, index|
	@category = Category.new
	@category.name = menu[index]
	@category.save!
	xml_doc = REXML::Document.new(Net::HTTP.get_response(URI.parse("http://www.sitepro.com/index.cfm?event=flashrotation&flashpiecename=portfolio.websites.#{suffix}")).body)
	xml_doc.elements.each('flashpiece/flashrecord') do |flashrecord|
		@website = Website.find_by_title(flashrecord.attributes["title"])
		if @website.nil?
			@website = Website.new
			@website.title = flashrecord.attributes["title"]
			@website.image = flashrecord.attributes["image"]
			@website.website = flashrecord.attributes["website"]
			@website.industry = flashrecord.attributes["industry"]
			@website.launched = flashrecord.attributes["launched"]
			@website.features = flashrecord.attributes["features"]
			@website.challenge = flashrecord.attributes["challenge"]
			@website.solution = flashrecord.attributes["solution"]
			@website.save!
		end
		@categorization = Categorization.new
		@categorization.category = @category
		@categorization.website = @website
		@categorization.move_to_bottom
		@categorization.save!
	end
end