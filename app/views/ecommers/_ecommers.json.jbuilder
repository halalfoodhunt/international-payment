json.extract! ecommers, :id, :business_name, :general_contact, :general_email, :opening_hours, :operating_address, :business_description, :facebook, :instagram, :website, :delivery_url, :reservation_url, :merchant_id, :created_at, :updated_at
json.url ecommers_url(ecommers, format: :json)