require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  return SQLite3::Database.new 'barbershop.db'
end

def is_barber_exists? db, name
  db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers
  barbers.each do |barber|
    if !is_barber_exists? db, barber
      db.execute 'insert into Barbers (name) values (?)', [barber]
    end
  end
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS "Users"
  (
  "id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "username"  TEXT,
  "phone" TEXT,
  "datestamp" TEXT,
  "barber"  TEXT,
  "color" TEXT
  )'

  db.execute 'CREATE TABLE IF NOT EXISTS "Barbers"
    ("id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name"  TEXT)'

    seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Shinoda']
end

get '/' do
	erb :index
end

get '/about' do
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

  db = get_db
  db.execute "insert into
    'Users'
    (
      username,
      phone,
      datestamp,
      barber,
      color
    )
    values (?, ?, ?, ?, ?)", [@username, @phone, @datetime, @barber, @color]

  erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end

get '/contacts' do
  erb :contacts
end

get '/showusers' do
 # 1 вариант решения задания
 # @arr = '<style type="text/css">.row_line{color:red}</style>'
 #  db = get_db
 #  db.results_as_hash = true
 #   db.execute 'select * from Users' do |row|
 #     @arr << "<style type='text/css'>.row_line_#{row['id']}{color:#{row['color']}}</style>"
 #     @arr << "<li> #{row['id']}, #{row['username']}, #{row['phone']}, comin in #{row['datestamp']} to #{row['barber']} and want to paint in <text class ='row_line_#{row['id']}'>#{row['color']}</text> </li>\n"
 #   end


  db = get_db
  db.results_as_hash = true
  @results = db.execute 'select * from Users order by id desc'

  erb :showusers
end
