# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.new
admin.email = 'bks@sequencer.com'
admin.password = 'password1'
admin.password_confirmation = 'password1'
admin.admin = true
admin.save

user = User.new
user.email = 'user@sequencer.com'
user.password = 'bananaDude'
user.password_confirmation = 'bananaDude'
user.save

sequence = Sequence.new
sequence.user = admin
sequence.save

asanas = [
   { name: 'Downward Facing Dog' },
   { name: 'Locust' },
   { name: 'Warrior Two' },
   { name: 'Crow' },
   { name: 'King Pidgeon' }
]

Asana.create(asanas)
