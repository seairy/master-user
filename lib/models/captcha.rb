# -*- encoding : utf-8 -*-
require 'open-uri'

class Captcha < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :user

  before_create :set_content_and_expired_at
  after_create :send_sms

  scope :generate, ->(use_for) { self.create({ use_for: use_for }) }
  scope :available, -> { where(available: true) }
  scope :today, -> { where('created_at >= ?', Time.now.beginning_of_day).where('created_at <= ?', Time.now.end_of_day) }

  def expire!
    self.update({ available: false })
  end

  protected
  def set_content_and_expired_at
    self.content = rand(1234..9876)
    self.expired_at = Time.now + 30.minutes
  end

  def send_sms
    open("http://121.199.16.178/webservice/sms.php?method=Submit&account=cf_twyd&password=teewell-2014&mobile=#{self.user.phone}&content=#{self.content}%EF%BC%8CMaster%E9%AB%98%E5%B0%94%E5%A4%ABApp%E6%89%8B%E6%9C%BA%E9%AA%8C%E8%AF%81%E7%A0%81%EF%BC%8C%E8%AF%B7%E5%8B%BF%E6%B3%84%E9%9C%B2%E7%BB%99%E5%85%B6%E4%BB%96%E4%BA%BA%E3%80%82")
  end
end
