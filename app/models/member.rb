class Member < ApplicationRecord
  validates :name, :original_website, presence: true
  validates :original_website, url: true, on: :create
  validates :name, uniqueness: true

  def as_json(options={})
    {
      id: id,
      name: name,
      original_website: original_website,
      website: website
    }
  end
end
