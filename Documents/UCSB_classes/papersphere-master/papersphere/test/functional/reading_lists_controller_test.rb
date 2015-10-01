require 'test_helper'
include Devise::TestHelpers

class ReadingListsControllerTest < ActionController::TestCase
  setup do
    @reading_list = reading_lists(:one)
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_lists)
  end

  test "should create reading_list" do
    assert_difference('ReadingList.count') do
      post :create, reading_list: { name: 'new_reading_list' }
    end

    assert_redirected_to reading_list_path(assigns(:reading_list))
  end

  test "should show reading_list" do
    get :show, id: @reading_list
    assert_response :success
  end

  test "should update reading_list" do
    put :update, id: @reading_list, reading_list: { name: @reading_list.name }
    assert_redirected_to reading_list_path(assigns(:reading_list))
  end

  test "should destroy reading_list" do
    assert_difference('ReadingList.count', -1) do
      delete :destroy, id: @reading_list
    end

    assert_redirected_to reading_lists_path
  end

  test "should add paper to reading list" do
    count_before = @reading_list.paper_count
    paper = Paper.new :title => 'Test Title',
                      :author => 'Test Author',
                      :publication => 'Test Publication',
                      :year => 2013,
                      :paper_code => 'TestPaperCode'

    assert_nil Paper.find_by_paper_code(paper.paper_code)

    assert_difference('ReadingListPaper.count', 1) do
      @reading_list.add_paper(paper)
    end

    assert_equal 1, @reading_list.paper_count - count_before
    reload_paper = Paper.find_by_paper_code(paper.paper_code)
    assert_not_nil reload_paper
    assert_not_nil ReadingListPaper.where(:paper_id => reload_paper.id).where(
                       :reading_list_id => @reading_list.id).first
  end

  test "should not add the same paper to reading list" do
    count_before = @reading_list.paper_count
    paper = Paper.new :title => 'Test Title',
                      :author => 'Test Author',
                      :publication => 'Test Publication',
                      :year => 2013,
                      :paper_code => 'TestPaperCode'

    assert_nil Paper.find_by_paper_code(paper.paper_code)

    assert_difference('ReadingListPaper.count', 1) do
      @reading_list.add_paper(paper)
    end

    assert_equal 1, @reading_list.paper_count - count_before

    @reading_list.reload
    assert_no_difference('ReadingListPaper.count') do
      @reading_list.add_paper(paper)
    end
  end

  test "should remove paper from reading list" do
    count_before = @reading_list.paper_count
    paper = Paper.new :title => 'Test Title',
                      :author => 'Test Author',
                      :publication => 'Test Publication',
                      :year => 2013,
                      :paper_code => 'TestPaperCode'

    assert_nil Paper.find_by_paper_code(paper.paper_code)

    assert_difference('ReadingListPaper.count', 1) do
      @reading_list.add_paper(paper)
    end

    assert_equal 1, @reading_list.paper_count - count_before
    reload_paper = Paper.find_by_paper_code('TestPaperCode')
    reading_list_paper = ReadingListPaper.where(:paper_id => reload_paper.id).where(
        :reading_list_id => @reading_list.id).first
    assert_not_nil reading_list_paper

    count_before = @reading_list.paper_count
    assert_difference('ReadingListPaper.count', -1) do
      @reading_list.remove_paper(reading_list_paper)
    end

    assert_equal 1, count_before - @reading_list.paper_count
    assert_not_nil Paper.find_by_paper_code('TestPaperCode')
  end

  test "should show reading_list form" do
    get :index
    assert_select "#reading-list-form-heading" do |elem|
      assert_equal 1, elem.length
      assert_equal 'Create Reading List', elem.first.children.first.content
    end
  end

  test "should show rename reading_list form" do
    get :show, id: @reading_list
    assert_select "#reading-list-form-heading" do |elem|
      assert_equal 1, elem.length
      assert_equal 'Rename Reading List', elem.first.children.first.content
    end
  end

end
