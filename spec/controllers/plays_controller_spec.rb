require 'rails_helper'

describe PlaysController do
  describe 'GET /' do
    it 'responds with a status 200' do
      get :game
      expect(response.status).to eq(200)
    end
  end
end
