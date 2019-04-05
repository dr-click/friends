module Friendships
  class CreateService < ::BaseService
    attr_reader :friend, :member, :friendship

    def initialize(user, user_2)
      @member = user
      @friend = user_2
    end

    def _execute
      return friendship if friendship_exists?
      create_friendship
      friendship
    end

    #######
    private
    #######

    def friendship_exists?
      Friendship.are_friends?(member, friend)
    end

    def create_friendship
      @friendship = Friendship.create(member_id: member.id, friend_id: friend.id)
    end

  end
end