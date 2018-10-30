Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts 'Adding countries ...'
seed_countries
puts 'Country added'

puts 'Create admin ...'
User.create email: 'admin@gmail.com',
            password: 'secret',
            password_confirmation: 'secret',
            role_id: Role.get_admin.id,
            first_name: 'Admin',
            last_name: 'Admini4',
            country: Country.first
