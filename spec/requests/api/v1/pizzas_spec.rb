require 'rails_helper'

RSpec.describe "Api::V1::Pizzas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/pizzas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/pizzas/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/pizzas/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/pizzas/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/pizzas/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
