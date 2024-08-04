# Pallycon
A ruby gem for PALLYCON Multi-DRM integration

## Configuration
Please set PALLYCON credentials when your application initialize
```ruby
Pallycon.configure do |config|
  config.site_id         = "<your_site_id>"
  config.site_key        = "<your_site_key>"
  config.site_access_key = "<your_site_access_key>"
end
```

## Generate License Token
```ruby
drm_type = Pallycon::Drm::TYPES[:widevine]
user_id    = '<user_id>'
content_id = "<content_id>"
enc_key    = "<encryption_key>"

license_token = Pallycon::LicenseToken::Generator.generate(
  Pallycon::LicenseToken::Attributes.new({ drm_type: drm_type, user_id: user_id, content_id: content_id }),
  enc_key)
```