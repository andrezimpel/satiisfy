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

    resources :projects do
      resources :questions
    end


    # invitation
    devise_scope :user do
      get "team/invite", :to => "users/invitations#new", :as => "user_invitation"
      post "team/invite", :to => "users/invitations#create"
    end

    # user profiles
    get "team" => "users#index", as: "users"
    get "team/:id/" => "users#show", as: "user"
    get "team/:id/edit" => "users#edit", as: "edit_user"
    patch "team/:id/" => "users#update"
    put "team/:id/" => "users#update"
    # get "users/destroy"
  end
  get "/:account_id/projects" => "projects#index", as: "satiisfy_root"

  resources :questions

  # signup
  get "/signup" => "accounts#new", as: "signup"
  get "/accounts/new" => redirect("/signup")

  # user and account stuff
  resources :accounts
  devise_for :users,
              :controllers => { :invitations => 'users/invitations', :registrations => "users/registrations" },
              :path => "",
              :path_names => {:sign_in => 'login', :sign_up => "signup", :sign_out => 'logout'}
  as :user do
    get "/login" => "devise/sessions#new", as: "user_login"
    get "/signin" => redirect("login")
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
