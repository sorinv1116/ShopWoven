class SessionsController < ApplicationController
  include ShopifyApp::SessionsController

  def new
    @shop ||= Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.shopify_token = "Fake Token"

    if @shop.save
      flash[:notice] = "You successfully signed up."
      render :new # TODO: It should redirect to shop settings page.
    else
      render :new
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:owner_email, :owner_password, :shopify_domain)
  end
end
