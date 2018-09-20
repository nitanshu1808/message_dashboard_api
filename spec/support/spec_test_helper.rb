module SpecTestHelper
  def initialize_user
    # Initiazing users using faker gem
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

  
end