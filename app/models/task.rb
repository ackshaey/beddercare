class Task < ActiveRecord::Base
	# Belongs to association uses a singular form, 
	# as this sounds grammatically correct.
	# Need to create a new migration
	# rails generate migration add_user_id_to_tasks user_id:integer:index
	belongs_to :user
	# This one comes from paperclip
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.png"
end
