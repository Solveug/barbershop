require 'sinatra'

get '/' do
  erb :index
end

get '/contacts' do
  @title = 'Contacts'
  @message = 'Phone number: 1122'

  erb :message
end

get '/faq' do
  @title = 'FAQ'
  @message = 'Under construction'

  erb :message
end

get '/something' do
  @title = 'Something'
  @message = 'Blabla'

  erb :message
end

post '/' do
  @login = params[:login]
  @pasword = params[:pasword]

  if @login == 'admin' && @pasword == 'secret'
    erb :welcome
  elsif @login == 'admin' && @pasword == 'admin'
    @message = 'Nise try! Access denied'
    erb :index
  else
    @message = 'Access denied'
    erb :index
  end
end
