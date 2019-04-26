Rails.application.routes.draw do

resources :categories
resources :products


root "home#welcome"
end
