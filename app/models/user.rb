class User < ApplicationRecord

  belongs_to :role
  belongs_to :country, required: false
  has_many :sessions

  attr_accessor :password, :password_confirmation

  has_attached_file :avatar,
                    styles: { medium: '1000x1000>', thumb: '120x250>' },
                    default_url: '/images/missing.png',
                    path: ":rails_root/public/system/users/:id/avatars/:style/:filename",
                    url: "/system/users/:id/avatars/:style/:filename"

  validates :country, presence: true
  validates :email, presence: true
  validates :first_name,
            presence: true,
            format: { with: /\A[a-zA-Z]+\z/,
                      message: "First name must be letters only"
            }, if: -> { !admin? }
  validates :last_name,
            presence: true,
            format: {with: /\A[a-zA-Z]+\z/,
                     message: "Last name must be letters only"
            }, if: -> { !admin? }
  validates :password,
            presence: true, confirmation: true, length: {within: 6..40}, if: :validate_password?
  validates :password_confirmation,
            presence: true, if: :validate_password?
  validates :email, presence: true,
            uniqueness: { case_sensitive: false, message: 'This email address is already registered.'},
            format: { with: /.*\@.*\..*/, message: 'is incorrect'}
  validates :login, presence: true, uniqueness: { case_sensitive: false, message: 'This login is already registered.' }
  # validates :phone_number,
  #           presence: true,
  #           uniqueness: { message: "Phone number already registered.", scope: :country_id },
  #           numericality: { message: "Phone number must be numeric" }, if: -> { !admin? }

  before_save       :encrypt_password
  before_validation :downcase_email


  Role::NAMES.each do |name_constant|
    define_method("#{name_constant}?") { self.role.try(:name) == name_constant.to_s }
  end

  def authenticate(password)
    self.encrypted_password == encrypt(password)
  end

  private

    def validate_password?
      admin? && (new_record? || !password.nil? || !password_confirmation.nil?)
    end

    def downcase_email
      self.email = self.email.downcase if self.email
    end

    def encrypt_password
      self.salt = make_salt if salt.blank?
      self.encrypted_password = encrypt(self.password) if self.password
    end

    def encrypt(string)
      secure_hash("#{string}--#{self.salt}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{self.password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
