require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.sqlite3"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.all
	erb :index
end

get '/about' do
	erb :about
end

before '/visit' do
	@barbers = Barber.all
end	

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@date_time = params[:date_time]
	@barber = params[:barber]
	@color = params[:color]

	Client.create :name => @username,
				  :phone => @phone,
				  :datestamp => @date_time,
				  :barber => @barber,
				  :color => @color

	erb "<h2>Спасибо, вы записались!</h2>"

end
