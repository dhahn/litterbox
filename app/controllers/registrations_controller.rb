class RegistrationsController < Devise::RegistrationsController
  before_action :set_page_title

  private

  def set_page_title
    @page_title = 'Litterbox - Registration'
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation, :primary_phone, :secondary_phone, :gender)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
      :password_confirmation, :primary_phone, :secondary_phone, :gender)
  end
end
