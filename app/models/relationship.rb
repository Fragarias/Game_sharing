class Relationship < ApplicationRecord
  belongs_to :end_user
  has_many :notifications, dependent: :destroy
end
