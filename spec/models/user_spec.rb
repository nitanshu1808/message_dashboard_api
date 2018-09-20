require 'rails_helper'

RSpec.describe User, type: :model do

  context "validate User" do
    before(:each) do

      @user = initialize_user
    end

    it "valdating first_name presence" do
      @user.first_name = nil
      expect(@user.valid?).to eql(false)
    end

    it "valdating last_name presence" do
      @user.last_name = nil
      expect(@user.valid?).to eql(false)
    end

    it "valdating email presence" do
      @user.email = nil
      expect(@user.valid?).to eql(false)
    end

    it "valdating amount presence" do
      @user.amount = nil
      expect(@user.valid?).to eql(false)
    end

    it "validate email pattern" do
      VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
      expect(@user.email).to match(VALID_EMAIL_REGEX)
    end

    it "save user" do
      expect(@user.save).to eql(true)
    end

    it "verifies email uniqueness" do
      @user.save
      _duplicate_user = User.new({
                          email:        @user.email,
                          first_name:   FFaker::Name.first_name,
                          last_name:    FFaker::Name.last_name,
                          amount:       FFaker::AddressFI.building_number.to_f
                        })
      expect(_duplicate_user.valid?).to eql(false)
      expect(_duplicate_user.errors.full_messages.first).to eql(I18n.t("user.already_exist"))
    end

  end

end
