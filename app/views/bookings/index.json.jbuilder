json.array!(@bookings) do |booking|
  json.extract! booking, :id, :user_id, :transaction_id, :post_id
  json.url booking_url(booking, format: :json)
end
