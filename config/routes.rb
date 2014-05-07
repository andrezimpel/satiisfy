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
    resources :accounts
    resources :profiles
    resources :profiles, :path => 'members',  as: :members
    resources :projects do
      resources :questions
    end
  end
  get "/:account_id/projects" => "projects#index", as: "satiisfy_root"

  resources :questions

  # signup
  get "/signup" => "accounts#new", as: "signup"
  get "/accounts/new" => redirect("/signup")

  # user and account stuff
  resources :accounts
  devise_for :users, :controllers => { :invitations => 'users/invitations', :registrations => "users/registrations" }
  as :user do
    get "/signin" => "devise/sessions#new", as: "user_login"
    get "/login" => redirect("signin")
    delete "/signout" => "devise/sessions#destroy"
  end

  root 'projects#index'
end


class Subdomain
  def self.match(r)
    r.subdomain == "www" || r.subdomain == ""
  end

  def self.not_match(r)
    r.subdomain != "www" || r.subdomain != ""
  end
end
