class ApplicationController < ActionController::Base
  # Basic認証の実装01
  before_action :basic_auth
  # //Basic認証の実装01
  # application_controller.rb ファイルにuserの追加カラムの保存を可能とする記述01
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン画面に遷移するように実装
  # before_action :authenticate_user!

  private
  # application_controller.rb ファイルにuserの追加カラムの保存を可能とする記述02
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kanji])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kanji])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_birth_date])
  end
  # //application_controller.rb ファイルにuserの追加カラムの保存を可能とする記述02
  # Basic認証の実装02
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数を読み込む記述に変更
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  # //Basic認証の実装02

end
