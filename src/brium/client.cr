class Brium::Client
  json_mapping({
    id: Int64,
    name: String,
    projects: Array(Project),
    active: Bool,
  })

  def initialize(id : Int, @name, @projects = [] of Project, @active = true)
    @id = id.to_i64
  end
end

