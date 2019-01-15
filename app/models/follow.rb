class Follow < ApplicationRecord
    belongs_to :follower, :class_name => 'User'
    belongs_to :following, :class_name => 'User'

    validate :follow_itself?

    def follow_itself?
        return self.following_id != self.follower_id
    end
end
