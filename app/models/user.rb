class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable

  enum :role, [ :user, :sub_user, :admin ]
  has_one :dashboard
  has_many :busine
  has_many :coupon
  after_create :initiate_account

  def initiate_account
    create_dashboard
    generate_otp
  end

  def create_dashboard
   Dashboard.new(user_id: self.id).save!
  end

  def generate_otp
    self.otp = rand(100000..999999).to_s  # 6-digit OTP
    self.otp_sent_at = Time.current
    save(validate: false) # Save without triggering validations
  end

  def send_otp_to_user
    puts "Your Coupon Raja mobile number verification otp is #{otp}"
    # here will be the method to send the otp
  end

  def otp_valid?
    return false if otp_sent_at.nil?
    otp_sent_at > 30.minutes.ago # OTP expires in 10 minutes
  end

  def verify_otp(entered_otp)
    return false unless otp_valid?
    if otp == entered_otp
      update(otp: nil, otp_sent_at: nil, mobile_no_verified: true) # Clear OTP after successful verification
      true
    else
      false
    end
  end
end
