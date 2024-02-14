class Nofitication < ApplicationRecord
  belongs_to :end_user
  belongs_to :comment
  belongs_to :like
  belongs_to :relationship
end
