require "rails_helper"

RSpec.describe BowlingController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should assign bowling" do
      get :index
      assigns(:bowling).should_not be_nil
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    before do
      post :create, params: {"frame1"=>["10", "0"], "frame2"=>["10", "0"], "frame3"=>["10", "0"], "frame4"=>["10", "0"], "frame5"=>["10", "0"], "frame6"=>["10", "0"], "frame7"=>["10", "0"], "frame8"=>["10", "0"], "frame9"=>["10", "0"], "frame10"=>["10", "0"], "game_bonus"=>["10", "10"]}
    end

    it "should assign bowling" do
      expect(assigns(:bowling)).should_not be_nil
    end

    it "should check the number of turns" do
      expect(assigns(:total_score)).to be_eql(300)
    end

    it "should render index template" do
      expect(response).to render_template :index
    end
  end
end