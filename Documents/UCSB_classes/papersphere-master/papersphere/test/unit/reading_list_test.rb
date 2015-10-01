require 'test_helper'

class ReadingListTest < ActiveSupport::TestCase

  test 'should_create_reading_list' do
    reading_list = ReadingList.new(:name => 'foo')
    assert reading_list.valid?
  end

  test 'should_not_create_reading_list_without_name' do
    reading_list = ReadingList.new
    assert reading_list.invalid?
  end

end
