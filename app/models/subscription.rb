class Subscription < ApplicationRecord
  EMAIL_FORMAT = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/

  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  # user_name/email validates if user unregistered
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: EMAIL_FORMAT }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  validate :event_author_subscription, if: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def event_author_subscription
    errors.add(:base, I18n.t("errors.methods.event_author_subscription")) if user == event.user
  end
end
