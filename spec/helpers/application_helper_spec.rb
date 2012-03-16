require 'spec_helper'

describe ApplicationHelper do  
  describe "#pretty_date" do
    before :each do
      @date = Time.now
    end
    
    it "returns the default if a format isn't specified" do
      pretty_date(@date).should eq @date.strftime("%b %e, %Y")
    end
    
    it "returns a `numbers` format" do
      pretty_date(@date, format: :numbers).should eq @date.strftime("%m-%e-%y")
    end
    
    it "returns a `full` format" do
      pretty_date(@date, format: :full).should eq @date.strftime("%B #{@date.day.ordinalize}, %Y")
    end
    
    it "accepts a custom format" do
      pretty_date(@date, format: :custom, with: "%D").should eq @date.strftime("%D")
    end
  end
  
  describe "nav_link_to" do
    it "returns an li tag with a link" do
      nav_link_to("title", login_path).should match /<li.+?<a .+?<\/a><\/li>/
    end
    
    it "uses the active class if the current controller is in the route" do
      controller.stub(:controller_name) { "writers" } 
      nav_link_to("title", writers_path).should match "active"
    end
    
    it "does not use the active class if the current controller is not in the route" do
      controller.stub(:controller_name) { "writers" } 
      nav_link_to("title", statements_path).should_not match "active"
    end
    
    it "uses options passed in on the link" do
      nav_link_to("title", statements_path, id: "statements").should match /id ?= ?[\"|']statements[\"|']/
    end
  end
  
  describe "#any_to_list?" do
    it "returns the block if there are records" do
      any_to_list?(1..5) { "Records list" }.should eq "Records list"
    end
    
    it "returns a default message if there are no records and no message or title is specified" do
      any_to_list?([]) { "Records list" }.should match "There is nothing to list yet."
    end
    
    it "returns a more specific default message if there are no records and no message is specified, but a title is" do
      any_to_list?([], title: "Records") { "Records list" }.should match "Records"
    end
    
    it "returns a specified message if there are no records" do
      any_to_list?([], message: "None!") { "Records list" }.should eq "None!"
    end
    
    it "returns true if there are records and no block is given" do
      any_to_list?(1..5).should be_true
    end
    
    it "returns false if there are no records and no block is given" do
      any_to_list?([]).should be_false
    end
  end
  
  describe "check_for" do
    describe "with a symbol or string" do
      it "displays the content if it has been defined" do
        title = "A Title"
        helper.content_for :title, title
        helper.check_for(:title).should eq title
      end
    
      it "displays default content if the content has not been defined" do
        helper.check_for(:title).should eq "Title"
      end
    
      it "uses its second parameter as the default if no content has been defined" do
        default = "A Default Title"
        helper.check_for(:title, default: default).should eq default
      end
      
      it "can accept a string" do
        pending
      end
    end
    
    describe "with a variable" do
      it "returns the supplied default string if the variable is empty" do
        default = "There is nothing to display."
        check_for([], default: default).should match default
      end
      
      it "returns the default string if there are no records and no default string was provided" do
        check_for([]).should match "There is nothing here to list."
      end
      
      it "returns true if there are records" do
        users = build_list :user, 2
        check_for(users).should eq nil
      end
    end
  end
end
