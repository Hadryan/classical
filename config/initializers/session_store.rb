# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Classical_session',
  :secret      => 'd2860a7eadd935ae1a6f551a90f3e734b44b0ce3971755d420e125e5bc5acf39b3c9c2970804819ea5d105f686e3440da3c778bd7ca3890834cebfc1a2e931c1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
