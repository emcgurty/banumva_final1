# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def find_element_in_multidimensional_array(this_array, sought_value)

    return_string = 'NA'
    this_array.each do |i_array|
      i_array.each_with_index do |in_array, i_index|
        if in_array ==  sought_value
          return_string = in_array
        end
      end
    end
    return_string
  end

  def get_full_name(object)
    fullname = ''
    if object.display_name == 1
    
      strmi = object.mi
      if strmi.blank?
        fullname = object.first_name + " " + object.last_name
      else
        fullname = object.first_name + " " + object.mi + " " + object.last_name
      end
     
    end
    fullname
  end

  
end
