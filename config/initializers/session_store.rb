# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_failingsanta_session',
  :secret      => 'a2e96ac04b761119b964598487a0d21855230807475a9371bd1d5c7740b1aeb6bb3e2850be9a59d00cdf5d3e8dcf4de73e165f46127e0e94230621b43ae35326'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
