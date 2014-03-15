class Cart < ActiveRecord::Base

	attr_reader :items
	attr_reader :total_price

	def initialize
        empty_all_items
	end

	def empty_all_items
		@items = []
		@total_price 0.0
	end



    # when the user select an album then, we are ready to add that album to the shopping cart
    # and display the pirce for that album


	def add_album(album)
		existing_item = @items.find{|item| item.album_id ==album.id}
	# if the item is already exists? then increase the quantity
	if existing_item
	  existing_item.quantity += 1
	else
		@items << LineItem.new_based_on(album)
	  end
	  @total_price += album.price
   end

end
