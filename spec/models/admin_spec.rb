require "spec_helper"

describe Admin do
  it { should_not have_one :profile }
  it { should respond_to :name }
  it { should be_a User }
  
  it 'can run queries based on the user columns' do
    (1..5).each { |i| create :admin, name: "#{i} John Williams" }
    admins = Admin.order('name desc')
    admins.first.name.should eq "5 John Williams"
  end
  
  it "fetches the user attributes as well" do
    name = "Jeff Rona"
    admin = create :admin, name: name
    admin.name.should eq name
  end
  
  it "updates user's attributes through the admin class" do
    admin = create :admin
    email = "new-email@me.com"
    admin.update_attribute :email, email
    admin.reload.email.should eq email
  end
end