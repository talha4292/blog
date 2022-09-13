# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'bloggyadmin@gmail.com', first_name: 'Bloggy', last_name: 'Admin', username: 'bloggyadmin',
            about: '', birthday: '1991-09-13', role: 'admin', image_data: nil, password: '123456',
            password_confirmation: '123456')
