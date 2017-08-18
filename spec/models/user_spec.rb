require 'rails_helper'

RSpec.describe User, type: :model do
  it 'responds to role' do
    expect(wiki).to respond_to(:role)
  end


end
