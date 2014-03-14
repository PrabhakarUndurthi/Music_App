class Album < ActiveRecord::Base


	belongs_to :artist
	has_and_belongs_to_many :features
  
  validates_presence_of :title, :artist
  validates_length_of :title, :minimum => 5
  #validates_uniqueness_of :artist
  
end
