class JwtUserInfo < ActiveRecord::Base
  belongs_to :jwt_user

  after_create { RailsCommons::SubscribeJob.perform_later(self.email) }
end