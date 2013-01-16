class ApplicationController < ActionController::Base

  protect_from_forgery



	protected 

	def auth(typeMethods)
	  if  session[:userid]
			if typeMethods.nil?
				return true
			else
    		userType = User.find(session[:userid]).account_type
		    typeMethods.each do |tm|
		      tm[:types].each do |x|
		        if x==userType
		          return true if tm[:condition].nil? or tm[:condition].call(params, session)
		        end
		      end
		    end
			end
		end
		redirect_to login_url
    return false

	end



end
