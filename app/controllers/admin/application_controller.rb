class Admin::ApplicationController < ApplicationController 
  layout 'admin'
  before_action :required_login, :required_admin

  private
    
    def required_admin
      raise AccessDenied unless current_user.admin?
    end
end

