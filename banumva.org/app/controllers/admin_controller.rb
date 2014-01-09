class AdminController < ApplicationController

  def contact_us
    if request.post?
      if params[:commit] == "Contact banumva"
        @ve = true
        @ve = valid_email(params[:contact_us][:email])  unless params[:contact_us][:email].blank?
        unless !(@ve) || (params[:contact_us][:email].blank? &&  params[:contact_us][:comments].blank? && params[:contact_us][:user_alias].blank?)

          begin
            Notifier.contact(params[:contact_us]).deliver
            session[:notice] = "Thank you for contacting 'No Uranium Mining in VA!' with your comment: #{params[:contact_us][:comments]}"
            redirect_to root_url
            return
          rescue Exception => e
            @error_msg = "'No Uranium Mining in VA!' was unable forward your 'Contact Us' email, please try later:#{e.class};#{e.message.strip}"
            redirect_to :controller => 'home', :action => 'errorpage', :error_msg => @error_msg
            return
          end

        else
          flash_msg = ''
          if params[:contact_us][:email].blank?
            flash_msg << "<br/>Your email address is required"
          else
            @ve  ? "" : flash_msg << "<br/>Your email address is not properly formatted"
          end
          if params[:contact_us][:comments].blank?
            flash_msg << "<br/>Your comment is required"
          end
          if params[:contact_us][:user_alias].blank?
            flash_msg << "<br/>Your subject is required"
          end
          session[:notice] = flash_msg
          #          @contact_us = Array.new
          #          @contact_us << {"email" => params[:contact_us][:email], "comments" => params[:contact_us][:comments], "user_alias" => params[:contact_us][:user_alias]}
          #          respond_to do |format|
          #            format.html
          #          end
        end
      end
    
    else
      @contact_us = Array.new
      @contact_us << {"email" => '', "comments" => '', "user_alias" => ''}
      respond_to do |format|
        format.html
      end
    end

  end
  
end
