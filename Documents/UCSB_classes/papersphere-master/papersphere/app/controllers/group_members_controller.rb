class GroupMembersController < ApplicationController
  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_members }
    end
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
    @group_member = GroupMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_member }
    end
  end

  # GET /group_members/new
  # GET /group_members/new.json
  def new
    @group_member = GroupMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_member }
    end
  end

  # GET /group_members/1/edit
  def edit
    @group_member = GroupMember.find(params[:id])
  end

  # POST /group_members
  # POST /group_members.json
  def create
    member_email = params[:member_email]
    member = User.find_by_email(member_email)
    group = Group.find(params[:group_member][:group_id])
      
    if group.owner != current_user
      respond_to do |format|
        format.html { redirect_to group, notice: 'User not authorized.' }
        format.json { render json: group, status: :not_authorized, location: group }
      end
      return
    end
      
    if member
      if !group.has_member(member_email)
        @group_member = GroupMember.new
        @group_member.user = member
        @group_member.group = group
        if @group_member.save
          message = "Successfully added #{member_email} to the group"
          AddUserToGroupNotifier.delay.added(@group_member.user, @current_user.name)
        end
      else
        message = "Group already contains the member #{member_email}"
      end
    else
      message = "No member exists with the email #{member_email}"
    end

    respond_to do |format|
      format.html { redirect_to group, notice: message }
      format.json { render json: group, status: :created, location: @group_member }
    end
  end

  # PUT /group_members/1
  # PUT /group_members/1.json
  def update
    @group_member = GroupMember.find(params[:id])

    if @group_member.group.owner != current_user
      respond_to do |format|
        format.html { redirect_to @group_member.group, notice: 'User not authorized.' }
        format.json { render json: @group_member, status: :not_authorized, location: @group_member }
      end
      return
    end
      
    respond_to do |format|
      if @group_member.update_attributes(params[:group_member])
        format.html { redirect_to @group_member, notice: 'Group member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    @group_member = GroupMember.find(params[:id])

    if @group_member.group.owner != current_user
      respond_to do |format|
        format.html { redirect_to @group_member.group, notice: 'User not authorized.' }
        format.json { render json: @group_member, status: :not_authorized, location: @group_member }
      end
      return
    end

    group = @group_member.group
    @group_member.destroy

    respond_to do |format|
      format.html { redirect_to group_url(group) }
      format.json { head :no_content }
    end
  end
end
