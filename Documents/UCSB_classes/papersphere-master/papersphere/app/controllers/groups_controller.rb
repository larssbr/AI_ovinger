class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.find_all_by_owner_id(current_user)
    @group = Group.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.includes(:users).find(params[:id])
    @group_member = GroupMember.new
    @group_member.group = @group

    if params[:from_reading_list]
      @reading_list = ReadingList.find(params[:from_reading_list])
    else
      @reading_list = nil
    end

    respond_to do |format|
      if @group.owner == current_user
        format.html
        format.json { render json: @group }
      else
        msg = "You are not authorized to access group #{params[:id]}."
        format.html { redirect_to groups_url, alert: msg }
        format.json { render json: msg }
      end
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group.owner = current_user

    group_name_exists = false
    current_user.owned_groups.each do |g|
      if g.name == @group.name
        group_name_exists = true
        break
      end
    end
    
    respond_to do |format|
      if group_name_exists
        format.html { redirect_to groups_path, :alert => "You already have a list by the name '#{@group.name}'." }
        format.json { render :json => @group, :status => :created, :location => @group }
      elsif @group.save
        format.html { redirect_to @group, :notice => 'Group was successfully created.' }
        format.json { render :json => @group, :status => :created, :location => @group }
      else
        error_msg = 'Unexpected error while creating group.'
        if @group.errors.messages.count > 0
          error_msg = 'Following error(s) prevented the group from being saved: '
          multiple = false
          @group.errors.full_messages.each do |msg|
            if multiple
              error_msg += ', '
            end
            error_msg += msg
            multiple = true
          end
        end
        format.html { redirect_to groups_path, :action => 'index', :alert => error_msg }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    if @group.owner != current_user
      respond_to do |format|
        format.html { redirect_to @group, notice: 'User not authorized.' }
        format.json { render json: @group, status: :not_authorized, location: group }
      end
      return
    end

    new_group_name = params[:group][:name]
    group_name_exists = false

    if new_group_name != @group.name
      current_user.owned_groups.each do |g|
        if g.name == new_group_name
          group_name_exists = true
        end
      end
    end
      
    respond_to do |format|
      if group_name_exists
        format.html { redirect_to @group, :alert => "You already have a group by the name '#{new_group_name}'." }
        format.json { head :no_content }
      elsif new_group_name == @group.name
        format.html { redirect_to @group }
        format.json { head :no_content }
      elsif @group.update_attributes(params[:group])
        format.html { redirect_to @group, :notice => 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        error_msg = 'Unexpected error while updating group.'
        if @group.errors.messages.count > 0
          error_msg = 'Following error(s) prevented the group from being saved: '
          multiple = false
          @group.errors.full_messages.each do |msg|
            if multiple
              error_msg += ', '
            end
            error_msg += msg
            multiple = true
          end
        end
        format.html { redirect_to @group, :alert => error_msg }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
      
    if @group.owner != current_user
      respond_to do |format|
        format.html { redirect_to @group, notice: 'User not authorized.' }
        format.json { render json: @group, status: :not_authorized, location: group }
      end
      return
    end
      
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
