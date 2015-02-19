class Brium::Client
  json_mapping({
    id: Int64,
    name: String,
    projects: Array(Project),
    active: Bool,
  })

  def initialize(id : Int, @name, @projects = [] of Project)
    @id = id.to_i64
  end
end

