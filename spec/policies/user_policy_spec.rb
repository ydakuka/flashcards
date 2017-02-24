require 'rails_helper'

RSpec.describe UserPolicy do
  let(:user)  { create(:user) }
  let(:admin) { create(:user_with_admin_privileges) }
  let(:new_user) { User.create }

  permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
    context 'for a normal user' do
      it "should raise an exception if not an admin" do
        expect do
          expect(subject).to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end

    context 'for an admin' do
      subject { described_class }
      it "allows access for an admin" do
        expect(subject).to permit(admin)
      end
    end
  end
end
