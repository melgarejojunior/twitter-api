class UserSerializer < ActiveModel::Serializer

    attributes :id, :name, :email, :num_of_followers, :num_of_followings

end