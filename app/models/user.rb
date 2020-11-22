class User < ApplicationRecord
  EMAIL_FORMAT = /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/

  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    uniqueness: true,
                    format: EMAIL_FORMAT
end
