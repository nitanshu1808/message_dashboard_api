require 'rails_helper'

RSpec.describe User, type: :model do

  context "validate User" do

    let!(:user)        { build(:user) }
    let!(:valid_regex) {/\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/}

    it "valdating first_name presence" do
      user.first_name = nil
      expect(user.valid?).to eql(false)
    end

    it "valdating last_name presence" do
      user.last_name = nil
      expect(user.valid?).to eql(false)
    end

    it "valdating email presence" do
      user.email = nil
      expect(user.valid?).to eql(false)
    end

    it "valdating amount presence" do
      user.amount = nil
      expect(user.valid?).to eql(false)
    end

    it "validate email pattern" do
      expect(user.email).to match(valid_regex)
    end

    it "save user" do
      expect(user.save).to eql(true)
    end

  end

  context "verifies user with duplicate email" do
    let!(:user)           { create(:user) }
    let!(:duplicate_user) { build(:user) }

    it "verifies email uniqueness" do
      duplicate_user.email = user.email
      expect(duplicate_user.valid?).to eql(false)
      expect(duplicate_user.errors.full_messages.first).to eql(I18n.t("user.already_exist"))
    end

  end


end
