module MembersHelper
  def current_member
    Member.find(session["current_member_id"]) if session["current_member_id"]
  end
end
