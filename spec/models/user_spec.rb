require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "validates :email and :name, presence: true" do
      # has_secure_password only validates the following   
        # validates_confirmation_of :password
        # validates_presence_of     :password_digest
      user = User.create({
        name:  nil,
        email: nil,
        password: "testpassword",
        password_confirmation: "testpassword"
      })
      expect(user.errors.full_messages).to include("Name can't be blank")
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it "validates :password, presence: true" do
      user = User.create({
        name:  "Example User Name",
        email: "Example User Email",
        password: nil,
        password_confirmation: nil
      })
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    
    it "validates :password and :password_confirmation must match" do
      user = User.create({
        name:  "Example User Name",
        email: "Example User Email",
        password: "Example Password",
        password_confirmation: "Different Example Password"
      })
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "validates :email is unique" do
      user1 = User.create({
        name:  "Example User Name",
        email: "test@test.COM",
        password: "Example Password",
        password_confirmation: "Example Password"
      })
      user2 = User.create({
        name:  "Another Example User Name",
        email: "TEST@TEST.com",
        password: "Another Example Password",
        password_confirmation: "Another Example Password"
      })
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "validates :password, minimum: 5" do
      user = User.create({
        name:  "Example User Name",
        email: "Example User Email",
        password: "tst",
        password_confirmation: "tst"
      })
      expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end
  
  describe '.authenticate_with_credentials' do
    before(:all) do
      User.create({
        name:  "Jane Doe",
        email: "example@domain.com",
        password: "1234567",
        password_confirmation: "1234567"
      })
    end

    it "authenticates given valid credentials" do
      expect(User.authenticate_with_credentials("example@domain.com", "1234567")).to be
    end
    
    it "does not authenticates given invalid email credential" do
      expect(User.authenticate_with_credentials("example1@domain.com", "1234567")).not_to be
    end

    it "does not authenticates given invalid password credential" do
      expect(User.authenticate_with_credentials("example@domain.com", "123456")).not_to be
    end
    
    it "authenticates given space-padded valid credential" do
      expect(User.authenticate_with_credentials("  example@domain.com  ", "1234567")).to be
    end

    it "authenticates given wrong-case but valid email credential" do
      expect(User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "1234567")).to be
    end
    
  end
end
