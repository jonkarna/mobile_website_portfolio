module CategoriesHelper
  def reorder_buttons(categorization)
    result = ""
    [
      {:action => "move_higher", :label => "&uarr;"},
      {:action => "move_lower", :label => "&darr;"},
      {:action => "move_to_top", :label => "&uarr;&uarr;"},
      {:action => "move_to_bottom", :label => "&darr;&darr;"}
    ].each do |item|    
      result << button_to("#{item[:label]}", send("#{item[:action]}_category_categorization_path", categorization.category, categorization) )
    end
    result
  end
end
