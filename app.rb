require 'active_record'
require 'pry'

require_relative "db/connection"
require_relative "models/apartment"
require_relative "models/tenant"

# Welcome to your LandLord app message
def welcome()
  puts '*' * 50, "\n"
  print '*' * 10, ' WELCOME TO YOUR LANDLORD APP ', '*' * 10, "\n"
  puts "\n"
end  

# Option menu
def options()
  puts "\n"
  puts '*' * 50
  puts "\n"
  puts "Your options are as follows: "
  puts "Please type 1 to see: a list of all apartments including ID#, address, and monthly rent."
  puts "Please type 2 to see: a list of all tenants including name and age."
  puts "Please type 3 to see: a list of all apartments and their associated tenants."
  puts "Please type 'exit' when you are finished"
  print "\nPlease type in your choice here: "
end

# Run app until user decides to exit
def app_start()
  welcome()
  options()
  option = gets.chomp
  # loop through until user exits
  while option != 'exit'
    if option.to_i == 1
      apartments()
    elsif option.to_i== 2
      tenants()
    elsif option.to_i == 3
      apartments_tenants()
    else 
      puts "I am sorry but I do not understand that command, please try again."
    end
    options()
    option =gets.chomp
  end 
end

# apartments listing
def apartments() 
  apartment = Apartment.all
  # loop through and print out all the apartments, id#, and monthly rent
  puts '*' * 50
  puts "\nYour apartments address, id#, and monthly rent are as follows \n \n"
  apartment.each do |apart|
    print "The address for apartment id number: #{apart.id}, is #{apart.address}, and its monthly rent is #{apart.monthly_rent} dollars. \n"
  end 
end

# tenants listing
def tenants()
  tenants = Tenant.all
  puts '*' * 50
  puts "\nThe name and age of each of your tenants is as follows: \n \n"
  tenants.each do |tenant| 
    print "#{tenant.name} is #{tenant.age} years old.\n"
  end
end

# Tenants and their aparments
def apartments_tenants()
  puts "*" * 50
  puts "\nYour aparments address and the tenants that live there as as follows. \n \n"
  Apartment.all.each do |apart|
    apart_id = apart.id
    apartment = Apartment.find_by(id: apart.id)
    puts "The tenants that live at apartment #{apart.address} are: "
    apartment.tenants.each do |tenant|
      puts "    #{tenant.name}"
    end
    puts "\n"
  end
end













# Start app
app_start()
