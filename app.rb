require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.sqlite3"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
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

	errors = {
		:username => 'Введите имя',
		:phone => 'Введите телефон',
		:date_time => 'Введите дату и время'
	}

	errors.each do |key, value|

		if params[key] == ''
			@error = value
			return erb :visit
		end

	end

	Client.create :name => @username,
				  :phone => @phone,
				  :datestamp => @date_time,
				  :barber => @barber,
				  :color => @color

	erb "<h2>Спасибо, вы записались!</h2>"

end

get '/contacts' do
	erb :contacts
end

post '/contacts' do

	@email = params[:email]
	@text = params[:textarea]

	errors = {
		email: 'Введите email',
		textarea: 'Введите сообщение'
	}

	errors.each do |key, value|

		if params[key] == ''
			@error = value
			return erb :contacts
		end

	end

	Contact.create :email => @email,
				   :message => @text

	@message_contacts = 'Мы получили Ваше сообщение, обязательно Вам ответим'

	@email = ''

	erb :contacts

end
