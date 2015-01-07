# -*- encoding : utf-8 -*-
class Token < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :user

  before_create :set_content_and_expired_at

  scope :generate, -> { self.create }
  scope :available, -> { where(available: true).where('expired_at >= ?', Time.now).order(created_at: :desc).limit(1).first }

  def expire!
    self.update({ available: false })
  end

  protected
  def set_content_and_expired_at
    self.content = Digest::MD5.hexdigest("#{self.user.phone}-#{Time.now}-#{rand}")
    self.expired_at = Time.now + 1.year
  end
end
