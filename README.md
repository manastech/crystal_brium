### crystal_brium

Access [Brium](http://brium.me)'s API using Crystal.

#### Projectfile

```crystal
deps do
  github "manastech/crystal_brium"
end
```

#### Usage

```crystal
require "brium"

client_id = "..."
client_secret = "..."

oauth_client = Brium.new_oauth_client(client_id, client_secret)
access_token = # some OAuth2::AccessToken

session = OAuth2::Session.new(oauth_client, access_token) do
  puts "Refreshing access token..."
end

api = Brium::API.new session

# Get workers
workers = api.workers active: true, admin: false, suspended: false

# Get clients
clients = api.clients

# Get entries
entries = api.entries billable_status: "billable,billed"

# Or sum some entries hours
total_hours = api.entries_sum billable_status: "billable,billed"

# Get holidays
holidays = api.holidays kind: "vacations", since_date: 3.days.ago
```
