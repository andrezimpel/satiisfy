json.array!(@profiles) do |profile|
  json.extract! profile, :id, :firstname, :lastname
  json.url profile_url(profile, format: :json)
end
