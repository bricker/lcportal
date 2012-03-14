class User < ActiveRecord::Base
  has_secure_password
    
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
  before_validation :generate_password, on: :create
  before_validation :downcase_email
  after_create :send_welcome
  
  attr_accessible :name, :email, :password, :password_confirmation
  
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
  
  def is_admin?
    self.class == Admin
  end
  
  def is_writer?
    self.class == Writer
  end
  
  def send_welcome
    UserMailer.welcome(self, password).deliver
  end
  
  def send_password_reset
    generate_token :password_reset_token
    self.password_reset_requested_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  protected
    def downcase_email # This helps us validate that e-mails are unique, because the case_sensitive validation is slow.
      self.email = email.downcase if email.present?
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
    
    def generate_password
      consonants = %w(b c d f g h j k l m n p qu r s t v w x z ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr)
      vowels = %w(a e i o u y)
      i, password = true, ''
      8.times do
        password << (i ? consonants[rand * consonants.size] : vowels[rand * vowels.size])
        i = !i
      end
      self.password = password
    end
end
