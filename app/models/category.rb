class Category < ActiveRecord::Base
  attr_accessible :description, :name, :imgFile

	 def imgFile=(file)
		uploadDir = "#{Rails.root.to_s}/public/category_images"
		newfilename = self.id.to_s
		#TODO extension (variable)
		#newfilename  += file.original_filename[-4,4] if file.original_filename.length > 3		
		 File.open(File.join(uploadDir, newfilename), "wb") { |f| f.write(file.read) }
  end


	def last_posts
		Post.where(:category_id => self.id).limit(3)
	end


end
