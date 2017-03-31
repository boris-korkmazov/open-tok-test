class OpenTokSession < ApplicationRecord
  validates :name, :session_id, presence: true
end
