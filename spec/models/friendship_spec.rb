require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { create(:friendship) }

  context 'model' do
    let(:model) { Friendship.new }

    it { should belong_to(:member)}
    it { should belong_to(:friend)}
  end

  context 'object' do
    it "has a valid record" do
      expect(friendship).to be_valid
    end

    it "accepts member" do
      expect(build(:friendship, member: build(:member))).to be_valid
    end

    it "accepts friend" do
      expect(build(:friendship, friend: build(:member))).to be_valid
    end

    [:member, :friend].each do |attr|
      it "is invalid without #{attr}" do
        member_2 = build(:friendship, attr => nil)

        expect(member_2).not_to be_valid
        expect(member_2.errors).to include(attr)
      end
    end

    context 'with the same friendship' do
      let(:friendship_2) { build(:friendship) }

      it "should be unique" do
        friendship_2.member = friendship.member
        friendship_2.friend = friendship.friend

        expect(friendship_2).not_to be_valid
        expect(friendship_2.errors).to include(:member_id)
      end
    end
  end
end
