if Rails.env.production?
  Braintree::Configuration.environment = :production
elsif !Rails.env.test?
  Braintree::Configuration.environment = :sandbox
end

Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
Braintree::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']
