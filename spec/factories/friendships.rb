FactoryBot.define do
  factory :friendship do
    member    { build(:member) }
    friend    { build(:member) }
  end
end
