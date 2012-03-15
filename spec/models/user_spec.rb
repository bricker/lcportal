require 'spec_helper'

describe User do  
  describe "without a type" do
    it { should_not be_a Admin }
    it { should_not be_a Writer }
    it { should_not respond_to :profile }
  end
  
  describe "mass assignment" do
    it { should_not allow_mass_assignment_of :type }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
    it { should_not allow_mass_assignment_of :password_digest }
    it { should_not allow_mass_assignment_of :password_reset_requested_at }
    it { should_not allow_mass_assignment_of :password_reset_token }
  end
  
  describe "validations" do
    before(:each) { @user = create :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
    
    it "should not care about case in the e-mail uniqueness validation" do
      other_user = build :user, email: @user.email.upcase
      other_user.should_not be_valid
      other_user.errors[:email].should include "has already been taken"
    end
  end
  
  describe "callbacks" do
    it "downcases the e-mail before validating and saving a user" do
      user = create :user, email: "SomeEmail@email.com"
      user.email.should eq "someemail@email.com"
    end
    
    it "generates an auth_token on user creation" do
      user = build :user
      user.auth_token.should be_blank
      user.save
      user.auth_token.should be_present
    end
  end
    
  describe "generate_password" do
    it "generates a password on user creation" do
      password = "secret"
      user = create :user, password: password, overwrite_password: false
      BCrypt::Password.new(user.password_digest).should_not eq password
    end
    
    it "generates a different password every time" do
      users = create_list :user, 2
      users.first.password_digest.should_not eq users.last.password_digest
    end
    
    it "does not generate a password when the user is updated" do
      password = "qxqxqx" # generator will never generate this password
      user = create :user, password: password
      user.update_attribute :name, "Bryan Ricker"
      BCrypt::Password.new(user.reload.password_digest).should eq password
    end
  end
  
  describe "create a user" do
    it "sends the welcome e-mail after the user is created" do
      user = create :user
      last_email.to.should eq [user.email]
    end
  end
  
  describe "send_password_reset" do
    before(:each) do
      @user = create :user
      @user.send_password_reset
      @user.reload
    end
    
    it "should set the reset request time" do
      @user.password_reset_requested_at.should be_present
    end
    
    it "sets the reset token" do
      @user.password_reset_token.should be_present
    end
    
    it "sends an e-mail to the user" do
      last_email.to.should include @user.email
    end
    
    it "generates a unique password_reset_token each time" do
      last_token = @user.password_reset_token
      @user.send_password_reset
      @user.reload.password_reset_token.should_not eq last_token
    end
  end
    
  describe "#is_writer?" do
    it "checks if user is an writer" do
      user = create :writer
      user.is_writer?.should be_true
    end
    
    it "knows that a admin is not an writer" do
      user = create :admin
      user.is_writer?.should be_false
    end
  end
    
  describe "#is_admin?" do
    it "checks if user is an admin" do
      user = create :admin
      user.is_admin?.should be_true
    end
    
    it "knows that a writer is not an admin" do
      user = create :writer
      user.is_admin?.should be_false
    end
  end
  
  describe "authentication" do 
    it "authenticates a user with a correct password" do
      user = create :user, password: "secret"
      User.authenticate(user.email, "secret").should eq user
    end
  
    it "does not authenticate a user with an unrecognized email" do
      user = create :user, password: "secret", email: "info@liquidcinema.com"
      User.authenticate("incorrect@liquidcinema.com", "secret").should be_nil
    end
  
    it "does not authenticate a user with an incorrect password" do
      user = create :user, password: "secret"
      User.authenticate(user.email, "incorrect").should be_false
    end
  end
end
