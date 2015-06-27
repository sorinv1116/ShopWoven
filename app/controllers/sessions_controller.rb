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
      @store = Shop.new(session[:store])
      @store.token = response['credentials']['token']

      unless @store.save 
        flash[:error] = "Error occured!"
        redirect_to action: 'new'
      end
    end

    super
  end  

  private

  def store_params
    params.require(:store).permit(:email, :password, :shop)
  end

  def find_store
  end

end
