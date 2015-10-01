class ReadingListsController < ApplicationController
  # GET /reading_lists
  # GET /reading_lists.json
  def index
    @reading_lists = ReadingList.find_all_by_user_id(current_user)
    @reading_list = ReadingList.new
    @shared_lists = ReadingListsHelper::get_shared_lists(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reading_lists }
    end
  end

  # GET /reading_lists/1
  # GET /reading_lists/1.json
  def show
    @reading_list = ReadingList.includes(:papers).find(params[:id])
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::READONLY)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to current_user.reading_lists, alert: @paper_mgt_notification }
      end
      return
    end

    @is_owner = false
    @has_modify_rights = false
    rights = ReadingListsHelper::get_shared_list_access_rights(@reading_list, current_user)
    if rights == ReadingListsHelper::OWNER
      @is_owner = true
      @has_modify_rights = true
    elsif rights == ReadingListsHelper::READWRITE
      @has_modify_rights = true
    end

    @reading_list_share = ReadingListShare.new
    @reading_list_share.reading_list = @reading_list

    if params[:from_group]
      @group = Group.find(params[:from_group])
    else
      @group = nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading_list }
    end
  end

  # POST /reading_lists
  # POST /reading_lists.json
  def create
    @reading_list = ReadingList.new(params[:reading_list])
    @reading_list.user = current_user

    list_name_exists = false
    current_user.reading_lists.each do |rl|
      if rl.name == @reading_list.name
        list_name_exists = true
      end
    end

    respond_to do |format|
      if list_name_exists
        format.html { redirect_to @reading_list, :notice => "You already have a list by the name '#{@reading_list.name}'." }
        format.json { render :json => @reading_list, :status => :created, :location => @reading_list }
      elsif @reading_list.save
        format.html { redirect_to @reading_list, :notice => 'Reading list was successfully created.' }
        format.json { render :json => @reading_list, :status => :created, :location => @reading_list }
      else
        error_msg = 'Unexpected error while creating reading list.'
        if @reading_list.errors.messages.count > 0
          error_msg = 'Following error(s) prevented the reading list from being saved: '
          multiple = false
          @reading_list.errors.full_messages.each do |msg|
            if multiple
              error_msg += ', '
            end
            error_msg += msg
            multiple = true
          end
        end
        format.html { redirect_to reading_lists_path, :action => 'index', :alert => error_msg }
        format.json { render :json => @reading_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reading_lists/1
  # PUT /reading_lists/1.json
  def update
    @reading_list = ReadingList.find(params[:id])
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::OWNER)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end

    new_list_name = params[:reading_list][:name]
    list_name_exists = false

    if new_list_name != @reading_list.name
      current_user.reading_lists.each do |rl|
        if rl.name == new_list_name
          list_name_exists = true
          break
        end
      end
    end

    respond_to do |format|
      if list_name_exists
        format.html { redirect_to @reading_list, :alert => "You already have a list by the name '#{new_list_name}'." }
        format.json { head :no_content }
      elsif new_list_name == @reading_list.name
        format.html { redirect_to @reading_list }
        format.json { head :no_content }
      elsif @reading_list.update_attributes(params[:reading_list])
        format.html { redirect_to @reading_list, :notice => 'Reading list was successfully updated.' }
        format.json { head :no_content }
      else
        error_msg = 'Unexpected error while updating reading list.'
        if @reading_list.errors.messages.count > 0
          error_msg = 'Following error(s) prevented the reading list from being saved: '
          multiple = false
          @reading_list.errors.full_messages.each do |msg|
            if multiple
              error_msg += ', '
            end
            error_msg += msg
            multiple = true
          end
        end
        format.html { redirect_to @reading_list, :alert => error_msg }
        format.json { render :json => @reading_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reading_lists/1
  # DELETE /reading_lists/1.json
  def destroy
    @reading_list = ReadingList.find(params[:id])
    if not ReadingListsHelper::has_access(@reading_list, current_user, ReadingListsHelper::OWNER)
      @paper_mgt_notification = 'User not authorized.'
      respond_to do |format|
        format.html { redirect_to @reading_list, notice: @paper_mgt_notification }
        format.js {}
      end
      return
    end

    @reading_list.destroy

    respond_to do |format|
      format.html { redirect_to reading_lists_url }
      format.json { head :no_content }
    end
  end
end
