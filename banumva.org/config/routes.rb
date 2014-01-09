Petitions::Application.routes.draw do |map|
  
  map.admin_contact_us 'admin/contact_us', :controller => "admin", :action => "contact_us"
  map.signatures_new 'signatures/new', :controller => "signatures", :action => "new"
  map.signature_edit 'signatures/edit/:id', :controller => "signatures", :action => "edit"
  map.signature_delete 'signatures/delete/:id', :controller => "signatures", :action => "delete"
  map.show_refresh 'signatures/show_refresh/:id', :controller => "signatures", :action => "show_refresh"
  map.perspectives_edit 'perspectives/edit/:id', :controller => "perspectives", :action => "edit"
  map.perspectives_delete 'perspectives/delete/:id', :controller => "perspectives", :action => "delete"
  map.perspectives_new 'perspectives/new', :controller => "perspectives", :action => "new"
  map.perspectives_accept 'perspectives/accept', :controller => "perspectives", :action => "accept"
  map.perspectives_show 'perspectives/show', :controller => "perspectives", :action => "show"
  map.contributions_delete  'contributions/delete/:id', :controller => "contributions", :action => "delete"
  map.contributions_new  'contributions/new/:id', :controller => "contributions", :action => "new"
  map.contributions_list  'contributions/list/:id', :controller => "contributions", :action => "list"
  map.contributions_edit  'contributions/edit/:id', :controller => "contributions", :action => "edit"
  map.perspectives_accept 'perspectives/accept/:id', :controller => "perspectives", :action => "accept"
  map.collaborator_show 'collaborator/show', :controller => "collaborator", :action => "show"
  map.home_show 'home/show', :controller => "home", :action => "show"
  map.home_errorpage 'home/errorpage/:error_msg', :controller => "home", :action => "errorpage"
  map.user_show 'user/show', :controller => "user", :action => "show"
  map.user_user_record 'user/new/:id', :controller => "user", :action => "user_record"
  map.user_reset_password 'user/reset_password/:id', :controller => "user", :action => "reset_password"
  map.user_forgot_username 'user/forgot_username', :controller => "user", :action => "forgot_username"
  map.user_forgot_password 'user/forgot_password', :controller => "user", :action => "forgot_password"
  map.user_logout 'user/logout', :controller => "user", :action => "logout"
  map.user_login_register 'user/login_register', :comtroller => "user", :action => "login_register"
  map.user_update_user_information 'user/update_user_information/:id', :controller => "user", :action => "update_user_information"
  map.activate 'user/activate/:activation_code/:uid', :controller => "user", :action => "activate"
  map.root :controller => "home"
  map.connect ':controller/:action/:id'

end




