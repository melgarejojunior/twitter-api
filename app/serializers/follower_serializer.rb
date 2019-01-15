class FollowerSerializer < ActiveModel::Serializer
    attributes :id

    belongs_to :follower
end