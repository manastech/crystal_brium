require "spec"
require "../src/brium"

# At least we check it compiles ;-)

describe Brium::API do
  it "compiles" do
    typeof(begin
      client_id = "..."
      client_secret = "..."

      oauth_client = Brium.new_oauth_client(client_id, client_secret)
      access_token = OAuth2::AccessToken.from_json "..."

      session = OAuth2::Session.new(oauth_client, access_token) do
        puts "Refreshing access token..."
      end

      api = Brium::API.new session

      # Get workers
      workers = api.workers active: true, admin: false, suspended: false
      workers.each do |worker|
        worker.email
        worker.name
      end

      # Get clients
      clients = api.clients
      clients.each do |client|
        client.name
        client.projects.each do |project|
          project.name
        end
      end

      # Get entries
      entries = api.entries billable_status: "billable,billed"
      entries.each do |entry|
        entry.worked_at
        entry.record
      end

      # Or sum some entries hours
      total_hours = api.entries_sum billable_status: "billable,billed"
      total_hours + 1

      # Get holidays
      holidays = api.holidays kind: "vacations", since_date: 3.days.ago
      holidays.each do |holiday|
        holiday.from
        holiday.to
        holiday.kind
        holiday.worker_id
      end
    end)
  end
end
