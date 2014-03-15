class PublicController < ApplicationController

	before_filter :find_or_create_cart, :only => [:add_to_cart, :show_cart,:empty_cart,:remove_from_cart]

     before_filter :find_or_create_cart, :except => [:list]
    layout 'standard'

	def list
		@albums = Album.find(:all, :order => 'title ASC')
		render(:layout => 'albums')
	end

	def add_to_cart
		# when the user picks up an item or product, this method would 
		# allow that item to add into the shopping cart.
		# when the user picks up an item, it creates the new cart for that user.

		album = Album.find(params[:id])
		#@Cart = find_or_create_cart
		@Cart.add_album(album)
		#session[:cart] = @Cart
		redirect_to(:action => 'show_cart')
	end

	def show_cart
		#@Cart = find_or_create_cart
	end

	def remove_from_cart
    album = Album.find(params[:id])
    @cart.remove_album(album)
    flash[:notice] = 'One item was removed from your cart.'
    redirect_to(:action => 'show_cart')
  end

	def empty_cart
		#it removes all the items from the cart
		# and redirect the user to the list to do more shopping.
		@Cart.empty_all_items
		flash[:notice] = 'Your cart is empty.'
		redirect_to(:action => 'list')
	end

	def checkout
    @customer = Customer.new
  end
  
  def save_order
    @customer = Customer.new(params[:customer])
    credit_card_number = params[:credit_card]
    @order = Order.new
    @order.line_items << @cart.items
    @customer.orders << @order
    if @customer.save
      #try to process payment
      #if payment fails, send user to a fix-it page
      #if payment succeeds
      @cart.empty_all_items
      flash[:notice] = 'Your purchase was successfully completed.'
      redirect_to(:action => 'show_receipt', :id => @order.id)
    else
      render(:action => 'checkout')
    end
  end

  def show_receipt
    @order = Order.find(params[:id])
  end


	private #..................

	def find_or_create_cart
		# If the session is availbel, then it finds, otherwise
		# it creates a new session
		@Cart=session[:cart] ||= Cart.new
	end




end
