class FrontendController < ApplicationController

  before_filter :set_project
  skip_filter :set_current_account, :authenticate_user!

  layout "frontend"

  def index
  end

  def questions
    @questions = @project.questions
  end

  def question
    @question = Question.find(params[:id])

    if @question.project.id != @project.id
      raise ActionController::RoutingError.new('Not Found')
    end

    impressionist(@question)
  end

  def contact
  end

  private

  def set_project
    @project = Project.find_by(subdomain: request.subdomain)

    impressionist(@project)

    if !@project.active?
      raise ActionController::RoutingError.new('Project not found.')
    end
  end
end
