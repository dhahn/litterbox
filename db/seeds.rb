# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# lat = 37.205340
# lon = -93.289870
digits = (1..9).to_a
chars = ('A'..'Z').to_a
latitude_range = 24.396308..49.384358
longitude_range = -124.848974..-66.885444
kitty_text = "Destroy couch. Thug cat cat snacks, chase the pig around the house why must they do that mark territory, yet poop in litter box, scratch the walls. I like big cats and i can not lie. Mew chase ball of string chase dog then run away purr while eating or jump off balcony, onto stranger's head make muffins. Spit up on light gray carpet instead of adjacent linoleum lick arm hair chirp at birds. Meow. Wake up human for food at 4am chase ball of string. Intently stare at the same spot roll on the floor purring your whiskers off chase laser or spit up on light gray carpet instead of adjacent linoleum or scamper sleep in the bathroom sink, yet fall over dead (not really but gets sypathy). Bathe private parts with tongue then lick owner's face jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed, for shove bum in owner's face like camera lens but sleep in the bathroom sink. Sleep on dog bed, force dog to sleep on floor hide when guests come over. Behind the couch jump around on couch, meow constantly until given food, but play riveting piece on synthesizer keyboard stare out the window, sleep in the bathroom sink hack up furballs. Cat is love, cat is life pooping rainbow while flying in a toasted bread costume in space so swat at dog, meowwww leave dead animals as gifts curl into a furry donut, tuxedo cats always looking dapper. Drink water out of the faucet. Throwup on your pillow scratch leg; meow for can opener to feed me or eat prawns daintily with a claw then lick paws clean wash down prawns with a lap of carnation milk then retire to the warmest spot on the couch to claw at the fabric before taking a catnap. Peer out window, chatter at birds, lure them to mouth poop in litter box, scratch the walls so leave fur on owners clothes white cat sleeps on a black shirt yet attack feet, so jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed. Eat from dog's food refuse to drink water except out of someone's glass. Meowwww. Hide when guests come over hate dog poop on grasses and steal the warm chair right after you get up for cat is love, cat is life cough furball, all of a sudden cat goes crazy. Climb leg sleep on keyboard. Chase the pig around the house intrigued by the shower, so nap all day stretch, but immediately regret falling into bathtub for has closed eyes but still sees you meowing non stop for food. Throwup on your pillow ignore the squirrels, you'll never catch them anyway. Who's the baby meow hiss at vacuum cleaner destroy couch. Poop in litter box, scratch the walls flop over jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed jump launch to pounce upon little yarn mouse, bare fangs at toy run hide in litter box until treats are fed but destroy couch, or hack up furballs, thug cat . Then cats take over the world if it fits, i sits. Poop in the plant pot chase dog then run away white cat sleeps on a black shirt. Behind the couch ears back wide eyed or destroy the blinds pooping rainbow while flying in a toasted bread costume in space so rub face on owner. Thug cat who's the baby see owner, run in terror, or see owner, run in terror present belly, scratch hand when stroked or tuxedo cats always looking dapper or meowwww. Jump off balcony, onto stranger's head pooping rainbow while flying in a toasted bread costume in space so chase mice. Stare out the window sit in box. Knock dish off table head butt cant eat out of my own dish. Sleep on dog bed, force dog to sleep on floor cat is love, cat is life need to chase tail, for sleep nap lick arm hair. Behind the couch. Sleep in the bathroom sink shake treat bag. Lick arm hair favor packaging over toy knock over christmas tree eat from dog's food and chase ball of string attack feet. Destroy couch as revenge intently sniff hand stand in front of the computer screen. Loves cheeseburgers caticus cuteicus meowwww vommit food and eat it again, for scream at teh bath or stick butt in face. Stare at the wall, play with food and get confused by dust. Hopped up on catnip rub face on everything hiss at vacuum cleaner leave dead animals as gifts, and always hungry for my left donut is missing, as is my right. Chirp at birds mew leave hair everywhere then cats take over the world, hack up furballs. Meow all night having their mate disturbing sleeping humans leave fur on owners clothes yet knock dish off table head butt cant eat out of my own dish purr for no reason. Stand in front of the computer screen lick butt steal the warm chair right after you get up, scratch leg; meow for can opener to feed me but hide when guests come over meow all night having their mate disturbing sleeping humans yet thug cat . Lick butt play time chase the pig around the house hunt by meowing loudly at 5am next to human slave food dispenser, so thug cat . Under the bed peer out window, chatter at birds, lure them to mouth hopped up on catnip roll on the floor purring your whiskers off play riveting piece on synthesizer keyboard or scratch the furniture the dog smells bad. Chase mice meowwww why must they do that, yet find something else more interesting. Eat and than sleep on your face lick butt chew iPad power cord, or attack feet, for ignore the squirrels, you'll never catch them anyway. Damn that dog leave dead animals as gifts stick butt in face sit in box scratch the furniture or human is washing you why halp oh the horror flee scratch hiss bite. Scratch the furniture plan steps for world domination or eat grass, throw it back up eat prawns daintily with a claw then lick paws clean wash down prawns with a lap of carnation milk then retire to the warmest spot on the couch to claw at the fabric before taking a catnap. My left donut is missing, as is my right need to chase tail hunt by meowing loudly at 5am next to human slave food dispenser but leave fur on owners clothes yet caticus cuteicus why must they do that, or vommit food and eat it again. Eat from dog's food flop over, and meowzer! or eat from dog's food curl into a furry donut, meow for drink water out of the faucet. Scream at teh bath lick butt i like big cats and i can not lie and eat prawns daintily with a claw then lick paws clean wash down prawns with a lap of carnation milk then retire to the warmest spot on the couch to claw at the fabric before taking a catnap. Scratch the furniture roll on the floor purring your whiskers off so get video posted to internet for chasing red dot love to play with owner's hair tie leave fur on owners clothes. Stare at the wall, play with food and get confused by dust eat from dog's food but ignore the squirrels, you'll never catch them anyway. See owner, run in terror intently stare at the same spot, yet paw at your fat belly so kick up litter. Chase ball of string jump around on couch, meow constantly until given food, . Sit by the fire spit up on light gray carpet instead of adjacent linoleum. Bathe private parts with tongue then lick owner's face cat is love, cat is life so sleep on dog bed, force dog to sleep on floor kitty loves pigs. "
state_array = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
street_modifier_array = %w(Street Road Lane Avenue Boulevard)

400.times do |i|
	kitty = KittyNames.kitty
	pw = SecureRandom.hex

	user = User.create(
		email: kitty.email.sub(/@/, "#{i}@"),
		password: pw,
		password_confirmation: pw,
		first_name: kitty.first_name,
		last_name: kitty.last_name,
		age: rand(18..35),
		primary_phone: digits.sample(10).join,
		secondary_phone: digits.sample(10).join,
		gender: kitty.gender.to_s[0] || ['m', 'f'].sample
	)

	litter_box = LitterBox.create(
		user_id: user.id,
		capacity: rand(1..5),
		name: "#{kitty.first_name} #{kitty.last_name}'s Litterbox",
		description: kitty_text.split('. ').sample(3).join('. '),
		city: "#{KittyNames.last_name}ville",
		state: state_array.sample,
		address_line_1: "#{digits.sample(4).join} #{KittyNames.last_name} #{street_modifier_array.sample}",
		address_line_2: ["", "Apt. #{chars.sample}#{digits.sample(3).join}"].sample,
		zip: digits.sample(5).join,
		number_of_adults: rand(1..3),
		number_of_children: rand(0..3),
		number_of_pets: rand(0..3),
		latitude: rand(latitude_range),
		longitude: rand(longitude_range),
		price: rand(30..150)
	)
end
