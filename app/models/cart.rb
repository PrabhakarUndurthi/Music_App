
class Cart
  
  attr_reader :items
  attr_reader :total_price
  
  def initialize
    empty_all_items
  end

  #if the user wants to remove all the items from the shopping cart.
  
  def empty_all_items
    @items = []
    @total_price = 0.0
  end

  #when the user select an album then, we are ready to add that album to the shopping cart
    # and display the pirce for that album

  
  def add_album( album )
    existing_item = @items.find {|item| item.album_id == album.id}
    if existing_item
      existing_item.quantity += 1
    else
      @items << LineItem.new_based_on(album)
    end
    @total_price += album.price
  end

  #if the user wants to remove or delete an item
  #it would let the user to make that happen.
  
  def remove_album( album )
    existing_item = @items.find {|item| item.album_id == album.id}
    if existing_item && existing_item.quantity > 1
      existing_item.quantity -= 1
    else
      @items.delete(existing_item)
    end
    @total_price -= album.price
  end
  
end






    

	