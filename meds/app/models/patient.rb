class Patient < ApplicationRecord
	HEADERS = %w(patient_id	patient_name state)

	has_many :invoices, -> { where state: "active" }, foreign_key: :order_id, primary_key: :order_id
	has_many :orders, -> { where state: "active" }, through: :invoices

	def self.insert_or_update row
		patient = find_or_initialize_by(patient_id: row["patient_id"])
		patient.update(row)
	end
end
