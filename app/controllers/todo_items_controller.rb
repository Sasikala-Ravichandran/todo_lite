class TodoItemsController < ApplicationController

	before_action :set_todo_list, only: [ :create, :destroy, :complete]
	before_action :set_todo_item, except: [:index, :create]

	def index
		@todo_items = TodoItem.all
	end

	def create
		@todo_item = @todo_list.todo_items.build(todo_items_params)
		if @todo_item.save
			flash[:notice] = "Successfully an item created"
			respond_to do |format|
				format.html { redirect_to @todo_list }
				format.js
			end
		else
			render 'new', error: "Not created an item"
		end
	end

	def edit
	end

	def update
	end

	def destroy
		@todo_item.destroy
		respond_to do |format|
			format.html { redirect_to @todo_list }
			format.js
		end
	end

	def complete
		unless @todo_item.completed?
			flash[:notice] = "Todo item completed"
			@todo_item.update_attribute(:completed_at, Time.now)
		else 
			flash[:notice] = "Marked as not completed"
			@todo_item.update_attribute(:completed_at, nil)
		end
		respond_to do |format|
			format.html { redirect_to @todo_list }
			format.js
		end
	end

	private

		def todo_items_params
			params.require(:todo_item).permit(:content)
		end

		def set_todo_list
			@todo_list = TodoList.friendly.find(params[:todo_list_id])
		end

		def set_todo_item
			@todo_item = TodoItem.find(params[:id])
		end

end