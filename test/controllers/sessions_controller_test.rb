require 'test_helper'

describe SessionsController do
  describe 'auth_callback' do
    it 'logs in an existing user and redirects to root route' do
      start_count = User.count

      person = users(:june)

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(person))

      get auth_callback_path(:github)

      must_redirect_to root_path
    end
  end
end
