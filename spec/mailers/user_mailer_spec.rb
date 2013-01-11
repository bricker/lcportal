require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { create :user, password_reset_token: "some-token" }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      mail.subject.should match "Password Reset"
      mail.to.should eq [user.email]
      mail.from.should eq [AppConfig["company"]["email"]]
    end

    it "renders the body" do
      mail.body.encoded.should match edit_password_reset_path(user.password_reset_token)
    end
  end
  
  describe "welcome" do
    let(:user) { create :user, password: "generated" }
    let(:mail) { UserMailer.welcome(user, "generated") }
    
    it "sends a welcome email" do
      mail.subject.should match "Welcome"
      mail.to.should eq [user.email]
      mail.from.should eq [AppConfig["company"]["email"]]
    end
    
    it "renders the body" do
      mail.body.encoded.should match user.email
    end
    
    it "shows the generated password" do
      mail.body.encoded.should match "generated"
    end
  end
end
