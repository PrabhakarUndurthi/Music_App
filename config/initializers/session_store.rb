# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Music_App_session',
  :secret      => 'f286e5d18c9e4fd0cfac446f23981ec0ca1919c373673ff2369fe9fdaf73640b574e40382067a1552af1f60d1c5bc5bd57b191a8f3e9b426dc1146db7475c941'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
