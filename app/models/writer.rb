class Writer < User
  has_one :profile
  has_many :statements
  
  accepts_nested_attributes_for :profile
  attr_accessible :profile_attributes
  
  before_create { |writer| writer.build_profile }
end
