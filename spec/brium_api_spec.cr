require "./spec_helper"

# At least we check it compiles ;-)

describe Brium::API do
  it "gets keywords" do
    WebMock.stub(:get, "https://brium.me/api/keywords.json")
           .with(headers: {"Host" => "brium.me", "Authorization" => "Bearer some_token"})
           .to_return(body: %<[{"keyword":"cepheid","budget":5678,"start":"2015-03-09","end":"2015-09-30","actual":193,"expected_end":"2016-12-12","billable":true}]>)

    api = Brium::API.new("some_token")
    keywords = api.keywords
    keywords.size.should eq(1)

    keyword = keywords.first
    keyword.keyword.should eq("cepheid")
    keyword.budget.should eq(5678)
  end

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
      clients = api.clients(active: true)
      clients.each do |client|
        client.id
        client.name
        client.active
        client.projects.each do |project|
          project.id
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

      # Or mark as billed
      api.mark_as_billed "client", Time.now, Time.now, billable_status: "billable,billed"

      # Get holidays
      holidays = api.holidays kind: "vacations", since_date: 3.days.ago
      holidays.each do |holiday|
        holiday.from
        holiday.to
        holiday.kind
        holiday.worker_id
      end

      # Get keywords
      keywords = api.keywords
      keywords.each do |keyword|
        keyword.keyword
        keyword.budget
        keyword.start
        keyword.end
        keyword.actual
        keyword.expected_end
        keyword.billable
      end

      Brium::API.new("access token")
    end)
  end
end
