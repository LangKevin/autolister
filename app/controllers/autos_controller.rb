# require 'rack-flash'

class AutosController < ApplicationController
  # use Rack::Flash

  get '/autos' do
    @autos = Auto.all
    erb :'/autos/index'
  end

  get '/autos/new' do
    @user = User.find(session[:user_id])
    @owner = Owner.find_by_user(@user)
    # binding.pry
    erb :'/autos/new'
  end

  get '/autos/:slug' do
    @auto = Auto.find_by_slug(params[:slug])
# binding.pry
    erb :'autos/show'
  end

  post '/autos' do
# binding.pry
    @user = User.find(session[:user_id])
    @owner = Owner.find_by_user(@user)
    @auto = Auto.create(params)
    @auto.owner = @owner
    @auto.buyer_ids = params[:buyers]
 binding.pry
    @auto.save

    # flash[:message] = "Successfully created song."

    redirect("/owners/#{@owner.slug}")
  end

  get '/autos/:slug/edit' do
    @auto = Auto.find_by_slug(params[:slug])
    erb :'autos/edit'
  end

  patch '/autos/:slug' do
    @auto = Auto.find_by_slug(params[:slug])
    @auto.update(params[:auto])
    @auto.owner = Owner.find_or_create_by(name: params[:owner][:name])
    @song.buyer_ids = params[:buyer]
    @song.save

    # flash[:message] = "Successfully updated song."
    redirect("/autos/#{@auto.slug}")
  end

end
