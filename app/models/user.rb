class User < ApplicationRecord
  # constants
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
  # default scope for latest created users
  default_scope {order("created_at desc")}
  # validations
  validates :email, :first_name, :last_name, :amount, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: VALID_EMAIL_REGEX,
    message: I18n.t("user.invalid_email") }
end
