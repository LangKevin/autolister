class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb:'owners/index'
  end

  get '/owners/:slug' do
    @owner = Owner.find_by_slug(params[:slug])
    erb :'owners/show'
  end
  
end
