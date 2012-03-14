require 'spec_helper'

describe Writer do
  it { should have_many :statements }
  it { should have_one :profile }
  it { should respond_to :name }
  it { should be_a User }
  
  it 'can run queries based on the user columns' do
    (1..5).each { |i| create :writer, name: "#{i} John Williams" }
    writers = Writer.order('name desc')
    writers.first.name.should eq "5 John Williams"
  end
  
  it "fetches the user attributes as well" do
    writer = create :writer, name: "Jeff Rona"
    writer.name.should eq "Jeff Rona"
  end
  
  it "updates user's attributes through the writer class" do
    writer = create :writer
    email = "new-email@me.com"
    writer.update_attribute :email, email
    writer.reload.email.should eq email
  end
  
  it "creates a profile on create" do
    writer = build :writer
    writer.profile.should be_nil
    writer.save
    writer.profile.should be_present
  end
  
  it "is able to update its profile" do
    writer = create :writer
    writer.profile.phone_number = "123-456-7890"
    writer.save
    writer.reload.profile.phone_number.should eq "123-456-7890"
  end
end
