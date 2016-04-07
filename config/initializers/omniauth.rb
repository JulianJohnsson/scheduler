Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '624478663257-h83mvkfvteiqambvrmfcctrpaqgdee9n.apps.googleusercontent.com', 'JygxYxsvvM0cC-YBS1-Pv44K',
  	scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE