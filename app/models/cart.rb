class Cart < ActiveRecord::Base

	attr_reader :items
	attr_reader :total_price

	def initialize

		@items = []
		@total_price = 0.0
	end


    # when the user select an album then, we are ready to add that album to the shopping cart
    # and display the pirce for that album


	def add_album(album)
		line_item = lineItem.new
		line_item.album = album
		line_item.quantity = 1
		line_item.price = album.price
		@items << line_item
		@total_price += line_item.price
	end



end
