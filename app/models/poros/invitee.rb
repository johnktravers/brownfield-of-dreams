class Invitee
  attr_reader :email, :name

  def initialize(raw_data)
    @email = raw_data[:email]
    @name = raw_data[:name]
  end
end
