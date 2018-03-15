class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :calculate_s3, only: [:edit, :new]

  include SessionsHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def calculate_s3
    options = {
        # The name of your bucket.
        bucket: ENV['S3_BUCKET'],

        # S3 region. If you are using the default us-east-1, it this can be ignored.
        region: 'us-west-2',

        # The folder where to upload the images.
        keyStart: 'uploads',

        # File access.
        acl: 'public-read',

        # AWS keys.
        accessKey: ENV['AWS_ACCESS_KEY_ID'],
        secretKey: ENV['AWS_SECRET_ACCESS_KEY']
    }

    # Compute the signature.
    @aws_data = FroalaEditorSDK::S3.data_hash(options)
  end
end
