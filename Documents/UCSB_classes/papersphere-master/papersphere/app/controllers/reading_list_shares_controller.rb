class ReadingListSharesController < ApplicationController
  # GET /reading_list_shares
  # GET /reading_list_shares.json
  def index
    @reading_list_shares = ReadingListShare.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reading_list_shares }
    end
  end

  # GET /reading_list_shares/1
  # GET /reading_list_shares/1.json
  def show
    @reading_list_share = ReadingListShare.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading_list_share }
    end
  end

  # GET /reading_list_shares/new
  # GET /reading_list_shares/new.json
  def new
    @reading_list_share = ReadingListShare.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reading_list_share }
    end
  end

  # GET /reading_list_shares/1/edit
  def edit
    @reading_list_share = ReadingListShare.find(params[:id])
  end

  # POST /reading_list_shares
  # POST /reading_list_shares.json
  def create
    @reading_list_share = ReadingListShare.new(params[:reading_list_share])
    @reading_list = @reading_list_share.reading_list
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::OWNER)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end

    group = Group.find(params[:reading_list_share][:group_id])
    if @reading_list_share.reading_list.has_group(group)
      respond_to do |format|
        format.html { redirect_to @reading_list_share.reading_list, notice: 'Group share already exists.' }
        format.json { render json: @reading_list_share, status: :created, location: @reading_list_share }
      end
      return
    end

    if @reading_list_share.reading_list.user != @reading_list_share.group.owner
      respond_to do |format|
        format.html { redirect_to @reading_list_share.reading_list, notice: 'Group and reading list must belong to the same user.' }
        format.json { render json: @reading_list_share, status: :created, location: @reading_list_share }
      end
      return
    end
      
    respond_to do |format|
      if @reading_list_share.save
        # notify group members 
        deliver(current_user.first_name, @reading_list.name, group)        
        format.html { redirect_to @reading_list_share.reading_list, notice: 'Reading list share was successfully created.' }
        format.json { render json: @reading_list_share, status: :created, location: @reading_list_share }
      else
        format.html { render action: "new" }
        format.json { render json: @reading_list_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reading_list_shares/1
  # PUT /reading_list_shares/1.json
  def update
    @reading_list_share = ReadingListShare.find(params[:id])
    @reading_list = @reading_list_share.reading_list
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::OWNER)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end
      
    respond_to do |format|
      if @reading_list_share.update_attributes(params[:reading_list_share])
        format.html { redirect_to @reading_list_share, notice: 'Reading list share was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reading_list_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reading_list_shares/1
  # DELETE /reading_list_shares/1.json
  def destroy
    @reading_list_share = ReadingListShare.find(params[:id])
    @reading_list = @reading_list_share.reading_list
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::OWNER)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end

    @reading_list_share.destroy

    respond_to do |format|
      format.html { redirect_to @reading_list_share.reading_list, notice: "Reading list share was deleted" }
      format.json { head :no_content }
    end
  end

  private
  
  def deliver(first_name, reading_list_name, group)
    group.group_members.each { |member|
      #if the user wants this notification
      if member.user.list_shared
        ListSharedNotifier.delay.shared(first_name, reading_list_name, member.user)  
      end
    }
  end  
end
