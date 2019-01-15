class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :text, :created_at
    belongs_to :user, serializer: UserSerializer
end