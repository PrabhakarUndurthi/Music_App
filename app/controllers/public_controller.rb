class PublicController < ApplicationController

	def list
		@albums = Album.find(:all, :order => 'title ASC')
	end
	
end
