Satiisfy::Application.routes.draw do

  # project frontend
  scope :constraints => lambda { |request| !Subdomain.match(request) } do
    get "/" => "frontend#index", as: "frontend_index"
    get "/questions" => "frontend#questions", as: "frontend_questions"
    get "/questions/:id" => "frontend#question", as: "frontend_question"
    get "/contact" => "frontend#contact", as: "frontend_contact"
  end



  # backend
  resources :projects do
    resources :questions
  end

  resources :questions
  # scope :constraints => lambda { |request| Subdomain.match(request) } do
  # end

  root to: redirect('/projects')
end


class Subdomain
  def self.match(r)
    r.subdomain == "www" || r.subdomain == ""
  end

  def self.not_match(r)
    r.subdomain != "www" || r.subdomain != ""
  end
end
