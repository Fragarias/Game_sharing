class GameBookmark < ApplicationRecord
  belongs_to :end_user
  belongs_to :community
end
