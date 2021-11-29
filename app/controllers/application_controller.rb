class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:seminar])
      end

      def after_sign_in_path_for(resource)
        admins_root_path(current_admin) # your path
      end

      def seminar?
        Admin.all.each do |a|
          return true if a.seminar
        end
        return false
      end

end
