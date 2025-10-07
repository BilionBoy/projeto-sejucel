# frozen_string_literal: true
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:oidc]

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.name  = auth.info.name
      user.email = auth.info.email
    end
  end

end
