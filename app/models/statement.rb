class Statement < ActiveRecord::Base
  belongs_to :writer
  has_attached_file :asset
  
  scope :for_writer, lambda { |writer| where(writer_id: writer.id) }
  scope :recent_first, order("created_at desc")
end
