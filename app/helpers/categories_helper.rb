module CategoriesHelper
  def reorder_buttons(categorization)
    result = "[ "
    [
      {:action => "move_higher", :label => "Up"},
      {:action => "move_lower", :label => "Down"},
      {:action => "move_to_top", :label => "Top"},
      {:action => "move_to_bottom", :label => "Bottom"}
    ].each do |item|
      result << link_to("#{item[:label]}", send("#{item[:action]}_categorization_path", categorization) )
      result << ' | '
    end
    result << link_to('X', categorization, :confirm => 'Are you sure?', :method => :delete) + ' ]'
    result
  end
end
