class Statement < ActiveRecord::Base
  belongs_to :writer
  attr_accessible # sets all attributes to protected

  before_validation :generate_asset_token, on: :create
  validates :writer_id, presence: true              
  validates_attachment_presence :asset
  validates_attachment_content_type :asset, content_type: /pdf/
  
  has_attached_file :asset, 
                    storage: :s3, bucket: 'lc_statements',
                    s3_credentials: { access_key_id: Secrets["s3_key"], secret_access_key: Secrets["s3_secret"] }, s3_protocol: 'https', 
                    s3_permissions: :private,
                    path: "/:class/:attachment/:hash/:id_partition/:id_:asset_token.:extension",
                    hash_secret: Secrets["hash_secret"]

  Paperclip.interpolates :writer_name do |asset|
    asset.instance.writer.name unless writer.blank?
  end
  
  Paperclip.interpolates :asset_token do |asset|
    asset.instance.asset_token
  end
  
  scope :for_writer, lambda { |writer| where(writer_id: writer.id) }
  scope :recent_first, order("created_at desc")
  
  def asset_url
    "#{self.class.tableize}/#{id}/#{asset_file_name}"
  end
 
  def authenticated_s3_get_url(options={})
    options.reverse_merge! expires_in: 5.minutes, use_ssl: true
    AWS::S3::S3Object.url_for asset.path, asset.options[:bucket], options
  end
  
  private
    def generate_asset_token
      begin
        self.asset_token = SecureRandom.urlsafe_base64
      end while Statement.exists?(asset_token: asset_token)
    end
end
