class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def azure_activedirectory_v2
        @user = User.from_omniauth(request.env["omniauth.auth"])

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication, notice: "Success!" # this will throw if @user is not activated
          else
            redirect_to root_path, alert: "Authentication error. Contact your administrator."
          end
    end
end