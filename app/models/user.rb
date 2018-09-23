class User < ApplicationRecord
  # constants
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/
  # scope for users
  scope :sort_by_field, ->(field)  {order(Arel.sql(field)) }
  # validations
  validates :email, :first_name, :last_name, :amount, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: VALID_EMAIL_REGEX,
    message: I18n.t("user.invalid_email") }

  # Class method returns filtered records
  def self.filter_records(data)
    if data.include? '.com'
      where("email ILIKE ?", "%#{data}")
    else
      condition = []
      params    = []
      range     = (data.split("-")[0].strip..data.split("-")[1].strip).to_a
      (data.split("-")[0].strip..data.split("-")[1].strip).to_a.each do |char|
        condition << "last_name ILIKE ?"
        params    << "%#{char}"
      end
      where(condition.join(' OR '), *params)
    end
  end
end
