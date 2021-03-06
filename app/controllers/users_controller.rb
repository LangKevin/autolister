require "./config/environment"
require "./app/models/user"
class UsersController < ApplicationController
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  # get "/" do
  #   erb :index
  # end

  get "/login" do
    if is_logged_in?
      @user = User.find(session[:user_id])
      if @user.is_owner
        @owner = Owner.find_by_user(@user)
        redirect("/owners/#{@owner.slug}")
      else
        @buyer = Buyer.find_by_user(@user)
        redirect("/buyers/#{@buyer.slug}")

      end
    else
      erb :'users/login'
    end
  end
  get "/signup" do
    # binding.pry
    if is_logged_in?
      @user = User.find(session[:user_id])
      if @user.is_owner
        @owner = Owner.find_by_user(@user)
        redirect("/owners/#{@owner.slug}")
      else
        @buyer = Buyer.find_by_user(@user)
        redirect("/buyers/#{@buyer.slug}")
      end
    else
      # binding.pry
      erb :'users/create_user'
    end
  end
  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.new(params)
binding.pry
      if @user.is_owner
        @owner = Owner.new(name: params[:username])

      else
        @buyer = Buyer.new(name: params[:username])

        # binding.pry

      end
      @user.save
# binding.pry
      session[:user_id] = @user.id
      if @user.is_owner
        @owner.user = @user
        @owner.email = @user.email
        @owner.save
        redirect("/owners/#{@owner.slug}")
      else
# binding.pry
        @buyer.user = @user
        @buyer.email = @user.email
# binding.pry
        @buyer.save
        redirect("/buyers/#{@buyer.slug}")
      end
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.is_owner
        @owner = Owner.find_by_user(@user)
        redirect("/owners/#{@owner.slug}")
      else
        @buyer = Buyer.find_by_user(@user)
        redirect("/buyers/#{@buyer.slug}")
      end
    else
      redirect to "/signup"
    end
  end

  get "/failure" do
    erb :failure
  end
  get "/logout" do
    if is_logged_in?
      # redirect to '/tweets'
      session.destroy
      redirect to "/login"
    else
      redirect to '/'
    end
  end

end
