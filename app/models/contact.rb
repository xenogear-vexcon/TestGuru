class Contact < MailForm::Base

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  # attribute :name, :validate => true
  # attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message, :validate => true

end
