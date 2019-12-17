require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      @user = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      expect(@user).to be_valid
    end

    it 'is not valid without a password' do
      @user = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:nil)
      expect(@user).to_not be_valid
    end

    it 'is not valid without a password_confirmation' do
      @user = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      expect(@user).to be_valid
    end

    it 'is not valid if password != password_confirmation' do
      @user = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"4321")
      expect(@user).to_not be_valid
    end

    it 'is not valid if email is not unique' do
      @user1 = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      @user2 = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      expect(@user2).to_not be_valid
    end

    it 'is not valid without an email' do
      @user = User.create(firstname:"john", lastname:"doe", email:nil, password:"1234", password_confirmation:"1234")
      expect(@user).to_not be_valid
    end

    it 'is not valid without a first name' do
      @user = User.create(firstname:nil, lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      expect(@user).to_not be_valid
    end

    it 'is not valid without a last name' do
      @user = User.create(firstname:nil, lastname:nil, email:"john@email.com", password:"1234", password_confirmation:"1234")
      expect(@user).to_not be_valid
    end

    it 'is not valid if password is less than minimum length' do
      @user = User.create(firstname:nil, lastname:"doe", email:"john@email.com", password:"12", password_confirmation:"12")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user if the use is authentic' do
      @user1 = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      @user2 = User.authenticate_with_credentials(@user1.email, @user1.password)
      expect(@user2.firstname).to eq("john")
    end

    it 'should return nil if a user is not authenticated' do
      @user = User.authenticate_with_credentials("john@email.com", "4321")
      expect(@user).to eq(nil)
    end

    it 'is valid if email contains spaces before or after' do
      @user1 = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      @user2 = User.authenticate_with_credentials(" john@email.com ", @user1.password)
      expect(@user2.firstname).to eq("john")
    end
    
    it 'is valid if email is without case sensitivity' do
      @user1 = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
      @user2 = User.authenticate_with_credentials("JoHn@EMAIL.cOm", @user1.password)
      expect(@user2.firstname).to eq("john")
    end
  end
end