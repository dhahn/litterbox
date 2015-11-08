class GuestUsersController < ApplicationController
  def create
    digits = (1..9).to_a
    kitty = KittyNames.kitty
    pw = SecureRandom.hex
    i = SecureRandom.hex(6)
    response = HTTParty.get('https://randomuser.me/api/')
    picture = JSON.parse(response.body)['results'][0]['user']['picture']['thumbnail']
    user = User.create(
      email: kitty.email.sub(/@/, "#{i}@"),
      password: pw,
      password_confirmation: pw,
      first_name: kitty.first_name,
      last_name: kitty.last_name,
      age: rand(18..35),
      gravatar: picture,
      primary_phone: digits.sample(10).join,
      secondary_phone: digits.sample(10).join,
      gender: kitty.gender.to_s[0] || ['m', 'f'].sample
    )
    sign_in(User, user)
    redirect_to search_show_path
  end
end
