$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "master-user/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "master-user"
  s.version     = MasterUser::VERSION
  s.authors     = ["master"]
  s.email       = ["info@themastergolf.com"]
  s.homepage    = "http://www.mastergolf.cn"
  s.summary     = "Master User Center"
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "activerecord", ">= 4.0.0"
  s.add_dependency "activesupport", ">= 4.0.0"
  s.add_dependency "activemodel", ">= 4.0.0"
  s.add_dependency "carrierwave"
  s.add_dependency "carrierwave-imageoptimizer"
  s.add_dependency "rmagick"
  s.add_dependency "aasm"
  s.add_dependency "sunspot_rails"
end
