class Country < ApplicationRecord

  has_attached_file :flag,
                    styles: { medium: '1024x768', small: '100x100>'},
                    default_url: '/images/missing.png',
                    path: ":rails_root/public/system/images/countries/:style/:filename",
                    url: "/system/images/countries/:style/:filename"

  validates_attachment_size :flag, less_than: 20.megabytes
  validates_attachment_content_type :flag, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :phone_code, presence: true
  validates :alpha2_code, presence: true
  validates :alpha3_code, presence: true
  validates :numeric_code, presence: true

end
