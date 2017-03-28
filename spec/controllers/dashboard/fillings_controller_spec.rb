require 'rails_helper'
require 'support/helpers/trainer_helper.rb'
include TrainerHelper

RSpec.describe Dashboard::FillingsController, type: :controller do
  before do
    @user  = create(:user)
    @block = create(:block, user: @user)
    @filling = create(:filling, block: @block, user: @user)
    @controller.send(:auto_login, @user)
  end

  subject(:job) { RemoteFillingJob }
  let(:filling) { attributes_for(:filling) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "when job works and returns parameters" do
      post :create, params: { filling: filling }
      j = job.new

      allow_any_instance_of(job).to receive(:perform).and_return(:return_fillings)
      expect(j.perform(@filling.id, @block.id)).to eq :return_fillings
    end

    it "when the job is started" do
      post :create, params: { filling: filling }
      j = job.new
      expect(j.perform(@filling.id, @user.id)).to eq 10
    end
  end
end
