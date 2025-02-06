class Busine < ApplicationRecord
  belongs_to :user
  has_many :coupon
  enum :valid_check_status, [ :not_validated, :validating, :valid_gstin, :validation_failed ]
  # Validations
  validates :gstin, presence: true, format: { with: /\A\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d{1}[Z]{1}[A-Z\d]{1}\z/, message: "is not a valid GSTIN format" }

  scope :validated, -> { where(valid_check_status: :valid_gstin) }
end
