json.array!(@all_grouped_results) do |group, results|
  results.each do |result|
    json.id result.id
    # json.url project_url(project)
  end
end
