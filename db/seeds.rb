# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'pratiman@winternify.com', password: 'summer2019', password_confirmation: 'summer2019')
Product.create(title: 'Toronto Raptors Jersey', price: 40.0, inventory_count: 5, inStock: true)
Product.create(title: 'Toronto Maple Leafs Jersey', price: 50.0, inventory_count: 3, inStock: true)
Product.create(title: 'Toronto FC Jersey', price: 45.0, inventory_count: 0, inStock: false)
