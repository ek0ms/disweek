class Album::PhotosController < PhotosController
  def index
    @liked_photos = UserPhoto.where(user: current_user)
    @photo = UserPhoto.new
  end

  def create
    @location = Location.find(params[:user_photo][:location_id].first.to_i)
    if UserPhoto.where(user: current_user, photo_id: params[:user_photo][:photo_id].first.to_i).empty?
      UserPhoto.create(user: current_user, photo_id: params[:user_photo][:photo_id].first.to_i)
    end
    redirect_to location_path(@location)
  end

  def destroy
    @liked_photo = UserPhoto.find(params[:id])
    @liked_photo.destroy
    redirect_to user_photos_path
  end
end
