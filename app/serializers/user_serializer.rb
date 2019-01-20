class UserSerializer < ActiveModel::Serializer

    attributes :id, :name, :email, :num_of_followers, :num_of_followings, :avatar

    def avatar
    return nil if object.avatar.nil?

    {
      mini_thumb: object.avatar.url,
      thumb: object.avatar.url,
      medium: object.avatar.url
    }
  end

end