class UsersController < ApplicationController

 before_filter(:only => [:edit , :update , :show, :chPw, :chPwUpdate ] ) { |c| c.auth  [ {:types =>  [User::BLOGGER, User::READER] , :condition => lambda{|params,session| params[:id].to_i == session[:userid]} } , {:types => [User::ADMIN]} ]  }
 before_filter(:only => [:destroy, :changeActive , :index, :loginAs] ) { |c| c.auth  [ {:types =>  [User::ADMIN]  }]  }


  #captcha
  include SimpleCaptcha::ControllerHelpers


  def chPw
    @user = User.find(params[:id])
  end

  def chPwUpdate
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Contraseña cambiada correctamente.'
      redirect_to(edit_user_path(@user)) 
    else
      render :action => "chPw" 
    end
  end

  # GET /users
  # GET /users.json
  def index
		@users = initialize_grid(User, {})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


	def login
		render
	end



  def verifyLogin
       @user = User.find_by_username_and_active(params[:login] ,  true)
      if @user and @user.password_is? params[:password]
        #TODO user should not be kept in the session because it can be modified (when user changes the profile session user should be loaded again)
         session[:userid] = @user.id
         flash[:notice] = 'login correct'
      else
         flash[:notice] = "Usuario, contraseña incorrectos o usuario no activo"
      end
       redirect_to :controller => 'posts' ,  :action => "index"

  end







	 def logout
    session.clear()
    redirect_to :controller => 'posts' ,  :action => "index"
  end


       def get_lost_password
                render
        end

        def lost_password
  				if simple_captcha_valid?
                username = params[:username]
                password  = [Array.new(8){rand(256).chr}.join].pack("m").chomp
                user = User.find_by_username_and_active(username, true)
                if user
                        user.password = password
                        if(user.save)
                                Notifier.lost_password(user.email,username, password).deliver
                                flash[:notice] =  'Contraseña enviada a la dirección de correo asociada'
                        else
                                flash[:notice] = 'No se ha podido generar una nueva contraseña'
                        end
                else
                        flash[:notice] = "User does not exist or is not active"
     										 render 'get_lost_password'
      									return
                end
  					else
               flash[:notice] = "Captcha not valid"
   						 render 'get_lost_password'
		    return
		  end
            redirect_to :controller=> "posts" , :action => 'index'
        end







	 def changeActive
    @user = User.find(params[:userid])

    @user.active = (! @user.active)
    if @user.save
			Notifier.user_change_active(@user.email, @user.username, @user.active).deliver
      flash[:notice] = 'Estado cambiado.'
     else
      ActiveRecord::Base.logger.warn   "errors saving user"
      @user.errors.each{|attr,msg|  ActiveRecord::Base.logger.warn   "#{attr} - #{msg}" }
      flash[:notice] = 'Estado no cambiado.'
    end
    redirect_to(users_url)
  end

  def loginAs
         session[:userid] = params[:userid]
         flash[:notice] = "login correct"
	       redirect_to :controller => 'posts' ,  :action => "index"

  end





  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

		if simple_captcha_valid?
			@user.active = false
      if @user.save
					Notifier.user_created(@user.username).deliver
					flash[:notice] = 'User was successfully created.'
         redirect_to :controller => "posts" ,:action => "index"
      else
        render :action => "new" 
      end
		else
				flash[:notice] = "Captcha not valid"
        render :action => "new" 
		end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
