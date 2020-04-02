class ArtistsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show ,:create]
    before_action :find_artist , except: [:index, :new, :create ]

    def index
        
        @artists = current_user.artists.all 
    end

    def show
        @songs = @artist.songs
        
       if@artist.user != current_user
       flash[:notice] = 'Not allowed!'
        redirect_to artists_path
        end
    end

    def new
        @artist = Artist.new
    end

    def create
        @artist =  Artist.create(params.require(:artist).permit(:name, :albums, :hometown, :img))
        @artist.user = current_user
        redirect_to artists_path
    end

    def edit
        redirect_to artists_path
    end

    def update
 
        artist.update(params.require(:artist).permit(:name, :albums, :hometown, :img))
          
        redirect_to artist
    end

    def destroy
      
        redirect_to artists_path
    end
    private
    
    def person_params
      params.require(:artist).permit(:name, :albums, :hometown, :img)
    end
   
    def find_artist
        @artist = Artist.find(params[:id])
      end

end
