class GameBookmark < ApplicationRecord
  belongs_to :end_user
  belongs_to :community

  validates :end_user_id, uniqueness: {scope: :community_id}
end
