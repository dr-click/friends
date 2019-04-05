module MembersHelper

  def current_member
    Member.find(session["current_member_id"]) if session["current_member_id"]
  rescue
    session["current_member_id"] = nil
  end

  def can_manage_friendships(friend)
    current_member && current_member != friend
  end

  def can_add_friend(friend)
    !Friendship.are_friends?(current_member, friend)
  end

end
