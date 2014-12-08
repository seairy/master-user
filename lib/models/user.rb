# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  include UUID
  include AASM
  extend Sunspot::Rails::Searchable::ActsAsMethods

  self.table_name_prefix = ''

  mount_uploader :image, UserUploader

  has_many :captchas
  has_many :tokens
  has_many :followings, class_name: 'Followship'
  has_many :api_followings, class_name: 'Match::Followship'
  has_many :questions
  has_many :api_questions, class_name: 'Asking::Question'
  has_many :answers
  has_many :api_answers, class_name: 'Asking::Answer'
  has_many :collects
  has_many :api_collects, class_name: 'News::Collect'

  aasm column: 'state' do
    state :validating, :initial => true
    state :available
    state :prohibited

    event :signup, after: :set_signuped_at! do
      transitions from: :validating, to: :available
    end
    event :prohibit do
      transitions from: :available, to: :prohibited
    end
  end

  searchable do
    text :uuid, :phone, :email, :nickname, :description
  end

  validates :phone, uniqueness: true
  validates :nickname, presence: true, length: { maximum: 36 }
  validates :email, length: { in: 6..100 }, unless: "email.blank?"
  validates :handicap, length: { in: 1..3 }, unless: "handicap.blank?"

  def set_signuped_at!
    self.update({ signuped_at: Time.now })
  end

  def signin!
    self.update({ last_signined_at: self.current_signined_at, current_signined_at: Time.now})
  end

  def authenticate token
    valid_token = self.tokens.available
    if valid_token
      if valid_token.content == token
        true
      else
        false
      end
    else
      false
    end
  end

  def follow competitor
    raise FollowDuplicated unless self.api_followings.create({ competitor: competitor }).id
  end

  def unfollow competitor
    raise InexistentFollowship unless self.api_followings.where({ competitor: competitor }).first.try(&:destroy)
  end

  class << self
    def find_or_create phone
      self.where(phone: phone).first || self.create({ phone: phone, nickname: "用户****#{phone[-4..-1]}" })
    end

    def bulk_find uuids
      uuids.split(",").map{|uuid| User.where(uuid: uuid).first}.compact
    end
  end
end