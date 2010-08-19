class Categorization < ActiveRecord::Base
	belongs_to :category
	belongs_to :website
	acts_as_list :scope => :category
end
