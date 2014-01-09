include ApplicationHelper

class UserController < ApplicationController

  def logout
    
    session[:notice] = "Thank you for exploring www.banumva.org.  Please return soon."
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_url
    
  end

  def login_register

  end

  def show
    session[:notice] = ''
    if request.post?
      @current_user = User.find(:first, :readonly => true, :conditions=>['username = ?', params[:user][:username]])
      unless @current_user.blank?
        if @current_user.activation_code.blank? && @current_user.authenticated?(params[:user][:password])
          session[:user_id] = @current_user.user_id
          session[:notice] = "Welcome, #{@current_user.user_alias}"

          unless session[:required_login].blank?
            if session[:required_login] == "contribution"
              redirect_to contributions_new_url(session[:contribution_required_login])
            elsif session[:required_login] == "perspective"
              redirect_to perspectives_new_url
            elsif  session[:required_login] == "signature"
              redirect_to signatures_new_url
            end
          else
            redirect_to root_url
          end
        else
          unless @current_user.activation_code.blank?
            session[:notice] = "#{@current_user.username}, please check your email to activate your login."
            redirect_to root_url
          else @current_user.authenticated?(params[:user][:password])
            session[:notice] = "We have entered an incorrect password."
            render :action => 'show'
          end
        end
      else
        session[:notice] = "Sorry about this , but your username and/or password were not recognized by www.banumva.org.  Please try again.  If this problem persists, please use 'Contact Us' link below."
        render :action => 'show'
      end
    else
      @user = User.new
    end
  end 


  
def user_record
     session[:notice] = ''
@record_success = false
    if request.post?
      if params[:commit] == "Submit Updates"
        @record_success = update
        if @record_success
          session[:notice] = @current_user.user_alias + ", your updates have been successful"
          redirect_to root_url
        else
          ## Display errors message
          
        end
      elsif params[:commit] == "Register"
        @record_success = create
        if @record_success
          session[:notice] = "Thanks for signing up! Please check your email to activate your account."
          redirect_to root_url
        else
          render :action => 'user_record'
          
        end

      end

    else
      if params[:id]
        session[:user_commit] = "Submit Updates"
        session[:user_update_title] = "User Information Update"
        @user = User.find(:first, :readonly => true,:conditions => ['user_id = ?', params[:id]])
       
      else
        session[:notice] = ''
        @current_user = nil
        session[:user_id] = nil
        session[:user_commit] = "Register"
        session[:user_update_title] = "User Registration"
        @user = User.new
       
      end
      respond_to do |format|
        format.html
      end
    end

 
  end

  def create
    #    session[:notice] = ''
   
    @user = User.new(
      :username =>   params[:user][:username],
      :user_alias =>   params[:user][:user_alias],
      :password=>    params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation],
      :email => params[:user][:tmp_email],
      :remote_ip =>   params[:user][:remote_ip])
    if @user.save && @user.errors.empty?
      return true
    else
      return false
    end
   

  end

  def update
    session[:notice] = ''
    myupdatehash = Hash.new
    params[:user].each do |val|
      myupdatehash[val[0]] = val[1] unless val[1].blank? || val[0] == 'user_id'
    end



    begin
      @user = User.find(:first, :conditions=>['user_id = ?', params[:user][:user_id]])
      @user.update_attributes(myupdatehash)
      @user.delete_reset_code
    rescue Exception => msg
      session[:notice] = "Error in updating your record with system generated message: " + msg
      render :show
    else
      if @user.save()
        @current_user = @user
        session[:user_id] = @current_user.user_id
        return true
      else
        return false
      end
    end
  end



  def activate
    session[:notice] = ''
    @user = params[:activation_code].blank? ? false : User.find_by_user_id(params[:uid])
    unless @user.blank?
      unless @user.activation_code.blank?
        if @user.activate
          @current_user = @user
          session[:user_id] = @current_user.user_id
          session[:notice] = @current_user.user_alias + ", your registration activation is complete, and you are now logged in."
        else
          session[:notice] = "Failure in saving record."
        end


      else
        @current_user = @user
        session[:user_id] = @current_user.user_id
        session[:notice] = @current_user.user_alias + ", you have already activated your registration, and you are now logged in."


      end

    else
      session[:notice] = "Seems that you may have not properly copied the Activation url provided in your email.  Please try again."
    end

    redirect_to root_url
  end

  def forgot_password
    if request.post?
      forgot('password')
    else
      @user = User.new
    end
  end

  def forgot_username
    if request.post?
      forgot('username')
    else
      @user = User.new
    end
  end

  def forgot(which)
    session[:notice] = ''
    if request.post?
      @user = User.find(:first, :conditions => ['email = ?', params[:user][:email]])
      respond_to do |format|
        if !(@user.blank?)
          @user.create_reset_code(which)
          if which == 'username'
            Notifier.get_username_notification(@user).deliver if @user.recently_reset? && @user.recently_username_get?
            session[:notice] = "Path to retrieve username sent to #{@user.email}"
          else
            Notifier.reset_password_notification(@user).deliver if @user.recently_reset? && @user.recently_password_reset?
            session[:notice] = "Path to reset password code sent to #{@user.email}"
          end
          format.html { redirect_to root_url }
          
        else
          flash[:error] = "#{params[:user][:email]} does not exist in system"
          format.html { redirect_to root_url }
          
        end
      end
    end
  end

  def reset_password
    #    session[:notice] = ''
    @user = User.find_by_reset_code(params[:id]) unless params[:id].nil?
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        @user.delete_reset_code
        session[:notice] = "Password reset successfully for #{@user.email}. Please login"
        redirect_to root_url
      else
        render :action => :reset_password
      end
    end
  end

  def get_username
    #    session[:notice] = ''
    @user = User.find_by_reset_code(params[:id]) unless params[:id].nil?
    if @user
      @user.delete_reset_code
      session[:notice] = "Your username is #{@user.username}. Please login."
      redirect_to root_url
    else
      session[:notice] = "Your username was previously reported to you. Please try to login again."
      redirect_to root_url
    end
       
  end

end