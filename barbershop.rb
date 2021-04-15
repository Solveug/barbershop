require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]

  @title = 'Thank you!'
  @message = "Dear #{@user_name}, we'll be waiting you at #{@date_time}"

  erb :message
end

# get '/contacts' do
#   under_construction
# end

# get '/faq' do
#   under_construction
# end

# get '/something' do
#   under_construction
# end

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
# end
