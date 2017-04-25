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
      post :create, params: { bowling: { first_try_chance1: 5, first_try_chance2: 5, second_try_chance1: 5, second_try_chance2: 5 } }
    end

    it "should assign bowling" do
      expect(assigns(:bowling)).should_not be_nil
    end

    it "should check the bowling params" do
      expect(assigns(:bowling).first_try_chance1.to_i).to be_eql(5)
      expect(assigns(:bowling).first_try_chance2.to_i).to be_eql(5)
      expect(assigns(:bowling).second_try_chance1.to_i).to be_eql(5)
      expect(assigns(:bowling).second_try_chance2.to_i).to be_eql(5)
    end

    it "should check the number of turns" do
      expect(assigns(:bowling).turns).to be_eql([[5, 5], [5, 5]])
    end

    it "should render index template" do
      expect(response).to render_template :index
    end
  end
end