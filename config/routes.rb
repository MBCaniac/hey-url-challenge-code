# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  resources :urls, only: %i[index create show], param: :url
  get ':short_url', to: 'urls#visit', as: :visit

  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
end
