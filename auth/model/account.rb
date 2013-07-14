require 'data_mapper'

class User
  include DataMapper::Resource
  storage_names[:default] = "user"

  property :user_id, Serial
  property :email, String, :length => 255, :required => true
  property :password_hash, String, :length => 255, :required => true
  property :role_id, Integer
  property :active, Boolean
end
