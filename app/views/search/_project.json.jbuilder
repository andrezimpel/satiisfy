json.array(items) do |item|
  json.extract! item, :id, :title, :description, :subdomain
  json.url project_path(item)
end
