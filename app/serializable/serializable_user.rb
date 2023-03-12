class SerializableUser < JSONAPI::Serializable::Resource
  type 'user'

  attributes :username, :email, :jti
end
