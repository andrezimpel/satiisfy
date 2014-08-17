json.array(items) do |item|
  json.extract! item, :id, :title, :answer
  json.url project_question_path(item.project, item)
end
