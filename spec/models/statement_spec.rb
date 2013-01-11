require 'spec_helper'

describe Statement do
  it { should belong_to :writer }
  it { should_not allow_mass_assignment_of :asset_token }
  it { should_not allow_mass_assignment_of :asset_file_name }
  it { should_not allow_mass_assignment_of :asset_file_size }
  it { should_not allow_mass_assignment_of :asset_content_type }
  it { should_not allow_mass_assignment_of :asset_updated_at }
  it { should_not allow_mass_assignment_of :writer_id }
  
  define "validations" do
    it { should validate_presence_of :writer_id }
    it { should have_attached_file :asset }
    it { should validate_attachment_presence :asset }
  
    it "validates attachment content type" do
      statment = create :statement
      statement.should validate_attachment_content_type(:asset).allowing("application/pdf").rejecting("image/png", "image/gif", "text/plain")
    end
  end
  
  describe "scopes" do
    describe "#for_writer" do
      it "only retrieves the statements for the logged in writer" do
        current_writer = create :writer
        other_writer = create :writer
        current_writers_statements = create_list :statement, 3, writer: current_writer
        other_writers_statements = create_list :statement, 2, writer: other_writer
        statements = Statement.for_writer current_writer
        statements.count.should eq 3
        statements.each { |s| s.writer_id.should eq current_writer.id }
      end
    end
  
    describe "#recent_first" do
      it "orders the statements descending by date" do
        (1..5).each { |i| create :statement, created_at: Time.now + 60*i }
        statements = Statement.recent_first
        statements[0].created_at.should be > statements[1].created_at
        statements[4].created_at.should be < statements[3].created_at
      end
    end
  end
  
  describe "generate_asset_token" do
    it "generates a token on statement creation" do
      statement = create :statement
      statement.asset_token.should_be be_blank
    end
    
    it "generates a different token every time" do
      
    end
    
    it "does not generate a password when the user is updated" do
      password = "qxqxqx" # generator will never generate this password
      user = create :user, password: password
      user.update_attribute :name, "Bryan Ricker"
      BCrypt::Password.new(user.reload.password_digest).should eq password
    end
  end
end
