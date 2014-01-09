class Notifier < ActionMailer::Base

  def comments_received(recipient, subject, message, body, sent_at = Time.now)
    @subject = "No Uranium Mining in Virginia! Contact"
    @recipients = recipient
    @from = "banumva@banumva.org"
    @sent_on = sent_at
    @user_alias = body[:user_alias]
    @comments = body[:record_text]
    @created_at =   sent_at
  end

  def signature_comments(recipient, subject, message, body, sent_at = Time.now)
    @subject = "No Uranium Mining in Virginia! Petition signature"
    @recipients = recipient
    @from = "banumva@banumva.org"
    @sent_on = sent_at
    @signer_alias = body[:signer_alias]
    @comments = body[:comments]
    @created_at =   sent_at
  end

  def contact(params, sent_at = Time.now)
    @recipients  = "banumva@banumva.org"
    @from        = "banumva@banumva.org"
    @sent_on     = Time.now
    @subject = "No Uranium Mining in Virginia! Contact "
    @contact_alias = User.find(session["user_id"]).user_alias
    @email = User.find(session["user_id"]).email
    @comments = params[:comments]

  end


  def signup_notification(user)
    setup_email(user)
    @subject    += ' Please activate your new account'
    @url  = "http://"
    @url  = @url + "#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/user/activate/#{user.activation_code}/#{user.user_id}"

  end

  def activation(user)
    setup_email(user)
    @subject    += ' Your account has been activated!'
    @url  = "http://"
    @url = @url  + "#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/"
  end

  def reset_password_notification(user)
    setup_email(user)
    @subject    += ' Follow this link to reset your password'
    @url  = "http://"
    @url = @url  + "#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/user/reset_password/#{user.reset_code}"
  end

  def get_username_notification(user)
    setup_email(user)
    @subject    += ' Follow this link to learn your username'
    @url  = "http://"
    @url = @url  + "#{CollaboratorMethods.collaborator_value[:collaborator][:url]}/user/get_username/#{user.reset_code}"
  end

  private
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "banumva@banumva.org"
    @subject     = "Message From www.banumva.org"
    @sent_on     = Time.now
    @body[:user] = user

  end

  

  def do_contact(params, sent_at = Time.now)

    @subject = "No Uranium Mining in Virginia! Contact"
    @recipients = params[:email]
    @from = "banumva@banumva.org"
    @message = message
    @sent_on = sent_at
    @body = body


  end

end