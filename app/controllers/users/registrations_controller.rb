class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Redirect to user profile after successful update
  def after_update_path_for(resource)
    profile_path
  end
end
