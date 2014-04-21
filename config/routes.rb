Satiisfy::Application.routes.draw do

  # project frontend
  scope :constraints => lambda { |request| !Subdomain.match(request) } do
    get "/" => "frontend#index", as: "frontend_index"
    get "/questions" => "frontend#questions", as: "frontend_questions"
    get "/questions/:id" => "frontend#question", as: "frontend_question"
    get "/contact" => "frontend#contact", as: "frontend_contact"
  end



  # backend
  scope ":account_id" do
    resources :projects do
      resources :questions
    end
  end
  get "/:account_id/projects" => "projects#index", as: "satiisfy_root"

  resources :questions

  # user and account stuff
  resources :accounts
  devise_for :users
  as :user do
    get "/signin" => "devise/sessions#new", as: "user_login"
    get "/login" => redirect("signin")
    delete "/signout" => "devise/sessions#destroy"
  end

  # scope :constraints => lambda { |request| Subdomain.match(request) } do
  # end

  root to: redirect("/1/projects")
end


class Subdomain
  def self.match(r)
    r.subdomain == "www" || r.subdomain == ""
  end

  def self.not_match(r)
    r.subdomain != "www" || r.subdomain != ""
  end
end
