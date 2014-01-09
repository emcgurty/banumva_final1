

class SignaturesController < ApplicationController

  # caches_page :show
  # expire_page :action => :show_refresh, :id => @signatures
  # cache_sweeper :signatures_sweeper
  
def create
      session[:notice] = ''
      begin
        @signatures = Signatures.new(
          :first_name =>params[:signatures][:first_name],
          :mi =>params[:signatures][:mi],
          :last_name =>params[:signatures][:last_name],
          :display_name =>params[:signatures][:display_name],
          :signer_alias =>params[:signatures][:signer_alias],
          :YOB =>params[:signatures][:YOB],
          :email =>params[:signatures][:email],
          :display_email =>params[:signatures][:display_email],
          :city =>params[:signatures][:city],
          :providence =>params[:signatures][:providence],
          :postal_code =>params[:signatures][:postal_code],
          :comments =>params[:signatures][:comments],
          :remote_ip =>params[:signatures][:remote_ip],
          :state_id =>params[:us_states],
          :country_id =>params[:countries],
          :user_id => session[:user_id],
          :created_at => Time.now,
          :updated_at => Time.now
        )

      rescue
        render :action => 'new'
      end

      if @signatures.save
        session[:notice] = 'Message successfully sent to '  + params[:signatures][:signer_alias] + '.'
        redirect_to show_refresh_url
      else
        #        session[:notice] = 'Message not successfully sent to '  + params[:signatures][:last_name] + '.'
        render :action => 'new'
      end

    
  end


  def edit

    session[:notice] = ''
    if request.post?
      @signatures = Signatures.find(params[:signatures][:uuid])
     myupdatehash = Hash.new
     myupdatehash[:state_id] = params[:us_states]
     myupdatehash[:country_id] = params[:countries]
    params[:signatures].each do |val|
      myupdatehash[val[0]] = val[1] unless val[0] == 'uuid'
    end
      

      @signatures.update_attributes(myupdatehash)
      if @signatures.save
        redirect_to show_refresh_url
      else
        render :action => 'edit'
      end
    else
      @signatures = Signatures.find(params[:id])
    end
  end


  def delete
    session[:notice] = ''
    if Signatures.find(params[:id]).destroy
      session[:notice] = "Your Signature has been deleted.  If you have misgivings in offering your Signature, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your concerns."
    else
      session[:notice] = "Database too busy, please try to delete your Signature again.
         If this matter persists, please contact www.banumva.org at 'Contact Us' in the footer of this web page with your difficulty.  Very much apologize."
    end
    redirect_to show_refresh_url
  end



  def show_refresh
     session[:notice] = ''
    do_show
  end
  
  def new
    session[:notice] = ''
    unless session[:user_id].blank?
      session[:required_login]= ""
      @signatures = Signatures.new
    else
      session[:required_login]= "signature"
      session[:notice] = "Very glad that you want to sign the 'No Uranium Mining in Virginia!', but registration or login is required"
      redirect_to user_login_register_url
    end
  end

   






















  private

  def do_show
    # TODO Not happy with this at all.  Just wish Rails would return a record number so that I could do an offset.
    unless params[:id].blank?
      @ct = 1
      @asd = true
      @break_out = false
      session[:start_id] = params[:id]
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC', :conditions => ['signature_number = true'])
      @ids_array = Array.new
      @signatures.each do |sign|
        if sign.uuid == params[:id] || @asd == false
          
          if @ct < 11
            @ids_array << sign.uuid unless sign.uuid.blank?
            @ct = @ct + 1
            @asd = false
          else
            @break_out = true
          end
        end
        break if @break_out
      end
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC', :conditions => ['uuid IN (?)', @ids_array])
    else
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC')
      session[:start_id] = ''
    end
  end


end















