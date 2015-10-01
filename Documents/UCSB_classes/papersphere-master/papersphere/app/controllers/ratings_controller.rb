class RatingsController < ApplicationController
  
  before_filter :find_reading_list_paper
  
  def create
    if not ReadingListsHelper::has_access(@reading_list_paper.reading_list, current_user, ReadingListsHelper::READONLY)
      respond_to do |format|
        format.html { redirect_to reading_list_paper_path(@reading_list_paper), notice: 'User not authorized.' }
        format.js
      end
      return
    end
    
    # TODO check if already rated
      
    @rating = Rating.new(params[:rating])
    @rating.reading_list_paper = @reading_list_paper
    @rating.user = current_user
    
    if @rating.save
      respond_to do |format|
        format.html { redirect_to reading_list_paper_path(@reading_list_paper), :notice => "Your rating has been saved" }
        format.js
      end
    end
  end
  
  def update
    @rating = Rating.find(params[:id])
    
    if @rating.user != current_user
      respond_to do |format|
        format.html { redirect_to reading_list_paper_path(@reading_list_paper), notice: 'User not authorized.' }
        format.js
      end
      return
    end
      
    if @rating.update_attributes(params[:rating])
      respond_to do |format|
        format.html { redirect_to reading_list_paper_path(@reading_list_paper), :notice => "Your rating has been updated" }
        format.js
      end
    end
  end
  
  private
  
  def find_reading_list_paper
    @reading_list_paper = ReadingListPaper.find(params[:reading_list_paper_id])
  end
  
end
