json.array!(@results.group(:klass).groups) do |group|
  klass = group.value
  results = group.results


  json.partial! "search/#{group.value}", items: group.results
  json.class group.value

  # json.extract! result, :id
  # json.url profile_url(profile, format: :json)
end
