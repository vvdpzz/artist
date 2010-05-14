# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_testThing_session',
  :secret      => 'de826e348fff5cf38c2f83ded87096f34f605e9b3d959daaa85dcd7b53c6d2a8204c0eb9ab6a05392b203baed995791a7edd644723bd1382716912b1282b4a01'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
