module User
  class SignUp
    include ActiveModel::Validations

    validates :name,
      presence: true,
      length: { minimum: 1, maximum: 255 }
    validates :password,
      presence: true,
      length: { minimum: 8, maximum: 32 }
    validates :password_confirmation,
      presence: true,
      length: { minimum: 8, maximum: 32 }
    # password == password_confirmation
    # name must be unique
  end
end
