module Opened 
  extend ActiveSupport::Concern

  included do 
    scope :opened, -> { where(opened: true, user: user) }
    scope :closed, -> { where(opened: false, user: user) }
  end

  def open 
    update_attribute :opened, true
  end

  def close 
    update_attribute :opened, false
  end


end