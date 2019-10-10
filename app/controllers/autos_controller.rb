# require 'rack-flash'

class AutosController < ApplicationController
  # use Rack::Flash

  get '/autos' do
    @autos = Auto.all
    erb :'/autos/index'
  end

  get '/autos/new' do
    @user = User.find(session[:user_id])

    # binding.pry
    if @user.is_owner
      @owner = Owner.find_by_user(@user)
      erb :'/autos/new'
    else
      @buyer = Buyer.find_by_user(@user)
      erb :'/autos/newbuyer'
    end
  end

  get '/autos/:slug' do
    # binding.pry
    @auto = Auto.find_by_slug(params[:slug])
    # binding.pry
    erb :'autos/show'
  end

  post '/autos' do
  # binding.pry
    @user = User.find(session[:user_id])
    if @user.is_owner
      @owner = Owner.find_by_user(@user)
      @auto = Auto.create(params)
      @auto.owner = @owner
      @auto.buyer_ids = params[:buyers]
      @auto.save
      redirect("/owners/#{@owner.slug}")
    else
      @buyer = Buyer.find_by_user(@user)
      @buyer.auto_ids = params[:autos]
      @buyer.save
      redirect("/buyers/#{@buyer.slug}")
    end
    # flash[:message] = "Successfully created song."
  end

  get '/autos/:slug/edit' do
    binding.pry
    @auto = Auto.find_by_slug(params[:slug])
    erb :'autos/edit'
  end

  patch '/autos/:slug' do
    # binding.pry
    @auto = Auto.find_by_slug(params[:slug])
    @auto.update(params[:auto])
    @auto.owner = Owner.find_or_create_by(name: params[:owner][:name])
    @song.buyer_ids = params[:buyer]
    @song.save

    # flash[:message] = "Successfully updated song."
    redirect("/autos/#{@auto.slug}")
  end

end
