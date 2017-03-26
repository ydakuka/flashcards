require 'rails_helper'
require 'support/helpers/trainer_helper.rb'
include TrainerHelper

RSpec.describe Dashboard::FillingsController, type: :controller do

  describe "GET #index" do
    before do
      @user = create(:user)
      @controller.send(:auto_login, @user)
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
