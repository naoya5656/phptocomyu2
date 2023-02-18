class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される
  add_flash_types :success, :info, :warning, :danger #フラッシュメッセージに色を追加

  def is_admin_access
    if admin_signed_in?
      return
    else
      redirect_to photos_path
    end
  end
  
  def after_sign_in_path_for(resource)
    flash[:success] = "ログインしました"
    photos_path
  end
  
  

protected #他コントローラーからも参照できる

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #ユーザー登録の際に、ユーザー名のデータ操作を許可している
end

end
