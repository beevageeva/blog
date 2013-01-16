# encoding: utf-8
class Notifier < ActionMailer::Base

 default :from => "admin@#{Blog::Application.config.MAIL_DOMAIN}"



 def lost_password(email, username, password)
	@username = username
	@password = password
	 mail(:to => email, :subject => "Contrasena generada")	
   end

 def user_change_active(email, username, active)
	@username = username
	@active = active
	 mail(:to => email, :subject => "User State changed " )	
   end



#notify admins methods
 def user_created( username)
	emails = User.where({:account_type => User::ADMIN, :active => true}).pluck("email")
	@username = username
	 mail(:to => emails, :subject => "User created")	
   end

	




end
