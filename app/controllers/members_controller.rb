class MembersController < ApplicationController
  include SetMembers

  def index
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

end
