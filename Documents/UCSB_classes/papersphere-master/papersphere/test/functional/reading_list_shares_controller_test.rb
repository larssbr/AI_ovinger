require 'test_helper'
include Devise::TestHelpers

class ReadingListSharesControllerTest < ActionController::TestCase
  setup do
    @reading_list_share = reading_list_shares(:one)
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_list_shares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not create duplicate reading_list_share" do
    assert_no_difference('ReadingListShare.count') do
      post :create, reading_list_share: { access_rights: @reading_list_share.access_rights, group_id: @reading_list_share.group_id, reading_list_id: @reading_list_share.reading_list_id }
    end

    assert_redirected_to @reading_list_share.reading_list
  end

  test "should show reading_list_share" do
    get :show, id: @reading_list_share
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reading_list_share
    assert_response :success
  end

  test "should update reading_list_share" do
    put :update, id: @reading_list_share, reading_list_share: { access_rights: @reading_list_share.access_rights, group_id: @reading_list_share.group_id, reading_list_id: @reading_list_share.reading_list_id }
    assert_redirected_to reading_list_share_path(assigns(:reading_list_share))
  end

  test "should destroy reading_list_share" do
    assert_difference('ReadingListShare.count', -1) do
      delete :destroy, id: @reading_list_share
    end

    assert_redirected_to @reading_list_share.reading_list
  end
end
