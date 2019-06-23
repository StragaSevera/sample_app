# frozen_string_literal: true

# create_table :users, force: :cascade do |t|
#   t.string :name
#   t.string :email
#   t.datetime :created_at, null: false
#   t.datetime :updated_at, null: false
#   t.string :password_digest
#   t.index [:email], name: :index_users_on_email, unique: true
# end

class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
