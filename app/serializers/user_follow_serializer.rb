class UserFollowSerializer < ActiveModel::Serializer
    belongs_to :user, serializer: UserSerializer
    attribute :follow
end