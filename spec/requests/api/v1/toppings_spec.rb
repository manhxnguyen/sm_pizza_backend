require 'rails_helper'

RSpec.describe "Api::V1::Toppings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/toppings/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/toppings/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/toppings/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/toppings/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/toppings/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
