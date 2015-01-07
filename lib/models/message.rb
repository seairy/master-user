# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
	has_many :message_params
	# include UUID
	scope :visible, -> {where(read: false).order(created_at: :desc)}
	def retrieve_message
		self.update(read: true,get_time: Time.now)
	end

	def param_content
		Hash[self.message_params.map{|x| [x.key,x.value]}]
	end

	def method_missing(m,*args)
		if self.message_params.where(key: m.to_s).count == 0
			super
		else
			self.message_params.where(key: m.to_s).first.value
		end
	end

	class << self
      def load_more last_request_uuid
      	last_message=Message.find_uuid last_request_uuid
      	self.unread.where('created_at < ?',last_message.created_at).where('uuid <> ?', last_message.uuid).order(created_at: :desc)
      end
    end

    def add_params key,value
    	MessageParam.create(message_id: self.id, key: key, value: value)
    end
end