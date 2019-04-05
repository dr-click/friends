class Friendship < ApplicationRecord

  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  validates :member_id, uniqueness: {scope: :friend_id}

  def self.are_friends?(user, user_2)
    Friendship.where(member_id: user.id, friend_id: user_2.id).or(Friendship.where(member_id: user_2.id, friend_id: user.id)).any?
  end
end
