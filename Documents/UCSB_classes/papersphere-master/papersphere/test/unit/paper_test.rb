require 'test_helper'

class PaperTest < ActiveSupport::TestCase

  test 'should_create_paper' do
    paper = Paper.new :title => 'title',
                      :author => 'author',
                      :publication => 'publication',
                      :year => 2013,
                      :paper_code => 'TEST_200'
    assert paper.valid?
  end

  test 'should_not_create_paper_without_title' do
    paper = Paper.new :author => 'author',
                      :publication => 'publication',
                      :year => 2013
    assert paper.invalid?
  end

  test 'should_not_create_paper_without_author' do
    paper = Paper.new :title => 'title',
                      :publication => 'publication',
                      :year => 2013
    assert paper.invalid?
  end

  test 'should_not_create_paper_without_publication' do
    paper = Paper.new :author => 'author',
                      :title => 'title',
                      :year => 2013
    assert paper.invalid?
  end

  test 'should_not_create_paper_without_year' do
    paper = Paper.new :author => 'author',
                      :publication => 'publication',
                      :title => 'title'
    assert paper.invalid?
  end

end
