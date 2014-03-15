class PublicController < ApplicationController

	before_filter :find_or_create_cart, :only => [:add_to_cart, :show_cart,:empty_cart]

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

	def empty_cart
		#it removes all the items from the cart
		# and redirect the user to the list to do more shopping.
		@Cart.empty_all_items
		flash[:notice] = 'Your cart is empty.'
		redirect_to(:action => 'list')
	end


	private #..................

	def find_or_create_cart
		# If the session is availbel, then it finds, otherwise
		# it creates a new session
		@Cart=session[:cart] ||= Cart.new
	end




end
