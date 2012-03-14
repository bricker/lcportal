# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
begin
  LCPortal::Application.config.secret_token = Secrets['secret_token']
rescue
  LCPortal::Application.config.secret_token = "" # cookies will not work but the app will load
end