class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  Ahoy.track_visits_immediately = true
  Ahoy.quiet   = false
  Ahoy.geocode = false
end
