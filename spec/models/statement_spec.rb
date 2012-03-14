require 'spec_helper'

describe Statement do
  it { should belong_to :writer }
  it { should respond_to :asset }
  
  describe "Statement#for_writer" do
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
  
  describe "Statement#recent_first" do
    it "orders the statements descending by date" do
      (1..5).each { |i| create :statement, created_at: Time.now + 60*i }
      statements = Statement.recent_first
      statements[0].created_at.should be > statements[1].created_at
      statements[4].created_at.should be < statements[3].created_at
    end
  end
end
