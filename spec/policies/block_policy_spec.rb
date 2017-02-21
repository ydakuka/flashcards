require 'rails_helper'

RSpec.describe BlockPolicy do
  let(:user)  { create(:user) }
  let(:admin) { create(:user_with_admin_privileges) }
  let(:block) { Block.create }

  permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
    context 'for a normal user' do
      subject { described_class.new(user, block) }
      it "should raise an exception if not an admin" do
        expect do
          expect(subject).new(user, block)
        end.to raise_error(Pundit::NotAuthorizedError)
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
