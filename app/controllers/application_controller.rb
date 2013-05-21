class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    cart   = session[:cart_id] ? Cart.find(session[:cart_id]) : nil
    cart ||= Cart.create

    session[:cart_id] = cart.id
    cart
  end
end
