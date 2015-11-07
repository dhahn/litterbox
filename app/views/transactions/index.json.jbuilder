json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :user_id, :litter_box_id, :check_in, :check_out, :price
  json.url transaction_url(transaction, format: :json)
end
