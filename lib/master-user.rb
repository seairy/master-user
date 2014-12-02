require 'carrierwave/orm/activerecord'
require 'sunspot'
require 'sunspot/rails'

module MasterUser
  
end

utilities_dir = File.dirname(__FILE__) + '/utilities/*.rb'
models_dir = File.dirname(__FILE__) + '/models/*.rb'
uploaders_dir = File.dirname(__FILE__) + '/uploaders/*.rb'
Dir[utilities_dir, uploaders_dir, models_dir].each{|f| require f}