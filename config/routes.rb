Rails.application.routes.draw do
  root 'plays#game'

  post 'images', to: "plays#images"
end
