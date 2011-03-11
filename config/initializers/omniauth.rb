Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '101156866607469', '6cab250fd32be78d065fb2d5cfa9ac10'
end

