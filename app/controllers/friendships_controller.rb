class FriendshipsController < ApplicationController
  include MemberSessions
  include SetMembers

  def create
    @friendship = Friendships::CreateService::new(current_member, friend).execute
    respond_to do |format|
      if @friendship && @friendship.persisted?
        format.html { redirect_to friend, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created }
      else
        msg = 'Friendship was not created.'
        format.html { redirect_to friend, flash: { :error => msg } }
        format.json { render_unprocessable(msg) }
      end
    end
  end

  #######
  private
  #######

  def friend
    @_friend ||= Member.find(params[:member_id])
  end

end
