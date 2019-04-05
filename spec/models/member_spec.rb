require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { build(:member) }

  context 'model' do
    let(:model) { Member.new }

    [:name, :original_website].each do |attr|
      it { should validate_presence_of(attr) }

      it "doesnt allow nil values for #{attr}" do
        expect(model).not_to allow_value(nil).for(attr)
      end
    end

    it "allows nil values for website" do
      expect(model).to allow_value(nil).for(:website)
    end
  end

  context 'object' do
    it "has a valid record" do
      expect(member).to be_valid
    end

    it "accepts name" do
      expect(build(:member, name: Faker::Name.name)).to be_valid
    end

    it "accepts original_website" do
      expect(build(:member, original_website: Faker::Internet.url)).to be_valid
    end

    [:name, :original_website].each do |attr|
      it "is invalid without #{attr}" do
        member_2 = build(:member, attr => nil)

        expect(member_2).not_to be_valid
        expect(member_2.errors).to include(attr)
      end
    end

    it "returns as_json object" do
      expect(member.as_json).to include({
        name: member.name,
        original_website: member.original_website
      })
    end

    context 'with name' do
      let(:member_3) { create(:member) }

      it "should be unique" do
        member.name = member_3.name

        expect(member).not_to be_valid
        expect(member.errors).to include(:name)
      end
    end

  end
end
