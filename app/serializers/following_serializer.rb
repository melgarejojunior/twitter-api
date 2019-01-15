class FollowingSerializer < ActiveModel::Serializer
    belongs_to :user
    attributes :following_id
end