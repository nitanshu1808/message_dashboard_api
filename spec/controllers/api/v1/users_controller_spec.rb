require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #index" do

    before do
      15.times do
        user = initialize_user
        user.save
      end
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "verifies records returned" do

      get :index, format: :json

      parsed_response = JSON.parse(response.body)

      expect(parsed_response['data'].length).to eq(10)

      expect(parsed_response['message']).to eq(I18n.t("user.load"))
    end

    it "returns [] if no record is found" do
      get :index, format: :json
      users = User.page(3)
      expect(users).to eq([])
    end

  end

  describe "Post #create" do

    let(:valid_params) do
      {
         user: user_attributes
      }
    end


    it "verifies record created" do
      post :create, params: valid_params
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq(I18n.t("user.created"))
    end

    it "verifies error while creating record" do
      post :create, params: {}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq(I18n.t("user.error"))
    end
  end

  describe "Post #destroy" do

    before do
      @user = initialize_user
      @user.save
    end

    it "deletes a record" do
      delete :destroy, params: {id: @user.id}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq(I18n.t("user.delete"))
      expect(User.find_by(id: @user.id)).to eq(nil)
    end

  end

  describe "Fetch user" do
    before do
      @user = initialize_user
      @user.save
    end

    it "retrieves a record" do
      get :show, params: {id: @user.id}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq(I18n.t("user.find"))
    end

  end

end
