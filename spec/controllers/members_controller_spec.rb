require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  let(:valid_attributes) {
    {
      member: {
        name: Faker::Name.name,
        original_website: Faker::Internet.url
      }
    }
  }

  let(:invalid_attributes) {
    {
      member: {
        name: '',
        original_website: ''
      }
    }
  }

  let(:valid_session) {
    {}
  }

  describe "GET #index" do
    let(:member) {
      Member.create! valid_attributes[:member]
    }

    context "HTML with valid parameters" do
      before do
        get :index, params: {}, session: valid_session
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "responds to html" do
        expect(response.content_type).to eq "text/html"
      end

      it "renders Index" do
        expect(response).to render_template(:index)
      end

      it "returns Array" do
        expect(assigns(:members)).to be_a(ActiveRecord::Relation)
        expect(assigns(:members)).to eq([member])
      end
    end

    context "HTML with keyword" do
      let(:member_2) {
        Member.create! valid_attributes[:member].merge({html_content: "test keyword"})
      }

      before do
        get :index, params: {keyword: "test keyword"}, session: valid_session
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "renders Index" do
        expect(response).to render_template(:index)
      end

      it "returns Array" do
        expect(assigns(:members)).to be_a(ActiveRecord::Relation)
        expect(assigns(:members)).to eq([member_2])
      end
    end

    context "JSON with valid parameters" do
      before do
        get :index, params: {}, session: valid_session, format: :json
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "responds to html" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns Array" do
        expect(assigns(:members)).to be_a(ActiveRecord::Relation)
        expect(assigns(:members)).to eq([member])
      end
    end
  end

  describe "GET #show" do
    let(:member) {
      Member.create! valid_attributes[:member]
    }

    context "HTML with valid parameters" do
      before do
        get :show, params: {id: member.to_param}, session: valid_session
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "responds to html" do
        expect(response.content_type).to eq "text/html"
      end

      it "renders Index" do
        expect(response).to render_template(:show)
      end

      it "returns Array" do
        expect(assigns(:member)).to be_a(Member)
        expect(assigns(:member)).to eq(member)
      end
    end

    context "JSON with valid parameters" do
      before do
       get :show, params: {id: member.to_param}, session: valid_session, format: :json
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "responds to html" do
        expect(response.content_type).to eq "application/json"
      end

      it "returns member" do
        expect(assigns(:member)).to be_a(Member)
        expect(assigns(:member)).to eq(member)
      end
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "HTML with valid parameters" do
      before do
        ActiveJob::Base.queue_adapter = :test
      end

      it "creates a new Member" do
        expect {
          post :create, params: valid_attributes, session: valid_session
        }.to change(Member, :count).by(1)
      end

      it "has enqueued job" do
        expect {
          post :create, params: valid_attributes, session: valid_session
        }.to have_enqueued_job(UrlShortenerJob)
      end

      it "has enqueued job" do
        expect {
          post :create, params: valid_attributes, session: valid_session
        }.to have_enqueued_job(PageCrawlJob)
      end

      context "should" do
        before do
         post :create, params: valid_attributes, session: valid_session
        end

        it "redirect to the created member" do
          expect(response).to redirect_to(Member.last)
        end

        it "respond to html" do
          expect(response.content_type).to eq "text/html"
        end
      end
    end

    context "HTML with invalid parameters" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: invalid_attributes, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "GET #set_current" do
    let(:member) {
      Member.create! valid_attributes[:member]
    }

    context "HTML with valid parameters" do
      before do
        get :set_current, params: {id: member.to_param}, session: valid_session
      end

      it "redirects to the members page" do
        expect(response).to redirect_to(members_path)
      end

      it "sets member id in session" do
        expect(session["current_member_id"]).to eq(member.id)
      end

    end
  end
end