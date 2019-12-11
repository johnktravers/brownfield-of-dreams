require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe '#activate' do
    let(:user) { create(:user) }
    let(:mail) { described_class.activate(user).deliver_now }

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

  describe '#invite' do
    let(:invitee_email) { "invitee@example.com" }
    let(:invitee_name) { "Alan Turing" }
    let(:user) { create(:github_user) }
    let(:mail) { described_class.invite(invitee_email, invitee_name, user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Join your friends on Brownfield!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([invitee_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfield-of-dreams-1908.herokuapp.com'])
    end

    it 'assigns @user.first_name @user.last_name' do
      expect(mail.body.encoded).to include(user.first_name + ' ' + user.last_name)
    end

    it 'assigns link to register' do
      expect(mail.body.encoded)
        .to include("https://brownfield-of-dreams-1908.herokuapp.com/register")
    end
  end
end
