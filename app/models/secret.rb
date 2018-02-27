class Secret < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :likes
  has_many :likes, dependent: :destroy
  # we add dependent so if we delete secret it deletes likes

end
