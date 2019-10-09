class BuyersController < ApplicationController
  get '/buyers' do
    @buyers = Buyers.all
    erb :'buyers/index'
  end

  get '/buyers/:slug' do
 binding.pry
    @buyer = Buyer.find_by_slug(params[:slug])
    erb :'/buyers/show'
  end

  post '/buyers' do
 binding.pry
    @user = User.find(session[:user_id])
    @buyer = Buyer.find_by_user(@user)
    @buyer.auto_ids = params[:autos]
    @buyer.save
    redirect("/buyers/#{@buyer.slug}")

    # flash[:message] = "Successfully created song."
  end
end
