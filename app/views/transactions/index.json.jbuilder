json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :creditCardNumber, :cardholderName, :type, :securityPass, :expirationDate, :price
  json.url transaction_url(transaction, format: :json)
end
