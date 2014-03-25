require 'active_record'
require './lib/product'
require './lib/cashier'
require './lib/purchase'
require './lib/customer'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  input=nil
  until input == 'x'
    puts "*******************************************************************"
    puts "*              Welcome to our Point of Sale app!                  *"
    puts "*******************************************************************"
    puts "* If you are a store manager, press 'm'.                          *"
    puts "* If you are a cashier, press 'c' and login with your credentials.*"
    puts "* Press 'x' to exit.                                              *"
    puts "*******************************************************************"
    main_menu_choice = gets.chomp.downcase

    case main_menu_choice
    when 'm'
      manager_menu
    when 'c'
      cashier_menu
    when 'x'
      puts "Goodbye!"
      exit
    else
      puts "Sorry try again."
      main_menu
    end
  end
end

def manager_menu
  puts "Enter 'a' to add a new products with name and price."
  puts "Enter 'lp' to list out products."
  puts "Enter 'c' to create a cashier."
  puts "Enter 'lc' to list out cashiers."

  user_input = gets.chomp.downcase
  case user_input
  when 'a'
    add_product
  when 'lp'
    list_product
  when 'c'
    add_cashier
  when 'lc'
    list_cashier
  when 'm'
    main_menu
  end
end

def add_product
  puts "Enter the name of the product."
  product_name = gets.chomp
  puts "Enter the price of the item."
  product_price = gets.chomp
  product = Product.new({:name => product_name, :price => product_price})
  product.save
  puts "You have added #{product_name} that has a price of #{product_price}."
end

def list_product
  puts "Here is a list of your products."
  Product.all.each_with_index do |product, index|
    puts "#{index + 1}: #{product.name} -- ID: #{product.id}."
  end
end

def add_cashier
  puts "Enter the name of the cashier."
  cashier_name = gets.chomp
  cashier = Cashier.new({:name => cashier_name})
  cashier.save
  puts "You have added #{cashier_name}."
end

def list_cashier
  puts "Here is a list of your cashiers."
  Cashier.all.each_with_index do |cashier, index|
  puts "#{index + 1}: #{cashier.name}."
  end
end

def cashier_menu
  puts "Press 'p' to enter purchases."
  puts "Press 'lp' to list purchases."

  cashier_input = gets.chomp.downcase
  case cashier_input
  when 'p'
    add_purchases
  when 'lp'
    list_purchases
  when 'm'
    main_menu
  end
end

def add_purchases
  puts "Please log in."
  cashier_login = gets.chomp.to_i

  list_product
  puts "Enter a product id."
  product_id = gets.chomp.to_i

  purchase = Purchase.new({:cashier_id => cashier_login, :product_id => product_id})
  purchase.save

  puts "Do you want to enter another transaction? Press 'y' for yes and 'n' for no."
  cashier_choice = gets.chomp
  if cashier_choice == 'y'
    add_purchases
  elsif cashier_choice == 'n'
    list_purchases
  else
    puts "That is not a valid entry.  Please try again."
  end
end

def list_purchases
  puts "Here is a list of your purchases."
  Purchase.all.each_with_index do |purchase, index|
    puts "#{index + 1}: #{purchase.product.name}"
  end
end

main_menu
