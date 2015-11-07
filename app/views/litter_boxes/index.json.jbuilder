json.array!(@litter_boxes) do |litter_box|
  json.extract! litter_box, :id, :capacity, :description, :city, :state, :address_line_1, :address_line_2, :zip, :number_of_adults, :number_of_children, :number_of_pets
  json.url litter_box_url(litter_box, format: :json)
end
