# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_reminder_session',
  :secret      => '8b3c3bd971118e7da00825b29dffd024e975b5ed54a355db4842242595a9d7c753c53603386e4d305c833b4a8be9a2bd127c7f99ca8482c24f3c0fd18f564be9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
