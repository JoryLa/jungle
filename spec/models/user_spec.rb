require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    
    it 'should not save without a valid first name' do
      user = User.new(
        first_name: nil,
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(user.errors.full_messages).to include("First name can't be blank")
    end
    
    it 'should not save without a valid last name' do
      user = User.new(
        first_name: 'bob',
        last_name: nil,
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not save without a valid email' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: nil,
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it 'should not save without a unique email' do
      user1 = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user1.save
      
      user2 = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'Bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user2.save

        expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not save a with empty password' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: nil,
        password_confirmation: 'bob')
        user.save
        expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save a with empty password confirmation' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: nil)
        user.save
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save a password with less than three characters' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bo',
        password_confirmation: 'bo')
        user.save
        expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

    it 'should not save without a valid matching password and password confirmation' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bobby',
        password_confirmation: 'bob')
        user.save
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a login for a user' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        # result = User.authenticate_with_credentials(user.email, user.password)
        expect(User.authenticate_with_credentials('bob@bob.com', 'bob')).to eq(user)
    end

    it 'should return nil for a login with incorrect password' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        # result = User.authenticate_with_credentials(user.email, user.password)
        expect(User.authenticate_with_credentials('bob@bob.com', 'bo')).to eq(nil)
    end

    it 'should return nil for a login with incorrect email' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(User.authenticate_with_credentials('b@bob.com', 'bob')).to eq(nil)
    end
    
    it 'should authenticate a login for a user despite uppercase' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(User.authenticate_with_credentials('BoB@bob.com', 'bob')).to eq(user)
    end

    it 'should authenticate a login for a user despite white sapce' do
      user = User.new(
        first_name: 'bob',
        last_name: 'bob',
        email: 'bob@bob.com',
        password: 'bob',
        password_confirmation: 'bob')
        user.save
        expect(User.authenticate_with_credentials('   bob@bob.com   ', 'bob')).to eq(user)
    end
  end
end
