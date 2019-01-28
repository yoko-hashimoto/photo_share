class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # add_flash_typesメソッドを使うと、flashのキーの指定が自由にできる
  add_flash_types :success, :info, :warning, :danger
  protect_from_forgery with: :exception

end
