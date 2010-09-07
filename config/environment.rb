# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.9' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'haml'
  config.gem 'will_paginate'
  config.gem 'paperclip'

  config.time_zone = 'UTC'
  # Configure the default encoding used in templates for Ruby 1.9.
  Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'
  #ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  #  "<span class='field_error'>#{html_tag}</span>"
  #end
end

