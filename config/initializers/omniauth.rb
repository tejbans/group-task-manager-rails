Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, '581690548664446', '5615e5b9046a11afada09e62e70c033a'
    end