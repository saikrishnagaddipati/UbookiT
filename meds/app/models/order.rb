class Order < ApplicationRecord
	HEADERS = %w(order_id category state)	

	scope :active_orders, -> { where state: "active" }

	has_many :invoices, -> { where state: "active" }, foreign_key: :order_id, primary_key: :order_id
	has_many :patients, -> { where state: "active" }, through: :invoices

	def self.insert_or_update row
		order = find_or_initialize_by(order_id: row["order_id"])
		order.update(row)
	end
end
