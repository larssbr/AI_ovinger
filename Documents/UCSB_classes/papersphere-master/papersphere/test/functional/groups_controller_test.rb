require 'test_helper'
include Devise::TestHelpers

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should create group" do
    group_name = '_new_group_name_'
    assert_difference('Group.count') do
      post :create, group: { name: group_name }
    end

    new_group = Group.find_by_name(group_name)
    assert_not_nil new_group
    assert_redirected_to group_path(new_group)
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should update group" do
    put :update, id: @group, group: { name: @group.name }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end

  test "should show add group form" do
    get :index
    assert_select "#group-form-heading" do |elem|
      assert_equal 1, elem.length
      assert_equal 'Create New Group', elem.first.children.first.content
    end
  end

  test "should show rename group form" do
    get :show, id: @group
    assert_select "#group-form-heading" do |elem|
      assert_equal 1, elem.length
      assert_equal 'Rename Group', elem.first.children.first.content
    end
  end

end
