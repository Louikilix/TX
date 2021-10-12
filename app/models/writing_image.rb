class WritingImage < ApplicationRecord
	has_one_attached :image
	validate :image?
	has_and_belongs_to_many :writing_definitions
	private
		def image?
		  # Clean exit if there is a logo
		  return if image.attached?

		  # Unless add error
		  errors.add(:base, 'Please upload your image.')

		  # Purge attachment
		  image.purge
		end
end