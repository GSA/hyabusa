# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

require 'factory_girl_rails'

if Role.count == 0
  YAML.load(ENV['ROLES']).each do |role|
    Role.create!(name: role)
    puts 'role: ' << role
  end
end

if EntityType.count == 0
  FactoryGirl.create(:entity_type_usc)
  FactoryGirl.create(:entity_type_student)
  FactoryGirl.create(:entity_type_corp_domestic)
  FactoryGirl.create(:entity_type_us_corp_foreign)
  FactoryGirl.create(:entity_type_corp_foreign)
  FactoryGirl.create(:entity_type_other)
end

