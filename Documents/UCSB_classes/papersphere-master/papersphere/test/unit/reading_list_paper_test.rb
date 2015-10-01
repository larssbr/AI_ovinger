require 'test_helper'

class ReadingListPaperTest < ActiveSupport::TestCase
  
  def test_reading_list_paper_for_returns_correct_reading_list_paper
    paper = papers(:one)
    reading_list = reading_lists(:one)
    reading_list_paper_expected = reading_list_papers(:one)
    
    assert_equal reading_list_paper_expected, ReadingListPaper.reading_list_paper_for(reading_list.id, paper.id)
  end
  
end
