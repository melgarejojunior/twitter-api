class UsersController < ApplicationController
	before_action :authenticate, except: [:create, :sign_in]

	def index
		followers_list = CreateUserFollowerList.new({ users: User.all, me: @user }).call
		render json: followers_list, status: :ok
	end

	def create
		name = params[:name]
		email = params[:email]
		password = params[:password]

		user = User.create(name: name, email: email, password: password)

		unless user.errors.present?
			render json: { id: user.id, name: user.name, email: user.email, token: user.token }, status: :created
		else
			render json: { errors: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
		end
	end

	def show
		render json: @user, status: :ok
	end

	def update
		email = params[:email]
		name = params[:name]

		@user.email = email
		@user.name = name

		if @user.save
			render json: user, status: :ok
		else
			render json: { errors: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
		end
	end

	def destroy
		unless @user.destroy
			render json: { errors: @user.errors.full_messages.join(", ") }, status: :unprocessable_entity
		else
			render body: nil, status: :ok
		end
	end

	def sign_in
		email = params[:email]
		password = params[:password]
		user = User.find_by(email: email)

		if user.present? and user.password == password
			user.update_token
			user.save
			render json: { id: user.id, name: user.name, email: user.email, token: user.token }, status: :ok
		else
			render json: { errors: "Email or Password invalid" }, status: :unprocessable_entity
		end
	end

	private
end
