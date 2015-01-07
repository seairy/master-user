# -*- encoding : utf-8 -*-
class Complaint < ActiveRecord::Base
  self.table_name_prefix = ''
  
  belongs_to :defendant, class_name: 'User'
  belongs_to :complainant, class_name: 'User'
end
