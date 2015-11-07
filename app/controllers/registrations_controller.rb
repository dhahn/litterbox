class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation, :primary_phone, :secondary_phone, :gender)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation, :primary_phone, :secondary_phone, :gender)
  end
end
