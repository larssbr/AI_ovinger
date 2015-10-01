require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'should_create_group' do
    group = Group.new(:name => 'foo')
    assert group.valid?
  end

  test 'should_not_create_group_without_name' do
    group = Group.new
    assert group.invalid?
  end

end
