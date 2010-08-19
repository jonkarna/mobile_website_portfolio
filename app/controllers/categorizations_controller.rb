class CategorizationsController < ApplicationController
	%w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
		define_method action do
			@categorization = Categorization.find(params[:id])
			@categorization.send(action)
			if @categorization.save
				flash[:notice] = "The website was reordered. #{action}"
			else
				flash[:notice] = "Error."
			end
			redirect_to(edit_category_path(@categorization.category))
		end
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

	# DELETE /categorizations/1
	# DELETE /categorizations/1.xml
	def destroy
		@categorization = Categorization.find(params[:id])
		@categorization.destroy
		redirect_to(categorizations_url)
	end
end