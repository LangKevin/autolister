# require 'rack-flash'

class AutosController < ApplicationController
  # use Rack::Flash

  get '/autos' do
    @autos = Auto.all
    erb :'/autos/index'
  end

  get '/autos/new' do
    erb :'/autos/new'
  end

  get '/autos/:slug' do
    @auto = Auto.find_by_slug(params[:slug])

    erb :'autos/show'
  end

  post '/autos' do
    @auto = Auto.create(:name => params["Name"])
    @auto.owner = Owner.find_or_create_by(:name => params["Owner Name"])
    @auto.buyer_ids = params[:buyers]
    @auto.save

    flash[:message] = "Successfully created song."

    redirect("/autos/#{@auto.slug}")
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
