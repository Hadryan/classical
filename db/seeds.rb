# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Generating admin user..."
admin_user = User.create(:email => 'admin@admin.com', :password => 'admin1234', :password_confirmation => 'admin1234')
admin_user.has_role! :admin

puts "Generating test users..."
test_user = User.create(:email => 'test@test.com', :password => 'test1234', :password_confirmation => 'test1234')

