require 'sinatra'
require 'pg'
require './db_config'
require './model/dish'
require './model/dish_type'
require './model/comment'
require "sinatra/reloader"

def run_sql(sql)
	db = PG.connect(dbname: 'goodfoodhunting', user: 'isha')
	results = db.exec(sql)
	db.close
	return results
end

after do
	ActiveRecord::Base.connection.close
end

#show list of dishes
get '/' do
	# @dishes = run_sql('SELECT * FROM dishes order by id ASC;')

	@dish_types = DishType.all
	if params[:id]
		@dishes = Dish.where(dish_type_id: params[:id])
	else
		@dishes = Dish.all
	end
	erb :index
end

get '/dishes/new' do
	@dish_types = DishType.all
	erb :new
end
#create dishes
post '/dishes' do
	# sql = "INSERT INTO dishes (name, image_url) VALUES (#{params[:name]},#{params[:image_url]});"
	# dish = run_sql(sql)
	dish = Dish.new
	dish.name = params[:name]
	dish.image_url = params[:image_url]
	dish.dish_type_id = params[:dish_id]
	dish.save
	redirect to '/'
end
#show single dish
get '/dishes/:id' do
	# sql = "SELECT * FROM dishes WHERE id = #{params[:id]};"
	# @dish = run_sql(sql)[0] #or use .first instead of [0]
	@dish = Dish.find(params[:id])
	# @comments = Comment.where(dish_id: 1)
	@comments = @dish.comments
	erb :show
end
# update existing dish
get '/dishes/:id/edit' do
	# sql = "Select * from dishes where id = #{params[:id]}"
	# @dish = run_sql(sql).first ##database always returns a array like collection
	@dish = Dish.find(params[:id])
	@dish_types = DishType.all
	erb :edit
end

#edit dish and update
put '/dishes/:id' do
	# sql = "update dishes set name= '#{params[:name]}', image_url= '#{params[:image_url]}' where id = #{params[:id]};"
	# run_sql(sql)
	dish = Dish.find(params[:id])
	dish.name = params[:name]
	dish.image_url = params[:image_url]
	dish.dish_type_id = params[:dish_id]
	dish.save
	redirect to '/'
end

delete '/dishes/:id' do
	# sql = "delete from dishes where id=#{params[:id]};"
	# run_sql(sql)
	dish = Dish.find(params[:id])
	dish.delete
	redirect to '/'
end

post '/dishes/:dish_id/comments' do
	#create new comments for dish with id = :dish_id
	comment = Comment.new
	comment.body = params[:body]
	comment.dish_id = params[:dish_id]
	comment.save
	redirect to "/dishes/#{params[:dish_id] }"
end
