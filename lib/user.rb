require 'bcrypt'

class User
  attr_reader :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end

  def self.create(email, password)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES('#{email}', '#{encrypted_password}') RETURNING id, email;") 
    User.new(result[0]['id'], result[0]['email'])
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(result[0]['id'], result[0]['email'])
  end

  

end

# got to step 5