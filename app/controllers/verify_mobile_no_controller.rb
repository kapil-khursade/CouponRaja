class VerifyMobileNoController < ApplicationController
  def new
    redirect_to profile_path, notice: "no mobile no added!" if current_user.mobile_no.empty?
    if current_user.mobile_no_verified
      redirect_to profile_path, notice: "OTP Already Verified"
    end
    send_otp
  end

  def create
    if current_user.verify_otp(verify_mobile_no_params[:otp])
      redirect_to profile_path, notice: "OTP verfied!"
    else
      redirect_to profile_path, notice: "Wrong OTP entered!"
    end
  end

  private

  def verify_mobile_no_params
    params.permit(:otp, :authenticity_token, :commit)
  end

  def send_otp
    if current_user.otp_valid?
      flash.now[:notice] = "Valid otp already sent"
    else
      current_user.generate_otp
      current_user.send_otp_to_user
      flash.now[:notice] = "OTP sent!"
    end
  end
end
