class Brium::API::Error < Exception
  def initialize(@response)
    super("Brium::API::Error: #{@response.status_code}\n#{@response.body}")
  end
end
