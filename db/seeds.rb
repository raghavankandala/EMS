# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user = User.create(:email => 'admin@saaku.in', :password => 'admin123', :password_confirmation => 'admin123')
role = Role.create(:name => 'admin')
user.roles << role
user.save

