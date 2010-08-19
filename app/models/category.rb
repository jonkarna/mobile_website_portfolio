class Category < ActiveRecord::Base
	has_many :categorizations, :order => "position"
	has_many :websites, :through => :categorizations, :order => "position"
end
