require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    access_control do
      allow :admin
    end
  end
end

RailsAdmin.config do |config|
  config.model User do
    edit do
      group :default do
        label "Default group"
        field :email
        field :password
        field :password_confirmation
        field :roles
      end
    end
  end
end

