class Menu < ActiveRecord::Base
	scope :select_main_menu, lambda{where("main_id is null")}
	scope :sorted_created_at, lambda{order("created_at")}
end
