class MembersController < ApplicationController
  include SetMembers

  def index
    @members = Members::SearchService.new(search_keyword).execute
    @search_keyword = search_keyword
  end

  def search
    @members = Members::MemberSearchService.new(search_keyword).execute
    @search_keyword = search_keyword
  end

  def show
  end

  def new
    # respond to HTML only
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @member = Members::CreateService.new(member_params).execute
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, member: @member }
      else
        format.html { render :new }
        format.json { render_unprocessable(@member.errors.messages) }
      end
    end
  end

  def set_current
    session["current_member_id"] = @member.id
    respond_to do |format|
      format.html { redirect_to members_path, notice: 'Done successfully.' }
      format.json { render :json => {}, status: :ok }
    end
  end

  #######
  private
  #######

  def search_keyword
    params[:keyword]
  end

end
