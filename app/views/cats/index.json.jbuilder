json.array!(@cats) do |cat|
  json.extract! cat, :id, :description, :name, :breed, :gender, :spayed_slash_neutered, :clawed, :color
  json.url cat_url(cat, format: :json)
end
