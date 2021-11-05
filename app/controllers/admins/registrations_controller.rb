class Admins::RegistrationsController < Devise::RegistrationsController

  protected
  def after_update_path_for(resource)
    admins_root_path(resource)
  end
end
