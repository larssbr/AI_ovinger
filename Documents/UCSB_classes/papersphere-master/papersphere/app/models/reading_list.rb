class ReadingList < ActiveRecord::Base
  belongs_to :user
  has_many :reading_list_papers, :dependent => :destroy
  has_many :papers, :through => :reading_list_papers
  has_many :reading_list_shares, :dependent => :destroy
  has_many :groups, :through => :reading_list_shares
  attr_accessible :name, :paper_count

  validates :name, :presence => true

  TXN_INCOMPLETE = :rl_txn_incomplete
  TXN_PAPER_ALREADY_IN_READING_LIST = :rl_txn_paper_in_list
  TXN_SUCCESSFUL = :rl_txn_success
  
  def has_group(my_group)
    groups.each { |group|
      if group == my_group
        return true
      end
    }
    false
  end

  def has_paper(paper_code)
    self.papers.each do |p|
      if p.paper_code == paper_code
        return true
      end
    end
    false
  end

  def add_paper(paper)
    status = TXN_INCOMPLETE
    transaction do
      self.papers.each do |p|
        if p.paper_code == paper.paper_code
          status = TXN_PAPER_ALREADY_IN_READING_LIST
          raise ActiveRecord::Rollback
        end
      end

      existing_paper = Paper.find_by_paper_code(paper.paper_code)
      if existing_paper.nil?
        paper.save!
      else
        paper = existing_paper
      end

      reading_list_paper = ReadingListPaper.new
      reading_list_paper.paper = paper
      reading_list_paper.reading_list = self
      reading_list_paper.save!

      self.update_attributes!(:paper_count => self.paper_count + 1)
      status = TXN_SUCCESSFUL
    end

    status
  end

  def remove_paper(reading_list_paper)
    status = TXN_INCOMPLETE
    transaction do
      reading_list_paper.destroy
      self.update_attributes!(:paper_count => self.paper_count - 1)
      status = TXN_SUCCESSFUL
    end
    status
  end

end
