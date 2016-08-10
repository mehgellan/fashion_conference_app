class Speaker < ActiveRecord::Base
  validates :email, presence: true
end
