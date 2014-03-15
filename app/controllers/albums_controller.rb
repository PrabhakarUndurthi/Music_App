class AlbumsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @album_pages, @albums = paginate :albums, :per_page => 10
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @artists = Artist.find(:all)
    @features = Feature.find(:all)
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    artist = Artist.find_by_id(params[:artist_id])
    @album.artist = artist
    @features = Feature.find(:all)
    checked_features = check_features_using(params[:feature_list])
    uncheck_missing_features(@features, checked_features)
    if @album.save
      flash[:notice] = 'Album was successfully created.'
      redirect_to :action => 'list'
    else
      @artists = Artist.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @artists = Artist.find(:all)
    @features = Feature.find(:all)
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    artist = Artist.find_by_id(params[:artist_id])
    @album.artist = artist
    @features = Feature.find(:all)
    checked_features = check_features_using(params[:feature_list])
    uncheck_missing_features(@features, checked_features)
    if @album.update_attributes(params[:album])
      flash[:notice] = 'Album was successfully updated.'
      redirect_to :action => 'show', :id => @album
    else
      @artists = Artist.find(:all)
      render :action => 'edit'
    end
  end

  def destroy
    Album.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  private #-------------------------
  
  def check_features_using( feature_id_array )
    checked_features = []
    checked_params = feature_id_array || []
    for check_box_id in checked_params
      feature = Feature.find(check_box_id)
      if not @album.features.include?(feature)
        @album.features << feature
      end
      checked_features << feature
    end
    return checked_features
  end
  
  def uncheck_missing_features( features, checked_features)
    missing_features = features - checked_features
    for feature in missing_features
      if @album.features.include?(feature)
         @album.features.delete(feature)
       end
    end
  end
  
end
