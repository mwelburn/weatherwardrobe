# TODO- right now we only have 1 API key
# weather underground APIkey
if Rails.env.development?
  WUNDERGROND_API = '241c0e4c6a9d746e'
elsif Rails.env.test?
  WUNDERGROND_API = '241c0e4c6a9d746e'
elsif Rails.env.production?
  WUNDERGROND_API = '241c0e4c6a9d746e'
end