require "rails_admin/application_controller"

module RailsAdmin
  class ApplicationController < ::ApplicationController
    access_control do
      allow :admin
    end
  end
end