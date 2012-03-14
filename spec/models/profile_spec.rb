require "spec_helper"

describe Profile do
  it { should belong_to :writer }
  it { should_not belong_to :user }
  it { should_not belong_to :admin }
end