FactoryBot.define do
  factory :refresh_token do
    user { nil }
    token { "MyString" }
    expires_at { "2025-08-07 00:15:34" }
    device_info { "MyText" }
    revoked_at { "2025-08-07 00:15:34" }
  end
end
