require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  @login = params[:login]
  @pasword = params[:pasword]

  if @login == 'admin' && @pasword == 'secret'
      erb :welcome
  else
      'Access denied'
  end
  erb :index
end
