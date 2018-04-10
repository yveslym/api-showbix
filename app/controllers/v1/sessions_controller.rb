class V1::SessionsController < ApplicationController

'''check session open '''
def show


      current_user ? (render json: current_user, status: :ok) : head(:unauthorized)
end


''' create new user '''
  def create
#byebug
      # email = v1_sessions_params[:email].downcase
      #
      # username = v1_sessions_params[:username].downcase
      #
      # checkUserEmail = User.where(email: email).first
      #
      #checkUserUsername = User.where(username: username).first

       newUser = User.new(v1_sessions_params)
       if newUser.save
        render json: newUser, status: :created
    else
         head(:unauthorized)#render json: newUser.errors status: :unprocessable_entity
      end
      # @v1_user = User.new(v1_sessions_params)
      # if @v1_user.save
      #   render json: @v1_user, status: :ok
      # else
      #   render json: @v1_user.errors, status: :unprocessable_entity
      # end
  end

'''login'''
def login
    @v1_user = User.where(email: params[:email]).first
       if @v1_user&.valid_password?(params[:password])
           render json: @v1_user, status: :ok
       else
           head(:unauthorized)
       end
end

  '''log out user'''
  def destroy

    current_user&.authentication_token = nil
    if current_user.save

        head(:ok)
    else
        head(:unauthorized)
    end
  end
'''update user'''
  def update
      @v1_user = current_user

    if @v1_user.update(v1_sessions_params)
        render json: @v1_user, status: :ok
    else
        render json: @v1_user.errors, status: :unprocessable_entity
  end
end

private

def nilify_token
  current_user&.authentication_token = nil
end

def v1_sessions_params
      params.permit(:email, :password, :password_confirmation,:first_name,
          :last_name,:username, :image_file,:image_file_file_name,
          :image_file_content_type,:image_file_file_size, :image_file_updated_at,:sessions)
end
      # .require(:email, :password)


end
