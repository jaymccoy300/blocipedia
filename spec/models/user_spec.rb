require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  it 'responds to role' do
    expect(user).to respond_to(:role)
  end


end
