require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  def test_google_oauth2_logs_user_in_if_user_found
    User.expects(:find_for_google_oauth2).returns(users(:alice))
    login_as users(:alice)

    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :google_oauth2
    
    assert_redirected_to root_path
    assert warden.authenticated? :user
  end
  
  def test_google_oauth2_redirects_to_sign_up_if_user_not_found
    User.expects(:find_for_google_oauth2).returns(User.new)

    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :google_oauth2
    
    assert_redirected_to new_user_registration_path
    assert_equal false, warden.authenticated?(:user)
  end
  
end