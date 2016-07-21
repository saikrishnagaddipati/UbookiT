class Invoice < ApplicationRecord
	HEADERS = %w(order_id patient_id state)

	belongs_to :patient, foreign_key: :patient_id, primary_key: :patient_id
	belongs_to :order, foreign_key: :order_id, primary_key: :order_id

	def self.insert_or_update row
		invoice = find_or_initialize_by(order_id: row["order_id"], patient_id: row["patient_id"])
		invoice.update(row)
	end
end
