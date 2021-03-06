class Role < ApplicationRecord

  has_many :users

  NAMES = [:user, :admin]

  class << self
    NAMES.each do |name_constant|
      define_method("get_#{ name_constant }") { where(name: name_constant.to_s).first_or_create }
    end
  end
end
