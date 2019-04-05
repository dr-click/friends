require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:member) {
    create(:member)
  }

  let(:valid_session) {
    {
      "current_member_id" => member.id
    }
  }

  describe "POST #create" do
    let(:friend) {
      create(:member)
    }

    context "HTML with valid parameters" do

      it "creates a new friendship" do
        expect {
          post :create, params: { member_id: friend.id }, session: valid_session
        }.to change(Friendship, :count).by(1)
      end

      context "should" do
        before do
          post :create, params: { member_id: friend.id }, session: valid_session
        end

        it "redirect to the friend page" do
          expect(response).to redirect_to(friend)
        end

        it "respond to html" do
          expect(response.content_type).to eq "text/html"
        end
      end
    end

    context "HTML with invalid parameters" do
      context "with no session" do
        before do
          post :create, params: { member_id: friend.id }
        end

        it "return Unauthorized" do
          expect(response).to have_http_status 401
        end

        it "respond to html" do
          expect(response.content_type).to eq "text/html"
        end
      end

      context "already friends" do
        before do
          Friendship.create(member: member, friend: friend)
          post :create, params: { member_id: friend.id }, session: valid_session
        end

        it "redirect to the friend page" do
          expect(response).to redirect_to(friend)
        end

        it "return Unauthorized" do
          expect(response).to have_http_status 302
        end
      end
    end
  end

end