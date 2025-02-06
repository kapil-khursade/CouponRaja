class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :busine

  enum :coupon_type, [ :falt, :percent_off ]
  validates :code, presence: true, length: { is: 15 }, uniqueness: true

  before_validation :generate_unique_coupon_code, on: :create

  private

  def generate_unique_coupon_code
    return if code.present?  # Avoid overwriting existing code

    loop do
      self.code = SecureRandom.alphanumeric(15).upcase
      break unless Coupon.exists?(code: code)
    end
  end
end
