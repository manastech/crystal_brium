class Brium::API
  def self.new(access_token : String, host = nil, port = nil, ssl = false)
    oauth_client = Brium.new_oauth_client("dummy", "dummy")
    token = OAuth2::AccessToken::Bearer.new(access_token, 60 * 60 * 24 * 365 * 10)
    session = OAuth2::Session.new(oauth_client, token, expires_at: 10.years.from_now) {}
    new session, host, port, ssl
  end

  def initialize(@session : OAuth2::Session, host = nil, @port = nil, @ssl = false)
    @host = host || "brium.me"
  end

  def workers(active = nil, admin = nil, suspended = nil)
    params = CGI.build_form do |form|
      form.add "active", active.to_s unless active.nil?
      form.add "admin", admin.to_s  unless admin.nil?
      form.add "suspended", suspended.to_s unless suspended.nil?
    end

    response = get "/api/workers.json?#{params}"
    Array(Worker).from_json(response.body)
  end

  def clients(active = nil)
    params = CGI.build_form do |form|
      form.add "active", active.to_s unless active.nil?
    end

    response = get "/api/clients.json?#{params}"
    Array(Client).from_json(response.body)
  end

  def entries(client = nil,
              project = nil,
              worker = nil,
              billable_status = nil,
              record = nil,
              since_date = nil,
              until_date = nil)
    params = entries_filter(client, project, worker, billable_status, record, since_date, until_date)
    response = get "/api/entries.json?#{params}"
    Array(Entry).from_json(response.body)
  end

  def entries_sum(client = nil,
                  project = nil,
                  worker = nil,
                  billable_status = nil,
                  record = nil,
                  since_date = nil,
                  until_date = nil)
    params = entries_filter(client, project, worker, billable_status, record, since_date, until_date)
    response = get "/api/entries/sum.json?#{params}"
    response.body.to_f
  end

  def mark_as_billed(client, since_date, until_date,
                     project = nil,
                     worker = nil,
                     billable_status = nil,
                     record = nil)
    params = entries_filter(client, project, worker, billable_status, record, since_date, until_date)
    get "/api/entries/mark_as_billed?#{params}"
    nil
  end

  def holidays(kind = nil, worker_id = nil, since_date = nil, until_date = nil)
    params = CGI.build_form do |form|
      form.add "kind", kind if kind
      form.add "worker_id", worker_id if worker_id
      form.add "since", date_param(since_date)
      form.add "until", date_param(until_date)
    end

    response = get "/api/holidays.json?#{params}"
    Array(Holiday).from_json(response.body)
  end

  def keywords
    response = get "/api/keywords.json"
    Array(Keyword).from_json(response.body)
  end

  def self.handle(response : HTTP::Response)
    case response.status_code
    when 200, 201, 204
      yield
    else
      raise Brium::API::Error.new(response)
    end
  end

  private def entries_filter(client, project, worker, billable_status, record, since_date, until_date)
    CGI.build_form do |form|
      form.add "client", client if client
      form.add "project", project if project
      form.add "worker", worker if worker
      form.add "billable_status", billable_status if billable_status
      form.add "record", record if record
      form.add "since", date_param(since_date) if since_date
      form.add "until", date_param(until_date) if until_date
    end
  end

  private def date_param(time)
    time.is_a?(Time) ? time.to_s("%F") : time
  end

  private def get(uri)
    HTTP::Client.new(@host, @port, @ssl) do |client|
      @session.authenticate client
      response = client.get uri
      case response.status_code
      when 200, 201, 204
        response
      else
        raise Brium::API::Error.new(response)
      end
    end
  end
end
