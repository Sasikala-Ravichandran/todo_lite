class TodoList < ActiveRecord::Base
	has_many :todo_items
    extend FriendlyId
    friendly_id :title, use: [:slugged, :history] 
end
