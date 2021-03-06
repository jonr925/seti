# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class User < ActiveRecord::Base
  has_many :assignments
  #def to_param
  #  [provider, uid].join('-')
  #end

  ROLES = {:user=>"User", :admin=>"Administrator", :explorer=>"Explorer"}
  
  # Note we're using "User" to mean basically someone who just registered.
  
  DEFAULT_ROLE = :explorer

  def initialize(params = nil)
    super
    self.role ||= DEFAULT_ROLE
  end

  def self.create_with_omniauth(auth, user_agent)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      if auth["provider"] == 'facebook'
        user.email = auth["extra"]["user_hash"]["email"]  rescue "-"
      elsif auth["provider"] == "google"
        user.email = auth["user_info"]["email"]  rescue "-"
      end
      user.user_agent_at_creation = user_agent
    end
  end

  def friendly_role
    role ? ROLES[role.to_sym] : ""
  end
end
