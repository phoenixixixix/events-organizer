class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  # checks newly created user for subscriptions(by email)
  # and update if any exist
  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  private

  def set_name
    self.name = "User №#{rand 1000}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
