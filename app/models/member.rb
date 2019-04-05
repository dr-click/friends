class Member < ApplicationRecord
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
    Friendship.where("member_id = ? OR friend_id = ?", self.id, self.id).includes(:member, :friend)
  end

  def my_friends
    ids = friends.map{|u| [u.member_id, u.friend_id] }.flatten
    ids -= [self.id]
    Member.find(ids)
  end

  #######
  private
  #######

  def perform_url_shortener
    UrlShortenerJob.perform_later(self.id)
    PageCrawlJob.perform_later(self.id)
  end
end
