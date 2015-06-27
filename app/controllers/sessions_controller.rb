class SessionsController < ApplicationController
  include ShopifyApp::SessionsController

  def new
    super
    @store ||= Shop.new
  end

  def create
    session[:store] = store_params
    super
  end

  def callback

    if response = request.env['omniauth.auth']
      param = session[:store]
      @store = Shop.find_by_shop(param[:shop])
      if @store.present?
        if @store.email != param[:email] || @store.password != Secure.encrypt_md5(param[:password])
          flash[:error] = "Your email or password is incorrect!"
          redirect_to action: 'new'
        end
      else
        @store = Shop.new(param)
        @store.password = Secure.encrypt_md5(param[:password])
        @store.token = response['credentials']['token']

        save_store
      end
    end

    super
  end  

  private

  def store_params
    params.require(:store).permit(:email, :password, :shop)
  end

  def save_store
    unless @store.save 
      flash[:error] = "Error occured!"
      redirect_to action: 'new'
    end
  end

end
