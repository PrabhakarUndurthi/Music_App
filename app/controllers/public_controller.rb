class PublicController < ApplicationController

	def list
		@albums = Album.find(:all, :order => 'title ASC')
	end

	def add_to_cart
		# when the user picks up an item or product, this method would 
		# allow that item to add into the shopping cart.
		# when the user picks up an item, it creates the new cart for that user.

		album = Album.find(:params[:id])
		@Cart = Cart.new
		@Cart.add_album(album)
		redirect_to(:action => 'show_cart')
	end

	def show_cart
	end
	


end
