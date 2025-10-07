class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authenticated
  
  def after_sign_in_path_for(_resource)
    root_path
  end
end
