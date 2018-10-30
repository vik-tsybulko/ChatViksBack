class Session < ApplicationRecord
  belongs_to :user
  before_create :generate_token
  before_create :remove_the_same_devices
  after_create :remove_expired_sessions
  validates :user_id, presence: true

  enum device_type: {
      android: 0,
      ios: 1
  }

  def self.destroy_expired
    where("updated_at < ?", Time.now - 1.month).destroy_all
  end

  private

    def generate_token
      self.token = encrypt
    end

    def encrypt
      secure_hash("#{Time.now.utc - (rand(1000).hours)}--#{self.user.email}--#{self.user.salt}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def remove_the_same_devices
      if push_token.present?
        Session.where(push_token: push_token).destroy_all
      end
      last_sessions = user.sessions.order(updated_at: :desc).limit(5)
      if last_sessions.any?
        user.sessions.where.not(id: last_sessions.map(&:id)).destroy_all
      end
    end

    def remove_expired_sessions
      Session.destroy_expired
    end
end
