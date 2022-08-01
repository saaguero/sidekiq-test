require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/prometheus/exporter'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

# first, use IRB to create a shared secret key for sessions and commit it
require 'securerandom'; File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }

# now use the secret with a session cookie middleware
use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

# run Sidekiq::Prometheus::Exporter.to_app
Sidekiq::Web.register(Sidekiq::Prometheus::Exporter)

run Sidekiq::Web
