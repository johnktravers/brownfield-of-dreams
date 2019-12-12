require 'rails_helper'

RSpec.describe Invitee, type: :model do
  it 'initialize' do
    raw_data = {
      email: 'jane@example.com',
      name: 'Jane Doe'
    }
    invitee = Invitee.new(raw_data)

    expect(invitee).to be_a(Invitee)
    expect(invitee.email).to eq('jane@example.com')
    expect(invitee.name).to eq('Jane Doe')
  end
end
