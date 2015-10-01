require 'test_helper'
include Devise::TestHelpers

class GroupMembersControllerTest < ActionController::TestCase
  setup do
    @group_member = group_members(:one)
    @group_member2 = group_members(:two)
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_member" do
    assert_difference('GroupMember.count') do
      post :create, :group_member => { :group_id => @group_member.group_id },
           :member_email => @group_member2.user.email
    end

    assert_redirected_to @group_member.group
  end

  test 'should_not_add_same_member_twice' do
    assert_no_difference('GroupMember.count') do
      post :create, :group_member => { :group_id => @group_member.group_id },
           :member_email => @group_member.user.email
    end

    assert_redirected_to @group_member.group
  end

  test 'should_not_add_invalid_member' do
    assert_no_difference('GroupMember.count') do
      post :create, :group_member => { :group_id => @group_member.group_id },
           :member_email => 'bogus@test.com'
    end

    assert_redirected_to @group_member.group
  end

  test "should show group_member" do
    get :show, id: @group_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_member
    assert_response :success
  end

  test "should update group_member" do
    put :update, id: @group_member, group_member: { group_id: @group_member.group_id, user_id: @group_member.user_id }
    assert_redirected_to group_member_path(assigns(:group_member))
  end

  test "should destroy group_member" do
    assert_difference('GroupMember.count', -1) do
      delete :destroy, id: @group_member
    end

    assert_redirected_to group_path(@group_member.group)
  end
end
