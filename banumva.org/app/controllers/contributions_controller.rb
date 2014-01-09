class ContributionsController < ApplicationController

  def new
    session[:notice] = ''
    unless session[:user_id].blank?
      session[:required_login]= ""
      @contributions = Contributions.new(:p_uuid => params[:id])
    else
      session[:required_login]= "contribution"
      session[:contribution_required_login] = params[:id]
      session[:notice] = "Very glad that you want to response to a Perspective, but registration or login is required."
      redirect_to user_login_register_url
    end
  end

  def list
    @contributions = Contributions.find(:all, :readonly => true, :conditions => ['p_uuid = ?',params[:id]] )
    respond_to do |format|
      format.html
    end
    
  end

  def edit
    @contributions = Contributions.find(params[:id])
  end
   
  def delete
    session[:notice] = ''
    if Contributions.find(params[:id]).destroy
      session[:notice] = "Your Contribution has been deleted.  If you have misgivings in offering your Perspective Response, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your concerns."
    else
      session[:notice] = "Database too busy, please try to delete your Perspective Response again.
         If this matter persists, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your difficulty.  Very much apologize."
    end
    redirect_to perspectives_show_url
  end

  def create
    @contributions = Contributions.new(
      :p_uuid => params[:comments][:p_uuid],
      :remote_ip => params[:comments][:remote_ip],
      :record_text   => params[:comments][:record_text],
      :user_id => session[:user_id]
    )
    if @contributions.save
      session[:notice] = 'Message successfully sent to '  + User.find(session[:user_id]).email + '.'
      redirect_to perspectives_show_url
    else
      render :action => 'new'
      
    end

  end

  def update
    begin
      @tmp = Contributions.find(params[:c_uuid])
      @tmp.update_attributes(:record_text => params[:record_text], :remote_ip => params[:remote_ip] )
    rescue ActiveRecord::RecordNotFound
      render :action => 'edit'
    rescue ActiveRecord::ActiveRecordError => msg
      render :action => 'edit'
      
    else
      session[:notice] = "Your record has been successfully updated"
      redirect_to perspectives_show_url
    end
  end

end
