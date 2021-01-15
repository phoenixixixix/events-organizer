class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  #
  # Event has many subscribers(User objects), through
  # subscriptions table, by user_id key
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photo

  validates :user, presence: true
  validates :title, presence: true,
                    length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true
end
