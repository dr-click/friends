class Member < ApplicationRecord
  include MemberSearch

  validates :name, :original_website, presence: true
  validates :original_website, url: true, on: :create
  validates :name, uniqueness: true

  after_create :perform_url_shortener

  has_many :friends, class_name: 'Friendship'

  def as_json(options={})
    {
      id: id,
      name: name,
      original_website: original_website,
      website: website
    }
  end

  def friends
    Friendship.where("member_id = ? OR friend_id = ?", self.id, self.id)
  end

  def my_friends
    ids = friends.map{|u| [u.member_id, u.friend_id] }.flatten
    ids -= [self.id]
    Member.find(ids)
  end

  def mutual_friends(user)
    return [] if self == user
    ids = friends.map{|u| [u.member_id, u.friend_id] }.flatten.push(0)
    friend_ids = Friendship.where("member_id in (?) OR friend_id in (?)", ids, ids).map{|u| [u.member_id, u.friend_id] }.flatten

    puts " > > > > > ids : #{ids.inspect}"
    friend_ids -= [self.id, user.id]
    Member.find(friend_ids)
  end

  #######
  private
  #######

  def perform_url_shortener
    UrlShortenerJob.perform_later(self.id)
    PageCrawlJob.perform_later(self.id)
  end
end
