class HomeController < ApplicationController
  #caches_page :show
  
  def show
    do_show
  end
  
  def index
#    session[:notice] = ''
  end

  def errorpage
  end

  def emailsuccess
  end

  private

  def do_show

    if (params[:id] == 'errorpage')
      render :action => 'errorpage'
    elsif (params[:id] == 'emailsuccess')  
      render :action => 'emailsuccess'
    else
#      session[:notice] = ''
      render :action=>'index'
    end


  end

end
