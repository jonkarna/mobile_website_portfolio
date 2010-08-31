class CategorizationsController < ApplicationController
	before_filter :authenticate, :except => [:show]
	before_filter :define_back_link, :except => [:create, :destroy]
	
	%w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
		define_method action do
			@categorization = Categorization.find(params[:id])
			@categorization.send(action)
			if @categorization.save
				flash[:notice] = "The website was reordered."
			else
				flash[:notice] = "Error."
			end
			redirect_to(edit_category_path(@categorization.category))
		end
	end
	
	def show
		@categorization = Categorization.find(params[:id])
		@website = @categorization.website
	end
	
	def edit
		@categorization = Categorization.find(params[:id])
		@website = @categorization.website
	end
	
	def create
		@category = Category.find(params[:category_id])
		@website = Website.find(params[:website_id])
		@categorization = Categorization.new()
		@categorization.category = @category
		@categorization.website = @website
		@categorization.move_to_bottom
		if @categorization.save
			flash[:notice] = 'Categorization was successfully created.'
			redirect_to(edit_category_path(@categorization.category))
		else
			render :action => "new"
		end
	end
	
	def destroy
		@categorization = Categorization.find(params[:id])
		@categorization.destroy
		redirect_to(edit_category_path(@categorization.category))
	end
	
	private
	def define_back_link
		@categorization = Categorization.find(params[:id])
		@back_link = category_path(@categorization.category)
	end
end