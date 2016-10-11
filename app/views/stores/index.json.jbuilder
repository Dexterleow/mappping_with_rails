json.array!(@stores) do |store|
  json.extract! store, :id, :latitude, :longitude, :name, :adress, :title
  json.url user_url(store, format: :json)
end
