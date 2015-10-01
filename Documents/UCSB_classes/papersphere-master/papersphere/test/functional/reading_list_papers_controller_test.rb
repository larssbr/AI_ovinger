require 'test_helper'
include Devise::TestHelpers

class ReadingListPapersControllerTest < ActionController::TestCase

  setup do
    @reading_list_paper = reading_list_papers(:one)
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_list_papers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reading_list_paper" do
    reading_list = ReadingList.find(@reading_list_paper.reading_list_id)
    before_papers = reading_list.papers.count
    assert_equal reading_list.papers.count, reading_list.paper_count

    assert_difference('ReadingListPaper.count') do
      xhr :post, :create, {
          :paper_title => 'MyAwesomePaper',
          :paper_authors => 'Authors',
          :paper_year => 2013,
          :paper_publication => 'Publication',
          :paper_url => 'URL',
          :paper_code => 'TEST_300',
          :reading_list_id => @reading_list_paper.reading_list_id
      }
    end
    assert_response :success
    paper = Paper.find_by_title('MyAwesomePaper')
    assert_not_nil paper

    reading_list.reload
    assert_equal 1, reading_list.papers.count - before_papers
    assert_equal reading_list.papers.count, reading_list.paper_count
  end

  test "should not add same paper twice to a list" do
    paper_data = {
        :paper_title => 'MyAwesomePaper',
        :paper_authors => 'Authors',
        :paper_year => 2013,
        :paper_publication => 'Publication',
        :paper_url => 'URL',
        :paper_code => 'TEST_300',
        :reading_list_id => @reading_list_paper.reading_list_id
    }

    reading_list = ReadingList.find(@reading_list_paper.reading_list_id)
    before_papers = reading_list.papers.count

    assert_difference('ReadingListPaper.count') do
      xhr :post, :create, paper_data
    end
    assert_response :success
    paper = Paper.find_by_title('MyAwesomePaper')
    assert_not_nil paper
    reading_list.reload
    after_papers = reading_list.papers.count
    assert_equal 1, after_papers - before_papers

    assert_no_difference('ReadingListPaper.count') do
      xhr :post, :create, paper_data
    end
    assert_response :success
    reading_list.reload
    assert_equal after_papers, reading_list.papers.count
  end

  test "should show reading_list_paper" do
    get :show, id: @reading_list_paper
    assert_response :success
    assert_equal @reading_list_paper.reading_list.papers.count, @reading_list_paper.reading_list.paper_count
  end

  test "should destroy reading_list_paper" do
    assert_difference('ReadingListPaper.count', -1) do
      delete :destroy, id: @reading_list_paper
    end

    assert_equal @reading_list_paper.reading_list.papers.count, @reading_list_paper.reading_list.paper_count
    assert_redirected_to reading_list_papers_path
  end
end
