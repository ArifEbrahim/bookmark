require './spec/database_helpers.rb'
require 'user'

RSpec.describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create('test@example.com', 'password123')
      persisted_data = persisted_data('users', user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.email).to eq('test@example.com')
    end

    it 'hashes the password using bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create('test@example.com', 'password123')
    end
  end

  describe '.find' do
    it 'finds a specifc user' do
      user = User.create('test@example.com', 'password123')
      search_result = User.find(user.id)

      expect(search_result.id).to eq(user.id)
      expect(search_result.email).to eq(user.email)
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end

end