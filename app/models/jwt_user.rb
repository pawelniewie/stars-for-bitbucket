class JwtUser < ActiveRecord::Base
  belongs_to :jwt_token
  has_many :jwt_user_info
end