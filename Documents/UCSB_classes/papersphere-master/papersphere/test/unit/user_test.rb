require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test 'should_create_new_user' do
    charles = User.new :email => 'charles@test.com',
                     :name => 'Charles',
                     :password => 'password',
                     :password_confirmation => 'password'
    assert charles.save
    charles_copy = User.find(charles.id)
    assert_equal charles.email, charles_copy.email
    assert_equal charles.name, charles_copy.name
  end

  test 'should_not_allow_creating_user_with_existing_username' do
    alice = User.new :email => users(:alice).email,
                     :name => users(:alice).name,
                     :password => 'password',
                     :password_confirmation => 'password'
    assert_equal false, alice.save
  end
  
  test 'find_for_google_oauth2_should_create_and_return_new_user_when_not_found' do
    access_token_mock = mock()
    info_hash_stub = {
      "email" => "really-long-email-that-shouldnt-be-in-the-db@hopefully.com",
      "name" => "The Grinch"
    }
    access_token_mock.expects(:info).returns(info_hash_stub)
    
    user = nil
    assert_difference "User.count", 1 do
      user = User.find_for_google_oauth2(access_token_mock)
    end
    
    assert user.persisted?
    assert_equal "really-long-email-that-shouldnt-be-in-the-db@hopefully.com", user.email
    assert_equal "The Grinch", user.name
  end
  
  test 'find_for_google_oauth2_should_return_existing_user_if_found' do
    access_token_mock = mock()
    info_hash_stub = {
      "email" => users(:alice).email,
      "name" => users(:alice).name
    }
    access_token_mock.expects(:info).returns(info_hash_stub)
    
    user = nil
    assert_no_difference "User.count" do
      user = User.find_for_google_oauth2(access_token_mock)
    end
    
    assert user.persisted?
    assert_equal users(:alice), user
  end
  
  test 'name_returns_first_and_last_name' do
    user = users(:alice)
    
    assert_equal "#{user.first_name} #{user.last_name}", user.name
  end
  
  test 'name=_sets_first_and_last_name' do
    user = users(:alice)
    
    user.name = "Han Solo"
    
    assert_equal "Han", user.first_name
    assert_equal "Solo", user.last_name
  end

end
