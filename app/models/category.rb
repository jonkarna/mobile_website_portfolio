class Category < ActiveRecord::Base
	has_many :categorizations, :dependent => :destroy, :order => "position"
	has_many :websites, :through => :categorizations, :order => "position"
end
