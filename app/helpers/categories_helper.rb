module CategoriesHelper
  def reorder_buttons(categorization)
    result = "[ "
    [
      {:action => "move_higher", :label => "Up"},
      {:action => "move_lower", :label => "Down"},
      {:action => "move_to_top", :label => "Top"},
      {:action => "move_to_bottom", :label => "Bottom"}
    ].each do |item|    
      result << link_to("#{item[:label]}", send("#{item[:action]}_category_categorization_path", categorization.category, categorization) )
      result << ' | '
    end
    result << link_to('X', category_categorization_path(categorization.category, categorization), :confirm => 'Are you sure?', :method => :delete) + ' ]'
    result
  end
end
