require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe '#activation' do
    let(:user) { create(:user) }
    let(:mail) { described_class.activation(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Activate Your Account')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfield-of-dreams-1908.herokuapp.com'])
    end

    it 'assigns @user.first_name' do
      expect(mail.body.encoded).to include(user.first_name)
    end

    it 'assigns @user.activation_token' do
      expect(mail.body.encoded)
        .to include("https://brownfield-of-dreams-1908.herokuapp.com/activate?activation_token=#{user.activation_token}")
    end
  end
end
