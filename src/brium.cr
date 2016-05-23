require "json"
require "oauth2"
require "./**"

module Brium
  def self.new_oauth_client(client_id, client_secret, redirect_uri = "urn:ietf:wg:oauth:2.0:oob")
    OAuth2::Client.new(
      "brium.me",
      client_id,
      client_secret,
      redirect_uri: redirect_uri,
      port: 80,
      scheme: "https",
    )
  end
end
