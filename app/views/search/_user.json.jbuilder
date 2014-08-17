json.array(items) do |item|
  json.extract! item, :id, :firstname, :lastname, :email, :position, :fullname
  json.avatar item.avatar(:thumb_square)
  json.active item.is_active?
end
