class BuyersController < ApplicationController
  get '/buyers' do
    @buyers = Buyers.all
    erb :'buyers/index'
  end

  get '/buyers/:slug' do
    @buyer = Buyer.find_by_slug(params[:slug])
    erb :'/buyers/show'
  end
end
