class PerspectivesController < ApplicationController

  #  before_filter :user_delete,  :only=>[:delete]
  # cache_sweeper :perspectives_sweeper
  def update
    begin
      @tmp = Perspectives.find(params[:p_uuid])
      @tmp.update_attributes(:record_text => params[:record_text], :remote_ip => params[:remote_ip] )
      @tmp.save
    rescue ActiveRecord::RecordNotFound
      @error_msg = "Record not found in 'Update/Edit' perspectives function"
      render :action => 'new'
    rescue ActiveRecord::ActiveRecordError
      @error_msg = "Active Record Error in 'Update?Edit' perspectives function"
      render :action => 'new'
    else
      session[:notice] = "Your record has been successfully updated"
      redirect_to perspectives_show_url
    end
  end

  def new
     session[:notice] = ''
     unless session[:user_id].blank?
      session[:required_login]= ""
      @perspectives = Perspectives.new
    else
      session[:required_login]= "perspective"
      session[:notice]  = "Very glad that you want to provide your Perspective, but registration or login is required."
      redirect_to user_login_register_url
    end
  end

  def create
    do_create
  end


  def show
    do_show
  end

  def edit
    @perspectives = Perspectives.find(params[:id], :conditions => ['user_id =?', session[:user_id]])
   
	end

  def confirm
    @perspectives = Perspectives.find(params[:id], :readonly => true)
  end
  
  def delete
    session[:notice] = ''
    if Perspectives.find(params[:id]).destroy
      session[:notice] = "Your Perspective has been deleted.  If you have misgivings in offering your Perspective, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your concerns."
    else
      session[:notice] = "Database too busy, please try to delete your Perspective again.
         If this matter persists, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your difficulty.  Very much apologize."
    end
    redirect_to perspectives_show_url
  end

  def accept
    do_accept
  end

  private

  def do_accept
    @myid = Perspectives.find(params[:id])
  end

  def do_create

    @perspectives = Perspectives.new(
      :remote_ip => params[:perspectives][:remote_ip],
      :record_text     => params[:perspectives][:record_text],
      :user_id => session[:user_id]
    )
    if @perspectives.save
      session[:notice] = 'Message successfully sent to '  + User.find(session[:user_id]).email + '.'
      redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
    else
      render :action => 'new'
    end
  end


  def do_show
    begin
      @perspectives = Perspectives.find(:all, :readonly=> true)
    rescue
      error_msg = "Invalid statement discovered in Listing Perspectives."
      redirect_to :controller=>'home', :action => 'error_page', :error_msg => error_msg
    end

  end

  
  
end


