class ApplicationController < ActionController::Base
  # Basic認証の実装01
  before_action :basic_auth
  # //Basic認証の実装01

  private

  # Basic認証の実装02
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 環境変数を読み込む記述に変更
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  # //Basic認証の実装02

end
