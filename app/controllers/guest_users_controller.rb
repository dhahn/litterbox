class GuestUsersController < ApplicationController
    require 'securerandom'
    #modify the shittyness of this
    def create
      i = SecureRandom.hex(6)
      user = User.create(
        email: "test#{i}@example.com",
        password: 'password',
        password_confirmation: 'password',
        first_name: "first name #{i}",
        last_name: "last name #{i}",
        age: rand(18..35),
        primary_phone: "1231231234",
        secondary_phone: "1231231234",
        gender: ['m', 'f'].sample,
      )
      sign_in(User, user) 
      redirect_to root_path
    end
end
