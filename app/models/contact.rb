class Contact < ApplicationRecord

  # belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  validates :name, presence: true
  validates :email, presence: true, format: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates :message, presence: true

end