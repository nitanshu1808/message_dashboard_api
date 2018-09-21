require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let!(:users)  { create_list(:user, 15) }
  let(:user_id) { users.first.id }

  describe "GET #index" do

    context "returns user" do
      # make HTTP get request before every test case
      before { get 'index' }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "verifies user load message" do
        expect(json['message']).to eq(I18n.t("user.load"))
      end

      it "verifies record presence" do
        expect(json).not_to be_empty
        expect(json['data'].size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when record doesn't exist" do
      before { get 'index', params: {page: 3} }

      it 'returns blank array' do
        expect(json['data']).to eq([])
      end
    end
  end

  describe "GET /users/:id" do

    before { get :show, params: {id: user_id} }

    context 'when the record exists' do

      it 'found user' do
        expect(json['message']).to eq(I18n.t("user.find"))
      end

      it 'verifies record presence' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the record does not exist' do
      let(:user_id) { 300 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(I18n.t("user.not_found"))
      end
    end

  end

  describe "Post #create user" do

    context 'when request attributes are valid' do
      let(:valid_params) do {  user: build(:user).attributes } end
      before { post :create, params: valid_params }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it "verifies record created" do
        expect(json['message']).to eq(I18n.t("user.created"))
      end
    end


    context 'when an invalid request' do
      before { post :create, params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it "error while creating record" do
        expect(json['message']).to eq(I18n.t("user.error"))
      end
    end

  end

  describe "Delete User#destroy" do

    context 'deletes a user' do
      before { delete :destroy, params: {id: user_id} }
      let(:user_id) { users.last.id }

      it "deletes a record" do
        expect(json['message']).to eq(I18n.t("user.delete"))
        expect(User.find_by(id: user_id)).to eq(nil)
      end

    end
  end

end
