class Line

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :id => id}))
    end
    lines
  end

  define_method(:==) do |line_to_compare|
    @name == line_to_compare.name() && @id == line_to_compare.id()
  end

  define_method(:update) do |new_name|
    @name = new_name
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lines WHERE id = #{@id};")
  end

  define_method(:stations) do
    stations_id = []
    connection_results = DB.exec("SELECT * FROM connections WHERE line_id = #{@id}")
    connection_results.each() do |result|
      stations_id.push(result.fetch("station_id"))
    end

    stations = []
    stations_id.each() do |station_id|
      station_result = DB.exec("SELECT * FROM stations WHERE id = #{station_id};")
      name = station_result.first().fetch("name")
      id = station_result.first().fetch("id").to_i()
      stations.push(Station.new(:name => name, :id => id))
    end
    stations
  end

end
