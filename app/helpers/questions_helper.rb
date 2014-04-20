module QuestionsHelper
  def new_project_question_path (project)
    return new_question_path(project: project)
  end
end
