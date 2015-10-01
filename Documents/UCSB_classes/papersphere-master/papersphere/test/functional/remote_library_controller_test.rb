require 'test_helper'
include Devise::TestHelpers

class RemoteLibraryControllerTest < ActionController::TestCase

  setup do
    sign_in User.first
    @reading_list = reading_lists(:one)
  end

  test 'should get search' do
    xhr :get, :search, { :reading_list_id => @reading_list.id }
    assert_response :success
  end

end
