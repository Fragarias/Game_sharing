# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :end_user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params #sign_in時許可するattribute
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    end_user_path(current_end_user)
  end
  def after_sign_out_path_for(resource)
    new_end_user_session_path
  end

  def guest_sign_in
    user = EndUser.guest
    sign_in user
    redirect_to root_path, notice: 'guestuserでログインしました。'
  end
  private
  # アクティブであるかを判断するメソッド
  def end_user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    end_user = EndUser.find_by(email: params[:end_user][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if end_user.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless end_user.valid_password?(params[:end_user][:password])

    # 【処理内容4】 アクティブでない会員に対する処理
    return if end_user.is_active == true
    redirect_to new_end_user_registration_path
  end

end
