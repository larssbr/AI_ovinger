class ReadingListPapersController < ApplicationController
  # GET /reading_list_papers
  # GET /reading_list_papers.json
  def index
    @reading_list_papers = ReadingListPaper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reading_list_papers }
    end
  end

  # GET /reading_list_papers/1
  # GET /reading_list_papers/1.json
  def show
    @reading_list_paper = ReadingListPaper.find(params[:id])
    @paper = @reading_list_paper.paper
    @reading_list = @reading_list_paper.reading_list

    @reading_list = @reading_list_paper.reading_list
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::READONLY)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading_list_paper }
    end
  end

  # GET /reading_list_papers/new
  # GET /reading_list_papers/new.json
  def new
    @reading_list_paper = ReadingListPaper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reading_list_paper }
    end
  end

  # POST /reading_list_papers
  # POST /reading_list_papers.json
  def create
    @reading_list = ReadingList.find(params[:reading_list_id])

    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::READWRITE)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, :alert => @paper_mgt_notification }
        format.js {}
      end
      return
    end

    @is_owner = @reading_list.user == current_user
    @has_modify_rights = true
    
    @paper = Paper.new
    @paper.title = params[:paper_title]
    @paper.author = params[:paper_authors]
    @paper.publication = params[:paper_publication]
    @paper.year = params[:paper_year]
    @paper.url = params[:paper_url]
    @paper.paper_code = params[:paper_code]

    @reading_list_paper = ReadingListPaper.new
    @success = false
    begin
      result = @reading_list.add_paper(@paper)
      if result == ReadingList::TXN_SUCCESSFUL
        @paper_mgt_notification = "Paper titled '#{@paper.title}' was added to the list successfully."
        @success = true
        # notify list members 
        deliver(current_user.first_name, @paper.title, @reading_list) 
      
      elsif result == ReadingList::TXN_PAPER_ALREADY_IN_READING_LIST
        @paper_mgt_notification = "Paper '#{@paper.title}' already exists in the list."
      else
        @paper_mgt_notification = "Unexpected error while adding paper '#{@paper.title}' to the list"
      end
    rescue Exception => ex
      @paper_mgt_notification = "Error while adding paper to reading list: #{ex.message}"
    end

    @reading_list.reload

    respond_to do |format|
      format.js
    end
  end

  # DELETE /reading_list_papers/1
  # DELETE /reading_list_papers/1.json
  def destroy
    @reading_list_paper = ReadingListPaper.find(params[:id])
    @reading_list = @reading_list_paper.reading_list
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::READWRITE)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, :alert => @paper_mgt_notification }
        format.js {}
      end
      return
    end

    @reading_list.remove_paper(@reading_list_paper)

    respond_to do |format|
      format.html { redirect_to reading_list_papers_url }
      format.json { head :no_content }
    end
  end

  def remove_paper_from_list
    @reading_list = ReadingList.find(params[:reading_list_id])

    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::READWRITE)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end

    @is_owner = @reading_list.user == current_user
    @has_modify_rights = true
    @reading_list_paper = ReadingListPaper.
        where(:reading_list_id => params[:reading_list_id]).
        where(:paper_id => params[:paper_id]).
        first
        
    @paper_mgt_notification = ''
    @success = false
    if !@reading_list_paper.nil?
      title = @reading_list_paper.paper.title
      @reading_list.remove_paper(@reading_list_paper)
      @success = true
      @paper_mgt_notification = "Successfully removed the paper '#{title}' from the list."
    else
      @paper_mgt_notification = 'Failed to locate the specified paper in the database.'
    end

    @reading_list.reload
    respond_to do |format|
      format.js
    end
  end

  private

  def deliver(first_name, paper_title, reading_list)
    # send an email to each member of the reading list   
    reading_list.reading_list_shares.each { |reading_list_share|
      group = reading_list_share.group
      group.group_members.each { |member|
        #if the user wants this notification
        if member.user.paper_added
          PaperAddedNotifier.delay.added(first_name, paper_title, member.user, reading_list.name)      
        end
      }
    }
  end
end
