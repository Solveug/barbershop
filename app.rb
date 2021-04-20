require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
  @db = SQLite3::Database.new 'barbershop.db'
  @db.execute 'CREATE TABLE IF NOT EXISTS
  "Users"
  (
  "id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "username"  TEXT,
  "phone" TEXT,
  "darestamp" TEXT,
  "barber"  TEXT,
  "color" TEXT
  )'
end

get '/' do
	erb :index
end

get '/about' do
  #@error = 'Ошибка!'
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  hh = {:username => 'Введите имя',
      :phone => 'Введите телефон',
      :datetime => 'Введите дату и время'}

  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :visit
  end

  erb "#{@username}, контактный телефон: #{@phone}, вы записались: #{@datetime}, к #{@barber} и выбрали цвет: #{@color}"
end

get '/contacts' do
  erb :contacts
end

# def under_construction
#   @title = 'Under construction'
#   @message = 'This page is under construction'

#   erb :message
# end

# post '/' do
#   @login = params[:login]
#   @pasword = params[:pasword]

#   if @login == 'admin' && @pasword == 'secret'
#     erb :welcome
#   elsif @login == 'admin' && @pasword == 'admin'
#     @message = 'Nise try! Access denied'
#     erb :index
#   else
#     @message = 'Access denied'
#     erb :index
#   end
#  end
