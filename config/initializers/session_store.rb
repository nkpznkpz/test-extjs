# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tradex_rails2_session',
  :secret      => '5df4ce948592132b40986da2adbc96a3d6699ae01e342767e24e6528f15f46ffa2f2ca8fc1c1c8674347c14d4f6ede2453d33bae89336cec1f500526de773cba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
