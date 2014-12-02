# -*- encoding : utf-8 -*-
module UUID
  def self.included(base)
    base.extend(ClassMethods)
    base.before_create :set_uuid
  end

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  module ClassMethods
    def find_uuid uuid
      self.where(uuid: uuid).first || raise(ActiveRecord::RecordNotFound)
    end
  end
end
