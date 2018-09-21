module SpecTestHelper
  # Initiazing users using faker gem
  def initialize_user
    User.new(user_attributes)
  end

  def user_attributes
    {
      email:        FFaker::Internet.free_email,
      first_name:   FFaker::Name.first_name,
      last_name:    FFaker::Name.last_name,
      amount:       FFaker::AddressFI.building_number.to_f
    }
  end

  def json
    JSON.parse(response.body)
  end
  
end
