class FairfaxMailer < ActionMailer::Base

  def send_mailgun_message(contact)
    @contact = contact
    RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
        "@api.mailgun.net/v3/sandboxd96942c1374a4cf3b410140c832edc9b.mailgun.org/messages",
        :from => "Mailgun Sandbox <postmaster@sandboxd96942c1374a4cf3b410140c832edc9b.mailgun.org>",
        :to => "#{@contact.first_name} #{@contact.last_name} <#{@contact.email}>",
        :subject => "Hello Sebastian Rubio",
        :text => "Congratulations #{@contact.first_name} #{@contact.last_name}, you just sent an email with Mailgun!"
    end
end
