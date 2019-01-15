class CreateUserFollowerList
    def initialize(args)
        @users = args[:users]
        @current_user = args[:me]
    end
    
    def call
        response = []
        @users.each do |u|
            response << { user: u.slice(:name, :email), follow: @current_user.follow?(u) }
        end
        return response
    end
end